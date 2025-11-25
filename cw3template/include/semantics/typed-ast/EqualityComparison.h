#ifndef SEMANTICS_TYPED_AST_EQUALITY_COMPARISON_H_
#define SEMANTICS_TYPED_AST_EQUALITY_COMPARISON_H_

#include "Expr.h"

#include <memory>
#include <utility>

class EqualityComparison : public Expr {
  private:
    std::unique_ptr<Expr> lhs_;
    std::unique_ptr<Expr> rhs_;

  public:
    EqualityComparison(std::unique_ptr<Expr> lhs, std::unique_ptr<Expr> rhs,
                       int type)
        : Expr(type), lhs_(std::move(lhs)), rhs_(std::move(rhs)) {}

    const Expr *get_lhs() const { return lhs_.get(); }
    const Expr *get_rhs() const { return rhs_.get(); }
};

#endif
