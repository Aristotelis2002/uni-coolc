#ifndef SEMANTICS_TYPED_AST_BOOL_CONSTANT_H_
#define SEMANTICS_TYPED_AST_BOOL_CONSTANT_H_

#include "Expr.h"

class BoolConstant : public Expr {
  private:
    bool value_;

  public:
    BoolConstant(bool value, int type) : Expr(type), value_(value) {}

    bool get_value() const { return value_; }
};

#endif
