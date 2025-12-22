#ifndef SEMANTICS_TYPED_AST_ASSIGNMENT_H_
#define SEMANTICS_TYPED_AST_ASSIGNMENT_H_

#include "Expr.h"

#include <memory>
#include <string>

class Assignment : public Expr {
  private:
    std::string assignee_name_;
    std::unique_ptr<Expr> value_;

  public:
    Assignment(std::string assignee_name, std::unique_ptr<Expr> value, int type)
        : Expr(type), assignee_name_(assignee_name), value_(std::move(value)) {}

    const std::string &get_assignee_name() const { return assignee_name_; }
    Expr *get_value() const { return value_.get(); }
};

#endif