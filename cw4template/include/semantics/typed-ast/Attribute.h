#ifndef SEMANTICS_TYPED_AST_ATTRIBUTE_H_
#define SEMANTICS_TYPED_AST_ATTRIBUTE_H_

#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "Expr.h"

class Attribute {
  private:
    std::string name_;
    int type_;
    std::unique_ptr<Expr> initializer_;

  public:
    Attribute(std::string name, int type)
        : name_(std::move(name)), type_(std::move(type)) {}

    const int &get_type() const { return type_; }

    const std::string &get_name() const { return name_; }

    const Expr *get_initializer() const { return initializer_.get(); }

    void set_initializer(std::unique_ptr<Expr> &&expr) {
        initializer_ = std::move(expr);
    }
};

#endif
