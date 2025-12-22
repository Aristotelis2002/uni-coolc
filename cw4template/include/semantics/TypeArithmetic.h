#ifndef SEMANTICS_TYPE_ARITHMETIC_H_
#define SEMANTICS_TYPE_ARITHMETIC_H_

#include <string>

#include "ClassTable.h"

class TypeArithmetic {
  private:
    ClassTable *class_table_;

  public:
    explicit TypeArithmetic(ClassTable *class_table)
        : class_table_(class_table) {}

    bool is_subtype_of(int a_type_index, int b_type_index,
                       const std::string &current_class_name) const;

    int type_least_upper_bound(int type_a, int type_b,
                               const std::string &current_class_name) const;
};

#endif
