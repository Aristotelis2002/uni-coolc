#ifndef SEMANTICS_TYPED_AST_OBJECT_REFERENCE_H_
#define SEMANTICS_TYPED_AST_OBJECT_REFERENCE_H_

#include "Expr.h"

#include <string>
#include <utility>

class ObjectReference : public Expr {
  private:
    std::string name_;

  public:
    ObjectReference(std::string name, int type)
        : Expr(type), name_(std::move(name)) {}

    const std::string &get_name() const { return name_; }
};

#endif
