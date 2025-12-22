#ifndef SEMANTICS_TYPED_AST_WHILE_LOOP_POOL_H_
#define SEMANTICS_TYPED_AST_WHILE_LOOP_POOL_H_

#include "Expr.h"

#include <memory>
#include <utility>

class WhileLoopPool : public Expr {
  private:
    std::unique_ptr<Expr> condition_;
    std::unique_ptr<Expr> body_;

  public:
    WhileLoopPool(std::unique_ptr<Expr> condition, std::unique_ptr<Expr> body,
                  int type)
        : Expr(type), condition_(std::move(condition)), body_(std::move(body)) {
    }

    const Expr *get_condition() const { return condition_.get(); }
    const Expr *get_body() const { return body_.get(); }
};

#endif
