#ifndef SEMANTICS_TYPED_AST_STRING_CONSTANT_H_
#define SEMANTICS_TYPED_AST_STRING_CONSTANT_H_

#include "Expr.h"

#include <string>
#include <utility>

class StringConstant : public Expr {
  private:
    std::string value_;

  public:
    StringConstant(std::string value, int type)
        : Expr(type), value_(std::move(value)) {}

    const std::string &get_value() const { return value_; }
};

#endif
