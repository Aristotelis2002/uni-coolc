#include "TypeChecker.h"

#include <string>
#include <vector>

#include "CoolParser.h"

using namespace std;

vector<string> TypeChecker::check(CoolParser *parser) {
    visitProgram(parser->program());
    parser->reset();

    return std::move(errors);
}