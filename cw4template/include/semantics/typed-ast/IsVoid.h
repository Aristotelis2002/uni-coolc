#ifndef SEMANTICS_TYPED_AST_IS_VOID_H_
#define SEMANTICS_TYPED_AST_IS_VOID_H_

#include "Expr.h"

#include <memory>
#include <utility>

class IsVoid : public Expr {
  private:
    std::unique_ptr<Expr> check_subject_;

  public:
    IsVoid(std::unique_ptr<Expr> check_subject, int type)
        : Expr(type), check_subject_(std::move(check_subject)) {}

    const Expr *get_subject() const { return check_subject_.get(); }
};

#endif
