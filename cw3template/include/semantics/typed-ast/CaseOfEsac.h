#ifndef SEMANTICS_TYPED_AST_CASE_OF_ESAC_H_
#define SEMANTICS_TYPED_AST_CASE_OF_ESAC_H_

#include "Expr.h"

#include <memory>
#include <string>
#include <utility>
#include <vector>

class CaseOfEsac : public Expr {
  public:
    class Case {
      private:
        std::string name_;
        int type_;
        std::unique_ptr<Expr> expr_;

      public:
        Case(std::string name, int type, std::unique_ptr<Expr> expr)
            : name_(std::move(name)), type_(type), expr_(std::move(expr)) {}

        const std::string &get_name() const { return name_; }
        int get_type() const { return type_; }
        const Expr *get_expr() const { return expr_.get(); }
    };

  private:
    std::unique_ptr<Expr> multiplex_;
    std::vector<Case> cases_;
    int line_;

  public:
    CaseOfEsac(std::unique_ptr<Expr> multiplex, std::vector<Case> &&cases,
               int line, int type)
        : Expr(type), multiplex_(std::move(multiplex)),
          cases_(std::move(cases)), line_(line) {}

    const Expr *get_multiplex() const { return multiplex_.get(); }

    const std::vector<Case> &get_cases() const { return cases_; }

    int get_line() const { return line_; }
};

#endif
