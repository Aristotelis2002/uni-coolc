#include <cctype>
#include <expected>
#include <filesystem>
#include <iomanip>
#include <iostream>
#include <memory>
#include <sstream>
#include <stack>
#include <string>
#include <vector>

#include "CoolLexer.h"
#include "CoolParser.h"
#include "antlr4-runtime/antlr4-runtime.h"

#include "semantics/ClassTable.h"
#include "semantics/CoolSemantics.h"

#include "codegen/CoolCodegen.h"

using namespace std;
using namespace antlr4;
using namespace antlr4::tree;

namespace fs = filesystem;

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

    auto semantics_result = semantics.run();

    if (!semantics_result.has_value()) {
        auto errors = semantics_result.error();
        cout << "Semantic check failed with " << errors.size()
             << " errors:" << endl;
        for (auto &error : errors) {
            cout << error << endl;
        }
        return 0;
    }

    auto class_table = std::move(semantics_result.value());
    CoolCodegen codegen(file_name, std::move(class_table));

    codegen.generate(cout);

    return 0;
}
