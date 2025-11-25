#ifndef SEMANTICS_PASSES_TYPE_CHECKER_H_
#define SEMANTICS_PASSES_TYPE_CHECKER_H_

#include <any>
#include <string>
#include <vector>

#include "CoolParser.h"
#include "CoolParserBaseVisitor.h"

class TypeChecker : public CoolParserBaseVisitor {
  private:
    // define any necessary fields
    std::vector<std::string> errors;

    // override necessary visitor methods

    // define helper methods

  public:
    // TODO: add necessary dependencies to constructor
    TypeChecker() {}

    // Typechecks the AST that the parser produces and returns a list of errors,
    // if any.
    std::vector<std::string> check(CoolParser *parser);
};

#endif
