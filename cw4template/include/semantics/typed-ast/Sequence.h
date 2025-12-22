#ifndef SEMANTICS_TYPED_AST_SEQUENCE_H_
#define SEMANTICS_TYPED_AST_SEQUENCE_H_

#include "Expr.h"

#include <memory>
#include <utility>
#include <vector>

class Sequence : public Expr {
  private:
    std::vector<std::unique_ptr<Expr>> sequence_;

  public:
    Sequence(std::vector<std::unique_ptr<Expr>> sequence, int type)
        : Expr(type), sequence_(std::move(sequence)) {}

    std::vector<Expr *> get_sequence() const {
        std::vector<Expr *> result;
        result.reserve(sequence_.size());
        for (int i = 0; i < sequence_.size(); ++i) {
            result.push_back(sequence_[i].get());
        }
        return result;
    }
};

#endif
