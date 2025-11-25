#ifndef SEMANTICS_TYPED_AST_DYNAMIC_DISPATCH_H_
#define SEMANTICS_TYPED_AST_DYNAMIC_DISPATCH_H_

#include "Expr.h"

#include <memory>
#include <string>
#include <utility>
#include <vector>

class DynamicDispatch : public Expr {
  private:
    std::unique_ptr<Expr> target_;
    std::string method_name_;
    std::vector<std::unique_ptr<Expr>> arguments_;

  public:
    DynamicDispatch(std::unique_ptr<Expr> target, std::string method_name,
                    std::vector<std::unique_ptr<Expr>> arguments, int type)
        : Expr(type), target_(std::move(target)),
          method_name_(std::move(method_name)),
          arguments_(std::move(arguments)) {}

    Expr *get_target() const { return target_.get(); }

    std::string get_method_name() const { return method_name_; }

    std::vector<Expr *> get_arguments() const {
        // TODO: for-each?
        std::vector<Expr *> result;
        result.reserve(arguments_.size());
        for (int i = 0; i < arguments_.size(); ++i) {
            result.push_back(arguments_[i].get());
        }
        return result;
    }
};

#endif
