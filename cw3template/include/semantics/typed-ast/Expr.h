#ifndef SEMANTICS_TYPED_AST_EXPR_H_
#define SEMANTICS_TYPED_AST_EXPR_H_

class Expr {
  private:
    int type_;

  public:
    Expr(int type) : type_(type) {}
    virtual ~Expr() = default;

    int get_type() const { return type_; }
};

#endif