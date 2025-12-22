#ifndef SEMANTICS_TYPED_AST_VARDECL_H_
#define SEMANTICS_TYPED_AST_VARDECL_H_

#include "Expr.h"

#include <memory>
#include <string>
#include <utility>

class Vardecl : public Expr {
  private:
    std::string name_;
    std::unique_ptr<Expr> initializer_;

  public:
    Vardecl(std::string name, int type)
        : Expr(type), name_(std::move(name)), initializer_(nullptr) {}

    Vardecl(std::string name, std::unique_ptr<Expr> initializer, int type)
        : Expr(type), name_(std::move(name)),
          initializer_(std::move(initializer)) {}

    bool has_initializer() const { return initializer_.get() != nullptr; }

    const std::string &get_name() const { return name_; }

    Expr *get_initializer() const { return initializer_.get(); }
};

#endif
