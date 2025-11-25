#ifndef SEMANTICS_TYPED_AST_INTEGER_NEGATION_H_
#define SEMANTICS_TYPED_AST_INTEGER_NEGATION_H_

#include "Expr.h"

#include <memory>
#include <utility>

class IntegerNegation : public Expr {
  private:
    std::unique_ptr<Expr> argument_;

  public:
    IntegerNegation(std::unique_ptr<Expr> argument, int type)
        : Expr(type), argument_(std::move(argument)) {}

    Expr *get_argument() const { return argument_.get(); }
};

#endif
