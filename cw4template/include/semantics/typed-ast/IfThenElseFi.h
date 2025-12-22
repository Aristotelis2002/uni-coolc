#ifndef SEMANTICS_TYPED_AST_IF_THEN_ELSE_FI_H_
#define SEMANTICS_TYPED_AST_IF_THEN_ELSE_FI_H_

#include "Expr.h"

#include <memory>
#include <utility>

class IfThenElseFi : public Expr {
  private:
    std::unique_ptr<Expr> condition_;
    std::unique_ptr<Expr> then_expr_;
    std::unique_ptr<Expr> else_expr_;

  public:
    IfThenElseFi(std::unique_ptr<Expr> condition,
                 std::unique_ptr<Expr> then_expr,
                 std::unique_ptr<Expr> else_expr, int type)
        : Expr(type), condition_(std::move(condition)),
          then_expr_(std::move(then_expr)), else_expr_(std::move(else_expr)) {}

    const Expr *get_condition() const { return condition_.get(); }
    const Expr *get_then_expr() const { return then_expr_.get(); }
    const Expr *get_else_expr() const { return else_expr_.get(); }
};

#endif
