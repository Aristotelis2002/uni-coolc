#ifndef SEMANTICS_TYPED_AST_STATIC_DISPATCH_H_
#define SEMANTICS_TYPED_AST_STATIC_DISPATCH_H_

#include "Expr.h"

#include <memory>
#include <string>
#include <utility>
#include <vector>

class StaticDispatch : public Expr {
  private:
    std::unique_ptr<Expr> target_;
    int static_dispatch_type_;
    std::string method_name_;
    std::vector<std::unique_ptr<Expr>> arguments_;

  public:
    StaticDispatch(std::unique_ptr<Expr> target, int static_dispatch_type,
                   std::string method_name,
                   std::vector<std::unique_ptr<Expr>> arguments, int type)
        : Expr(type), target_(std::move(target)),
          static_dispatch_type_(static_dispatch_type),
          method_name_(std::move(method_name)),
          arguments_(std::move(arguments)) {}

    Expr *get_target() const { return target_.get(); }

    // Returns the type of the class that should be used for method lookup for
    // this static dispatch.
    //
    // Note: different than get_type(): that's the return type of the method.
    int get_static_dispatch_type() const { return static_dispatch_type_; }

    std::string get_method_name() const { return method_name_; }

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
