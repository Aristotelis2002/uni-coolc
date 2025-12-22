
// Generated from /code/tools/../src/CoolLexer.g4 by ANTLR 4.13.2

#pragma once

#include "antlr4-runtime.h"

class CoolLexer : public antlr4::Lexer {
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

    enum { STR = 1, ESTR = 2, COMM = 3, LCOMM = 4 };

    explicit CoolLexer(antlr4::CharStream *input);

    ~CoolLexer() override;

    enum class ErrorCode {
        STR_CONTAINS_ESC_NULL,
        STR_CONTAINS_NULL,
        STR_CONTAINS_NEW_LINE,
        STR_CONTAINS_EOF,
        STR_TOO_LONG,
        COMMENT_CONTAINS_EOF,
        UNMATCHED_COMMENT_END,
        INVALID_SYMBOL
    };

    // Maximum length of a constant string literal (CSL) excluding the implicit
    // null character that marks the end of the string.
    const unsigned MAX_STR_CONST = 1024;
    // Stores the current CSL as it's being built.
    std::vector<char> string_buffer;

    int add_char_to_str(char c);

    // ----------------------- booleans -------------------------

    // A map from token ids to boolean values
    std::map<int, bool> bool_values;

    void assoc_bool_with_token(bool value);

    bool get_bool_value(int token_start_char_index);

    // ----------------------- string table -------------------------

    // All unique strings found in the COOL source code.
    std::vector<std::string> interned_strings;
    // A reverse map from interned strings to their index.
    std::unordered_map<std::string, int> istring_index;

    // A map from token ids to interned string ids.
    std::map<int, int> string_tokens;

    // The index of the " char that starts the current string.
    int string_start_char_index = -1;

    void assoc_string_with_token();

    // Returns the content of the constant string literal (CSL) that starts at
    // the specified index. (The char at the given index is the opening " of the
    // string.)
    const std::string &get_csl_text(int token_start_char_index);

    // ----------------------- error codes -------------------------

    // A map from token ids to error codes.
    std::map<int, ErrorCode> error_codes;

    ErrorCode current_error_code;

    void assoc_error_with_token(ErrorCode error_code) {
        error_codes[tokenStartCharIndex] = error_code;
    }

    ErrorCode get_error_code(int token_start_char_index) {
        return error_codes.at(token_start_char_index);
    }

    std::string getGrammarFileName() const override;

    const std::vector<std::string> &getRuleNames() const override;

    const std::vector<std::string> &getChannelNames() const override;

    const std::vector<std::string> &getModeNames() const override;

    const antlr4::dfa::Vocabulary &getVocabulary() const override;

    antlr4::atn::SerializedATNView getSerializedATN() const override;

    const antlr4::atn::ATN &getATN() const override;

    void action(antlr4::RuleContext *context, size_t ruleIndex,
                size_t actionIndex) override;

    // By default the static state used to implement the lexer is lazily
    // initialized during the first call to the constructor. You can call this
    // function if you wish to initialize the static state ahead of time.
    static void initialize();

  private:
    // Individual action functions triggered by action() above.
    void BOOL_CONSTAction(antlr4::RuleContext *context, size_t actionIndex);
    void STR_BEGINAction(antlr4::RuleContext *context, size_t actionIndex);
    void COMM_ERR1Action(antlr4::RuleContext *context, size_t actionIndex);
    void ERRORAction(antlr4::RuleContext *context, size_t actionIndex);
    void STR_ENDAction(antlr4::RuleContext *context, size_t actionIndex);
    void STR_ESC_NLAction(antlr4::RuleContext *context, size_t actionIndex);
    void ESC_BSAction(antlr4::RuleContext *context, size_t actionIndex);
    void ESC_FFAction(antlr4::RuleContext *context, size_t actionIndex);
    void ESC_TABAction(antlr4::RuleContext *context, size_t actionIndex);
    void ESC_NULLAction(antlr4::RuleContext *context, size_t actionIndex);
    void ESC_ANYAction(antlr4::RuleContext *context, size_t actionIndex);
    void NULLAction(antlr4::RuleContext *context, size_t actionIndex);
    void STR_NLAction(antlr4::RuleContext *context, size_t actionIndex);
    void STR_ERRAction(antlr4::RuleContext *context, size_t actionIndex);
    void STR_ANYAction(antlr4::RuleContext *context, size_t actionIndex);
    void ESTR_ENDAction(antlr4::RuleContext *context, size_t actionIndex);
    void ESTR_NLAction(antlr4::RuleContext *context, size_t actionIndex);
    void COMM_ERRAction(antlr4::RuleContext *context, size_t actionIndex);

    // Individual semantic predicate functions triggered by sempred() above.
};
