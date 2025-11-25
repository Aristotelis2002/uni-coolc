#include <filesystem>
#include <iostream>
#include <string>
#include <vector>

#include "antlr4-runtime/antlr4-runtime.h"

#include "CoolLexer.h"
#include "CoolParser.h"

#include "semantics/CoolSemantics.h"

using namespace std;
using namespace antlr4;
using namespace antlr4::tree;

namespace fs = filesystem;

constexpr bool debug = false;

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

    // Silence console error reporting.
    // lexer.removeErrorListener(&ConsoleErrorListener::INSTANCE);

    CommonTokenStream tokenStream(&lexer);

    CoolParser parser(&tokenStream);

    CoolSemantics semantics(&lexer, &parser);

    auto run_result = semantics.run();

    if (!run_result.has_value()) {
        auto errors = run_result.error();
        cout << "Semantic check failed with " << errors.size()
             << " errors:" << endl;
        for (auto &error : errors) {
            cout << error << endl;
        }
    } else {
        cout << "Semantic check succeeded!" << endl;
    }

    return 0;
}
