#ifndef SEMANTICS_TYPED_AST_NEW_OBJECT_H_
#define SEMANTICS_TYPED_AST_NEW_OBJECT_H_

#include "Expr.h"

class NewObject : public Expr {
  public:
    NewObject(int type) : Expr(type) {}
};

#endif
