#ifndef SEMANTICS_TYPED_AST_ATTRIBUTES_H_
#define SEMANTICS_TYPED_AST_ATTRIBUTES_H_

#include <optional>
#include <string>
#include <unordered_map>
#include <vector>

#include "Attribute.h"

class Attributes {
  private:
    // This design keeps the order of the attributes the same as their order of
    // being added to the class, while allowing quick lookup by name.
    std::vector<Attribute> attributes_;
    std::unordered_map<std::string, int> name_to_index_;

  public:
    std::optional<int> get_type(const std::string &attribute_name);

    // Returns whether this is the first time the attribute is added or not.
    //
    // If not, it is not added again.
    bool add(Attribute &&attribute);

    // Returns nullptr if the argument does not name an attribute.
    Attribute *get(const std::string &attribute_name);

    bool contains(const std::string &attribute_name);

    std::vector<std::string> get_names();

    bool has_initializer(const std::string &attribute_name) const;

    const Expr *get_initializer(const std::string &attribute_name) const;

    void set_initializer(const std::string &attribute_name,
                         std::unique_ptr<Expr> &&initializer);

    std::vector<Attribute>::const_iterator begin() const {
        return attributes_.begin();
    }
    std::vector<Attribute>::const_iterator end() const {
        return attributes_.end();
    }
    std::vector<Attribute>::iterator begin() { return attributes_.begin(); }
    std::vector<Attribute>::iterator end() { return attributes_.end(); }
};

#endif
