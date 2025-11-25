#ifndef SEMANTICS_TYPED_AST_ARITHMETIC_H_
#define SEMANTICS_TYPED_AST_ARITHMETIC_H_

#include "Expr.h"

#include <memory>
#include <utility>

class Arithmetic : public Expr {
  public:
    enum class Kind {
        Addition,
        Subtraction,
        Multiplication,
        Division,
    };

  private:
    std::unique_ptr<Expr> lhs_;
    std::unique_ptr<Expr> rhs_;
    Kind kind_;

  public:
    Arithmetic(std::unique_ptr<Expr> lhs, std::unique_ptr<Expr> rhs, Kind kind,
               int type)
        : Expr(type), lhs_(std::move(lhs)), rhs_(std::move(rhs)), kind_(kind) {}

    Expr *get_lhs() const { return lhs_.get(); }
    Expr *get_rhs() const { return rhs_.get(); }
    Kind get_kind() const { return kind_; }
};

#endif
