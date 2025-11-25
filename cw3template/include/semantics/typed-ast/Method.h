#ifndef SEMANTICS_TYPED_AST_METHOD_H_
#define SEMANTICS_TYPED_AST_METHOD_H_

#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "Expr.h"

class Method {
  private:
    std::string name_;
    // The first n-1 elements of signature_ are the argument types and the last
    // element of signature_ is the return type.
    std::vector<int> signature_;
    std::vector<std::string> argument_names_;
    std::unique_ptr<Expr> body_;

  public:
    Method(std::string name, std::vector<int> signature)
        : name_(std::move(name)), signature_(std::move(signature)) {}

    const std::vector<int> &get_signature() const { return signature_; }

    const std::string &get_name() const { return name_; }

    void set_argument_names(std::vector<std::string> argument_names) {
        argument_names_ = std::move(argument_names);
    }

    std::vector<std::string> get_argument_names() { return argument_names_; }

    void set_body(std::unique_ptr<Expr> &&expr) { body_ = std::move(expr); }

    const Expr *get_body() const { return body_.get(); }
};

#endif
