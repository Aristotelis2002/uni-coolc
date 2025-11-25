#ifndef SEMANTICS_TYPED_AST_PARENTHESIZED_EXPR_H_
#define SEMANTICS_TYPED_AST_PARENTHESIZED_EXPR_H_

#include "Expr.h"

#include <memory>
#include <utility>

class ParenthesizedExpr : public Expr {
  private:
    std::unique_ptr<Expr> contents_;

  public:
    ParenthesizedExpr(std::unique_ptr<Expr> contents, int type)
        : Expr(type), contents_(std::move(contents)) {}

    Expr *get_contents() const { return contents_.get(); }
};

#endif
