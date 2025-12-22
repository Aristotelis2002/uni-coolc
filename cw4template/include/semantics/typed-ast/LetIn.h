#ifndef SEMANTICS_TYPED_AST_LET_IN_H_
#define SEMANTICS_TYPED_AST_LET_IN_H_

#include "Expr.h"
#include "Vardecl.h"

#include <memory>
#include <utility>
#include <vector>

class LetIn : public Expr {
  private:
    std::vector<std::unique_ptr<Vardecl>> vardecls_;
    std::unique_ptr<Expr> body_;

  public:
    LetIn(std::vector<std::unique_ptr<Vardecl>> vardecls,
          std::unique_ptr<Expr> body, int type)
        : Expr(type), vardecls_(std::move(vardecls)), body_(std::move(body)) {}

    std::vector<Vardecl *> get_vardecls() const {
        int n = vardecls_.size();
        std::vector<Vardecl *> result(n);
        for (int i = 0; i < n; ++i) {
            result[i] = vardecls_[i].get();
        }
        return result;
    };

    Expr *get_body() const { return body_.get(); }
};

#endif
