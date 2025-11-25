
// Generated from /code/tools/../src/CoolParser.g4 by ANTLR 4.13.2

#pragma once

#include "antlr4-runtime.h"

class CoolParser : public antlr4::Parser {
  public:
    enum {
        SEMI = 1,
        OCURLY = 2,
        CCURLY = 3,
        OPAREN = 4,
        COMMA = 5,
        CPAREN = 6,
        COLON = 7,
        AT = 8,
        DOT = 9,
        PLUS = 10,
        MINUS = 11,
        STAR = 12,
        SLASH = 13,
        TILDE = 14,
        LT = 15,
        EQ = 16,
        DARROW = 17,
        ASSIGN = 18,
        LE = 19,
        CLASS = 20,
        ELSE = 21,
        FI = 22,
        IF = 23,
        IN = 24,
        INHERITS = 25,
        ISVOID = 26,
        LET = 27,
        LOOP = 28,
        POOL = 29,
        THEN = 30,
        WHILE = 31,
        CASE = 32,
        ESAC = 33,
        NEW = 34,
        OF = 35,
        NOT = 36,
        BOOL_CONST = 37,
        INT_CONST = 38,
        OBJECTID = 39,
        TYPEID = 40,
        WS = 41,
        STR_BEGIN = 42,
        COMM_BEGIN = 43,
        COMM_ERR1 = 44,
        LCOMM_BEGIN = 45,
        ERROR = 46,
        STR_CONST = 47,
        STR_END = 48,
        STR_ESC_NL = 49,
        ESC_BS = 50,
        ESC_FF = 51,
        ESC_TAB = 52,
        ESC_NULL = 53,
        ESC_ANY = 54,
        NULL_ = 55,
        STR_NL = 56,
        STR_ERR = 57,
        STR_ANY = 58,
        ESTR_END = 59,
        ESTR_ESC_NL = 60,
        ESTR_NL = 61,
        ESTR_ANY = 62,
        OCOMM = 63,
        CCOMM = 64,
        COMM_SKIP = 65,
        COMM_ERR = 66,
        LCOMM_END = 67,
        LCOMM_SKIP = 68
    };

    enum {
        RuleProgram = 0,
        RuleClass = 1,
        RuleMethod = 2,
        RuleAttr = 3,
        RuleFormal = 4,
        RuleExpr = 5,
        RuleVardecl = 6
    };

    explicit CoolParser(antlr4::TokenStream *input);

    CoolParser(antlr4::TokenStream *input,
               const antlr4::atn::ParserATNSimulatorOptions &options);

    ~CoolParser() override;

    std::string getGrammarFileName() const override;

    const antlr4::atn::ATN &getATN() const override;

    const std::vector<std::string> &getRuleNames() const override;

    const antlr4::dfa::Vocabulary &getVocabulary() const override;

    antlr4::atn::SerializedATNView getSerializedATN() const override;

    class ProgramContext;
    class ClassContext;
    class MethodContext;
    class AttrContext;
    class FormalContext;
    class ExprContext;
    class VardeclContext;

    class ProgramContext : public antlr4::ParserRuleContext {
      public:
        ProgramContext(antlr4::ParserRuleContext *parent, size_t invokingState);
        virtual size_t getRuleIndex() const override;
        std::vector<ClassContext *> class_();
        ClassContext *class_(size_t i);
        std::vector<antlr4::tree::TerminalNode *> SEMI();
        antlr4::tree::TerminalNode *SEMI(size_t i);

        virtual std::any
        accept(antlr4::tree::ParseTreeVisitor *visitor) override;
    };

    ProgramContext *program();

    class ClassContext : public antlr4::ParserRuleContext {
      public:
        ClassContext(antlr4::ParserRuleContext *parent, size_t invokingState);
        virtual size_t getRuleIndex() const override;
        antlr4::tree::TerminalNode *CLASS();
        std::vector<antlr4::tree::TerminalNode *> TYPEID();
        // TYPEID(0) is the class name and TYPEID(1) is the inherited class, if
        // there is an "inherits" clause in the class definition
        antlr4::tree::TerminalNode *TYPEID(size_t i);
        antlr4::tree::TerminalNode *OCURLY();
        antlr4::tree::TerminalNode *CCURLY();
        antlr4::tree::TerminalNode *INHERITS();
        std::vector<antlr4::tree::TerminalNode *> SEMI();
        antlr4::tree::TerminalNode *SEMI(size_t i);
        std::vector<MethodContext *> method();
        MethodContext *method(size_t i);
        std::vector<AttrContext *> attr();
        AttrContext *attr(size_t i);

        virtual std::any
        accept(antlr4::tree::ParseTreeVisitor *visitor) override;
    };

    ClassContext *class_();

    class MethodContext : public antlr4::ParserRuleContext {
      public:
        MethodContext(antlr4::ParserRuleContext *parent, size_t invokingState);
        virtual size_t getRuleIndex() const override;
        antlr4::tree::TerminalNode *OBJECTID();
        antlr4::tree::TerminalNode *OPAREN();
        antlr4::tree::TerminalNode *CPAREN();
        antlr4::tree::TerminalNode *COLON();
        antlr4::tree::TerminalNode *TYPEID();
        antlr4::tree::TerminalNode *OCURLY();
        ExprContext *expr();
        antlr4::tree::TerminalNode *CCURLY();
        std::vector<FormalContext *> formal();
        FormalContext *formal(size_t i);
        std::vector<antlr4::tree::TerminalNode *> COMMA();
        antlr4::tree::TerminalNode *COMMA(size_t i);

        virtual std::any
        accept(antlr4::tree::ParseTreeVisitor *visitor) override;
    };

    MethodContext *method();

    class AttrContext : public antlr4::ParserRuleContext {
      public:
        AttrContext(antlr4::ParserRuleContext *parent, size_t invokingState);
        virtual size_t getRuleIndex() const override;
        antlr4::tree::TerminalNode *OBJECTID();
        antlr4::tree::TerminalNode *COLON();
        antlr4::tree::TerminalNode *TYPEID();
        antlr4::tree::TerminalNode *ASSIGN();
        ExprContext *expr();

        virtual std::any
        accept(antlr4::tree::ParseTreeVisitor *visitor) override;
    };

    AttrContext *attr();

    class FormalContext : public antlr4::ParserRuleContext {
      public:
        FormalContext(antlr4::ParserRuleContext *parent, size_t invokingState);
        virtual size_t getRuleIndex() const override;
        antlr4::tree::TerminalNode *OBJECTID();
        antlr4::tree::TerminalNode *COLON();
        antlr4::tree::TerminalNode *TYPEID();

        virtual std::any
        accept(antlr4::tree::ParseTreeVisitor *visitor) override;
    };

    FormalContext *formal();

    class ExprContext : public antlr4::ParserRuleContext {
      public:
        ExprContext(antlr4::ParserRuleContext *parent, size_t invokingState);
        virtual size_t getRuleIndex() const override;
        std::vector<antlr4::tree::TerminalNode *> OBJECTID();
        antlr4::tree::TerminalNode *OBJECTID(size_t i);
        antlr4::tree::TerminalNode *OPAREN();
        antlr4::tree::TerminalNode *CPAREN();
        std::vector<ExprContext *> expr();
        ExprContext *expr(size_t i);
        std::vector<antlr4::tree::TerminalNode *> COMMA();
        antlr4::tree::TerminalNode *COMMA(size_t i);
        antlr4::tree::TerminalNode *IF();
        antlr4::tree::TerminalNode *THEN();
        antlr4::tree::TerminalNode *ELSE();
        antlr4::tree::TerminalNode *FI();
        antlr4::tree::TerminalNode *WHILE();
        antlr4::tree::TerminalNode *LOOP();
        antlr4::tree::TerminalNode *POOL();
        antlr4::tree::TerminalNode *OCURLY();
        antlr4::tree::TerminalNode *CCURLY();
        std::vector<antlr4::tree::TerminalNode *> SEMI();
        antlr4::tree::TerminalNode *SEMI(size_t i);
        antlr4::tree::TerminalNode *CASE();
        antlr4::tree::TerminalNode *OF();
        antlr4::tree::TerminalNode *ESAC();
        std::vector<antlr4::tree::TerminalNode *> COLON();
        antlr4::tree::TerminalNode *COLON(size_t i);
        std::vector<antlr4::tree::TerminalNode *> TYPEID();
        antlr4::tree::TerminalNode *TYPEID(size_t i);
        std::vector<antlr4::tree::TerminalNode *> DARROW();
        antlr4::tree::TerminalNode *DARROW(size_t i);
        antlr4::tree::TerminalNode *NEW();
        antlr4::tree::TerminalNode *TILDE();
        antlr4::tree::TerminalNode *ISVOID();
        antlr4::tree::TerminalNode *NOT();
        antlr4::tree::TerminalNode *ASSIGN();
        antlr4::tree::TerminalNode *LET();
        std::vector<VardeclContext *> vardecl();
        VardeclContext *vardecl(size_t i);
        antlr4::tree::TerminalNode *IN();
        antlr4::tree::TerminalNode *INT_CONST();
        antlr4::tree::TerminalNode *STR_CONST();
        antlr4::tree::TerminalNode *BOOL_CONST();
        antlr4::tree::TerminalNode *STAR();
        antlr4::tree::TerminalNode *SLASH();
        antlr4::tree::TerminalNode *PLUS();
        antlr4::tree::TerminalNode *MINUS();
        antlr4::tree::TerminalNode *EQ();
        antlr4::tree::TerminalNode *LT();
        antlr4::tree::TerminalNode *LE();
        antlr4::tree::TerminalNode *DOT();
        antlr4::tree::TerminalNode *AT();

        virtual std::any
        accept(antlr4::tree::ParseTreeVisitor *visitor) override;
    };

    ExprContext *expr();
    ExprContext *expr(int precedence);
    class VardeclContext : public antlr4::ParserRuleContext {
      public:
        VardeclContext(antlr4::ParserRuleContext *parent, size_t invokingState);
        virtual size_t getRuleIndex() const override;
        antlr4::tree::TerminalNode *OBJECTID();
        antlr4::tree::TerminalNode *COLON();
        antlr4::tree::TerminalNode *TYPEID();
        antlr4::tree::TerminalNode *ASSIGN();
        ExprContext *expr();

        virtual std::any
        accept(antlr4::tree::ParseTreeVisitor *visitor) override;
    };

    VardeclContext *vardecl();

    bool sempred(antlr4::RuleContext *_localctx, size_t ruleIndex,
                 size_t predicateIndex) override;

    bool exprSempred(ExprContext *_localctx, size_t predicateIndex);

    // By default the static state used to implement the parser is lazily
    // initialized during the first call to the constructor. You can call this
    // function if you wish to initialize the static state ahead of time.
    static void initialize();

  private:
};
