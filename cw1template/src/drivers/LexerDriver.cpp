#include <cctype>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

#include "antlr4-runtime/antlr4-runtime.h"

#include "CoolLexer.h"

using namespace std;
using namespace antlr4;

/// Преобразува жетон в текст, който очаква системата за проверка на курсовата работа (част 1).
string cool_token_to_string(Token *token) {
    auto token_type = token->getType();

    switch (token_type) {
        case static_cast<size_t>(-1) : return "EOF";

        case CoolLexer::SEMI: return "';'";
        // Добавете тук останалите жетони, които представляват само един символ.

        case CoolLexer::DARROW: return "DARROW";
        case CoolLexer::BOOL_CONST: return "BOOL_CONST";
        // Добавете тук останалите валидни жетони (включително и ERROR).

        default : return "<Invalid Token>: " + token->toString();
    }
}

void dump_cool_token(CoolLexer *lexer, ostream &out, Token *token) {
    if (token->getType() == static_cast<size_t>(-1)) {
        // Жетонът е EOF, така че не го принтирам.
        return;
    }

    out << "#" << token->getLine() << " " << cool_token_to_string(token);

    auto token_type = token->getType();
    auto token_start_char_index = token->getStartIndex();
    switch (token_type) {
    case CoolLexer::BOOL_CONST:
        out << " "
            << (lexer->get_bool_value(token_start_char_index) ? "true"
                                                              : "false");
        break;
    // Добавете тук още случаи, за жетони, към които е прикачен специален смисъл.
    }

    out << endl;
}

int main(int argc, const char *argv[]) {
    ANTLRInputStream input(cin);
    CoolLexer lexer(&input);

    // За временно скриване на грешките:
    // lexer.removeErrorListener(&ConsoleErrorListener::INSTANCE);

    CommonTokenStream tokenStream(&lexer);

    tokenStream.fill(); // Изчитане на всички жетони.

    vector<Token *> tokens = tokenStream.getTokens();
    for (Token *token : tokens) {
        dump_cool_token(&lexer, cout, token);
    };

    return 0;
}
