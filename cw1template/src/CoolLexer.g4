lexer grammar CoolLexer;

// Тази част позволява дефинирането на допълнителен код, който да се запише в
// генерирания CoolLexer.h.
//
// Коментарите вътре са на английски, понеже ANTLR4 иначе ги омазва.
@lexer::members {
    // Maximum length of a constant string literal (CSL) excluding the implicit
    // null character that marks the end of the string.
    const unsigned MAX_STR_CONST = 1024;
    // Stores the current CSL as it's being built.
    std::vector<char> string_buffer;

    // ----------------------- booleans -------------------------

    // A map from token ids to boolean values
    std::map<int, bool> bool_values;

    void assoc_bool_with_token(bool value) {
        bool_values[tokenStartCharIndex] = value;
    }

    bool get_bool_value(int token_start_char_index) {
        return bool_values.at(token_start_char_index);
    }

    // Add your own custom code to be copied to CoolLexer.h here.


}

// --------------- прости жетони -------------------

SEMI   : ';';
DARROW : '=>';

// Добавете тук останалите жетони, които представляват просто текст.


// --------------- булеви константи -------------------

BOOL_CONST : 'true'  { assoc_bool_with_token(true); }
           | 'false' { assoc_bool_with_token(false); };

// --------------- коментари -------------------



// --------------- ключови думи -------------------



// --------------- текстови низове -------------------


