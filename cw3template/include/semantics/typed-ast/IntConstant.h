#ifndef SEMANTICS_TYPED_AST_INT_CONSTANT_H_
#define SEMANTICS_TYPED_AST_INT_CONSTANT_H_

#include "Expr.h"

class IntConstant : public Expr {
  private:
    int value_;

  public:
    IntConstant(int value, int type) : Expr(type), value_(value) {}

    int get_value() const { return value_; }
};

#endif
