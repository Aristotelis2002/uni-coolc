lexer grammar CoolLexer;

@lexer::members {
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

    int add_char_to_str(char c) {
        int l = string_buffer.size();
        const int max_l = MAX_STR_CONST;
        if (l == max_l) {
            setMode(ESTR);

            current_error_code = ErrorCode::STR_TOO_LONG;

            // restore state invariants
            string_buffer.clear();
            string_start_char_index = -1;
            return 0;
         }
        string_buffer.push_back(c);
        return 1;
    }

    // ----------------------- booleans -------------------------

    // A map from token ids to boolean values
    std::map<int, bool> bool_values;

    void assoc_bool_with_token(bool value) {
        bool_values[tokenStartCharIndex] = value;

        // hack: force symbol emission for get_bool_value by calling it
        get_bool_value(tokenStartCharIndex);
    }

    bool get_bool_value(int token_start_char_index) {
        return bool_values.at(token_start_char_index);
    }

    // ----------------------- string table -------------------------

    // All unique strings found in the COOL source code.
    std::vector<std::string> interned_strings;
    // A reverse map from interned strings to their index.
    std::unordered_map<std::string, int> istring_index;

    // A map from token ids to interned string ids.
    std::map<int, int> string_tokens;

    // The index of the " char that starts the current string.
    int string_start_char_index = -1;

    void assoc_string_with_token() {
        // Use the start char index as the token index.
        //
        // This assumes that no to tokens start at the same char, which is a
        // valid assumption for the lexer.
        int token_index = string_start_char_index;

        // Get a view on the string buffer.
        std::string str = {string_buffer.data(), string_buffer.size()};

        int next_istring_index = interned_strings.size();
        // Lookup the current string in the interned_strings.
        auto it = istring_index.find(str);
        if (it == istring_index.end()) {
            // Store value of constant string literal.
            interned_strings.push_back(std::string(str));

            // Use a view on the interned string as a key in the istring_index
            // table. Note that it is incorrect to the original str, since it
            // points to temporary memory and would lead to errors during
            // comparison internal to the unordered_map.
            str = interned_strings[next_istring_index];
            bool first_encounter = false;
            std::tie(it, first_encounter) = istring_index.insert({str, next_istring_index});
            assert(first_encounter);
        }

        // This will be the correct index for both cases.
        int string_index = it->second;
        string_tokens[token_index] = string_index;

        // hack: force symbol emission for get_csl_text by calling it
        get_csl_text(token_index);
    }

    // Returns the content of the constant string literal (CSL) that starts at
    // the specified index. (The char at the given index is the opening " of the
    // string.)
    const std::string& get_csl_text(int token_start_char_index) {
        return interned_strings[string_tokens[token_start_char_index]];
    }

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
}

SEMI   : ';';
OCURLY : '{';
CCURLY : '}';
OPAREN : '(';
COMMA  : ',';
CPAREN : ')';
COLON  : ':';
AT     : '@';
DOT    : '.';
PLUS   : '+';
MINUS  : '-';
STAR   : '*';
SLASH  : '/';
TILDE  : '~';
LT     : '<';
EQ     : '=';

DARROW : '=>';
ASSIGN : '<-';
LE     : '<=';

CLASS  : [Cc][Ll][Aa][Ss][Ss];
ELSE   : [Ee][Ll][Ss][Ee];
FI     : [Ff][Ii];
IF     : [Ii][Ff];
IN     : [Ii][Nn];
INHERITS : [Ii][Nn][Hh][Ee][Rr][Ii][Tt][Ss];
ISVOID : [Ii][Ss][Vv][Oo][Ii][Dd];
LET    : [Ll][Ee][Tt];
LOOP   : [Ll][Oo][Oo][Pp];
POOL   : [Pp][Oo][Oo][Ll];
THEN   : [Tt][Hh][Ee][Nn];
WHILE  : [Ww][Hh][Ii][Ll][Ee];
CASE   : [Cc][Aa][Ss][Ee];
ESAC   : [Ee][Ss][Aa][Cc];
NEW    : [Nn][Ee][Ww];
OF     : [Oo][Ff];
NOT    : [Nn][Oo][Tt];

BOOL_CONST : 't'[Rr][Uu][Ee]     { assoc_bool_with_token(true); }
           | 'f'[Aa][Ll][Ss][Ee] { assoc_bool_with_token(false); };
INT_CONST : [0-9]+;
OBJECTID : [a-z][A-Za-z0-9_]*;
TYPEID   : [A-Z][A-Za-z0-9_]*;
WS : [ \f\u000b\t\r\n]+ -> skip; // skip spaces, tabs, newlines

STR_BEGIN : '"' {
  // clear the buffer, just in case
  string_buffer.clear();
  string_start_char_index = tokenStartCharIndex;
} -> pushMode(STR), skip;

COMM_BEGIN : '(*' -> pushMode(COMM), skip;
COMM_ERR1  : '*)' {
  assoc_error_with_token(ErrorCode::UNMATCHED_COMMENT_END);
  setType(ERROR);
};

LCOMM_BEGIN : '--' -> pushMode(LCOMM), skip;

ERROR : . { assoc_error_with_token(ErrorCode::INVALID_SYMBOL); };

// TODO: how do I just declare tokens without defining them?
STR_CONST : '?';

// ------------ String literal constant expression ------------
mode STR;

STR_END : '"' EOF? {
  assoc_string_with_token();

  // modify token to turn it into a STR_CONST
  tokenStartCharIndex = string_start_char_index;
  setType(STR_CONST);

  // restore state invariants
  string_buffer.clear();
  string_start_char_index = -1;
} -> popMode;

// ------------ Escape sequence exceptions --------------
STR_ESC_NL  : '\\n' { add_char_to_str('\n'); } -> skip;

ESC_BS  : '\\b'     { add_char_to_str('\b'); } -> skip;
ESC_FF  : '\\f'     { add_char_to_str('\f'); } -> skip;
ESC_TAB : '\\t'     { add_char_to_str('\t'); } -> skip;

ESC_NULL : '\\\u0000' {
  current_error_code = ErrorCode::STR_CONTAINS_ESC_NULL;

  // restore state invariants
  string_buffer.clear();
  string_start_char_index = -1;
} -> mode(ESTR), skip;

// Escaping any other character adds it to the string.
ESC_ANY : '\\' . { add_char_to_str(getText()[1]); } -> skip;

NULL : '\u0000' EOF? {
  current_error_code = ErrorCode::STR_CONTAINS_NULL;

  // restore state invariants
  string_buffer.clear();
  string_start_char_index = -1;
} -> mode(ESTR), skip;

STR_NL : '\n' EOF? {
  assoc_error_with_token(ErrorCode::STR_CONTAINS_NEW_LINE);
  setType(ERROR);

  // restore state invariants
  string_buffer.clear();
  string_start_char_index = -1;
} -> popMode;

STR_ERR  : . EOF {
  assoc_error_with_token(ErrorCode::STR_CONTAINS_EOF);
  setType(ERROR);
};

STR_ANY : . { add_char_to_str(getText()[0]); } -> skip;


// --------- Error recovery for: String literal constant expression ------------
mode ESTR;

ESTR_END : '"' {
  assoc_error_with_token(current_error_code);
  setType(ERROR);
} -> popMode;

// ------------ Escape sequence exceptions --------------
ESTR_ESC_NL : '\\n' -> skip;

ESTR_NL : '\n' {
  assoc_error_with_token(current_error_code);
  setType(ERROR);
} -> popMode;

ESTR_ANY : . -> skip;

// ------------ Multi-line comment ------------
mode COMM;

OCOMM     : '(*' -> pushMode(COMM), skip;
CCOMM     : '*)' -> popMode, skip;
COMM_SKIP : . -> skip;
COMM_ERR  : . EOF {
  assoc_error_with_token(ErrorCode::COMMENT_CONTAINS_EOF);
  setType(ERROR);
};

mode LCOMM;

LCOMM_END  : '\n' -> popMode, skip;
LCOMM_SKIP : . -> skip;
