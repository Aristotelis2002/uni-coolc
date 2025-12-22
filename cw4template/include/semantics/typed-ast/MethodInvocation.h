#ifndef SEMANTICS_TYPED_AST_METHOD_INVOCATION_H_
#define SEMANTICS_TYPED_AST_METHOD_INVOCATION_H_

#include "Expr.h"

#include <memory>
#include <string>
#include <utility>
#include <vector>

class MethodInvocation : public Expr {
  private:
    std::string method_name_;
    std::vector<std::unique_ptr<Expr>> arguments_;

  public:
    MethodInvocation(std::string method_name,
                     std::vector<std::unique_ptr<Expr>> arguments, int type)
        : Expr(type), method_name_(std::move(method_name)),
          arguments_(std::move(arguments)) {}

    const std::string &get_method_name() const { return method_name_; }

    std::vector<Expr *> get_arguments() const {
        std::vector<Expr *> result;
        result.reserve(arguments_.size());
        for (int i = 0; i < arguments_.size(); ++i) {
            result.push_back(arguments_[i].get());
        }
        return result;
    }
};

#endif
