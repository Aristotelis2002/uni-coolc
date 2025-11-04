#include <cctype>
#include <filesystem>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

#include "antlr4-runtime/antlr4-runtime.h"

#include "CoolLexer.h"
#include "CoolParser.h"
#include "CoolParserBaseVisitor.h"

using namespace std;
using namespace antlr4;

namespace fs = filesystem;

/// Converts token to coursework-specific string representation.
string cool_token_to_string(CoolLexer *lexer, Token *token) {
    auto token_type = token->getType();

    // clang-format off
    switch (token_type) {
        case static_cast<size_t>(-1) : return "EOF";

        case CoolLexer::SEMI   : return "';'";
        case CoolLexer::OCURLY : return "'{'";
        case CoolLexer::CCURLY : return "'}'";
        case CoolLexer::OPAREN : return "'('";
        case CoolLexer::COMMA  : return "','";
        case CoolLexer::CPAREN : return "')'";
        case CoolLexer::COLON  : return "':'";
        case CoolLexer::AT     : return "'@'";
        case CoolLexer::DOT    : return "'.'";
        case CoolLexer::PLUS   : return "'+'";
        case CoolLexer::MINUS  : return "'-'";
        case CoolLexer::STAR   : return "'*'";
        case CoolLexer::SLASH  : return "'/'";
        case CoolLexer::TILDE  : return "'~'";
        case CoolLexer::LT     : return "'<'";
        case CoolLexer::EQ     : return "'='";

        case CoolLexer::DARROW : return "DARROW";
        case CoolLexer::ASSIGN : return "ASSIGN";
        case CoolLexer::LE     : return "LE";

        case CoolLexer::CLASS  : return "CLASS";
        case CoolLexer::ELSE   : return "ELSE";
        case CoolLexer::FI     : return "FI";
        case CoolLexer::IF     : return "IF";
        case CoolLexer::IN     : return "IN";
        case CoolLexer::INHERITS : return "INHERITS";
        case CoolLexer::ISVOID : return "ISVOID";
        case CoolLexer::LET    : return "LET";
        case CoolLexer::LOOP   : return "LOOP";
        case CoolLexer::POOL   : return "POOL";
        case CoolLexer::THEN   : return "THEN";
        case CoolLexer::WHILE  : return "WHILE";
        case CoolLexer::CASE   : return "CASE";
        case CoolLexer::ESAC   : return "ESAC";
        case CoolLexer::NEW    : return "NEW";
        case CoolLexer::OF     : return "OF";
        case CoolLexer::NOT    : return "NOT";

        case CoolLexer::BOOL_CONST : return "BOOL_CONST";
        case CoolLexer::INT_CONST  : return "INT_CONST = " + token->getText();
        case CoolLexer::STR_CONST  : return "STR_CONST";
        case CoolLexer::TYPEID     : return "TYPEID = " + token->getText();
        case CoolLexer::OBJECTID   : return "OBJECTID = " + token->getText();
        case CoolLexer::ERROR      : return "ERROR";

        default : return "<Invalid Token>: " + token->toString();
    }
    // clang-format on
}

class TreePrinter : public CoolParserBaseVisitor {
  private:
    CoolLexer *lexer_;
    CoolParser *parser_;
    string file_name_;

  public:
    TreePrinter(CoolLexer *lexer, CoolParser *parser, const string &file_name)
        : lexer_(lexer), parser_(parser), file_name_(file_name) {}

    any visitProgram(CoolParser::ProgramContext *ctx) override {
        cout << '#' << ctx->getStop()->getLine() << endl;
        cout << "_program" << endl;
        visitChildren(ctx);

        return any{};
    }

    any visitClass(CoolParser::ClassContext *ctx) override {
        cout << "  #" << ctx->getStop()->getLine() << endl;
        cout << "  _class" << endl;
        cout << "    " << ctx->TYPEID()->getText() << endl;
        cout << "    " << "Object" << endl;
        cout << "    \"" << file_name_ << '"' << endl;
        cout << "    " << '(' << endl;
        cout << "    " << ')' << endl;

        return any{};
    }

  public:
    void print() { visitProgram(parser_->program()); }
};

class ErrorPrinter : public BaseErrorListener {
  private:
    string file_name_;
    CoolLexer *lexer_;
    bool has_error_ = false;

  public:
    ErrorPrinter(const string &file_name, CoolLexer *lexer)
        : file_name_(file_name), lexer_(lexer) {}

    virtual void syntaxError(Recognizer *recognizer, Token *offendingSymbol,
                             size_t line, size_t charPositionInLine,
                             const std::string &msg,
                             std::exception_ptr e) override {
        has_error_ = true;
        cout << '"' << file_name_ << "\", line " << line
             << ": syntax error at or near "
             << cool_token_to_string(lexer_, offendingSymbol) << endl;
    }

    bool has_error() const { return has_error_; }
};

int main(int argc, const char *argv[]) {
    if (argc != 2) {
        cerr << "Expecting exactly one argument: name of input file" << endl;
        return 1;
    }

    auto file_path = argv[1];
    ifstream fin(file_path);

    auto file_name = fs::path(file_path).filename().string();

    ANTLRInputStream input(fin);
    CoolLexer lexer(&input);

    CommonTokenStream tokenStream(&lexer);

    CoolParser parser(&tokenStream);

    ErrorPrinter error_printer(file_name, &lexer);

    parser.removeErrorListener(&ConsoleErrorListener::INSTANCE);
    parser.addErrorListener(&error_printer);

    // This will trigger the error_printer, in case there are errors.
    parser.program();
    parser.reset();

    if (!error_printer.has_error()) {
        TreePrinter(&lexer, &parser, file_name).print();
    } else {
        cout << "Compilation halted due to lex and parse errors" << endl;
    }

    return 0;
}
