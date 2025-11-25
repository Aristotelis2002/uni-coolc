#include "CoolSemantics.h"

#include <expected>
#include <string>
#include <vector>

#include "passes/TypeChecker.h"

using namespace std;

string print_inheritance_loops_error(vector<vector<string>> inheritance_loops);

// Runs semantic analysis and returns a list of errors, if any.
//
// TODO: change the type from void * to your typed AST type
expected<void *, vector<string>> CoolSemantics::run() {
    vector<string> errors;

    // collect classes

    // build inheritance graph

    // check inheritance graph is a tree

    // collect features

    // check methods are overridden correctly

    for (const auto &error : TypeChecker().check(parser_)) {
        errors.push_back(error);
    }

    if (!errors.empty()) {
        return unexpected(errors);
    }

    // return the typed AST
    return nullptr;
}

string print_inheritance_loops_error(vector<vector<string>> inheritance_loops) {
    stringstream eout;
    eout << "Detected " << inheritance_loops.size()
         << " loops in the type hierarchy:" << endl;
    for (int i = 0; i < inheritance_loops.size(); ++i) {
        eout << i + 1 << ") ";
        auto &loop = inheritance_loops[i];
        for (string name : loop) {
            eout << name << " <- ";
        }
        eout << endl;
    }

    return eout.str();
}
