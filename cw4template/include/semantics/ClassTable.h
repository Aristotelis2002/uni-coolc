#ifndef SEMANTICS_TYPED_AST_CLASS_TABLE_H_
#define SEMANTICS_TYPED_AST_CLASS_TABLE_H_

#include <cassert>
#include <map>
#include <memory>
#include <optional>
#include <string>
#include <unordered_map>
#include <vector>

#include "ObjectEnvironment.h"
#include "typed-ast/Attributes.h"
#include "typed-ast/Method.h"
#include "typed-ast/Methods.h"

constexpr int SELF_TYPE_INDEX = -2;
constexpr int NO_TYPE_INDEX = -1;

class Class {
  public:
    int parent = NO_TYPE_INDEX;
    Methods methods;
    Attributes attributes;
    int sub_hierarchy_size =
        0; // number of types that are subtype of this type; valid value >= 1

    // Returns whether this is the first time the attribute is being added or
    // not.
    bool add_attribute(std::string attribute_name, int type_index) {
        return attributes.add({attribute_name, type_index});
    }
};

class ClassTable {
  private:
    std::unique_ptr<std::vector<std::string>> class_names_;
    std::unordered_map<std::string_view, int> class_name_to_index_;
    std::vector<Class> classes_;

  public:
    void init(std::unique_ptr<std::vector<std::string>> class_names);

    void set_parent(std::string_view name, std::string_view parent_name);

    // If this method returns a string, then adding the attribute failed and the
    // string is the error message.
    std::optional<std::string> add_attribute(std::string_view class_name,
                                             std::string attribute_name,
                                             std::string attribute_type);

    // If this method returns a string, then adding the method failed and the
    // string is the error message.
    std::optional<std::string>
    add_method(std::string_view class_name, std::string method_name,
               const std::vector<std::string> &signature,
               SourceLocation source_location);

    // Returns the list of bottom-level attributes for the given class. This
    // means that inherited attributes are not returned.
    std::vector<std::string> get_attributes(int class_index);

    // Returns the list of all attributes for the given class, transitively
    // including all inherited attributes.
    std::vector<std::string> get_all_attributes(int class_index);

    // If this method returns nullopt, then the specified class does not have an
    // attribute with this name.
    std::optional<int> get_attribute_type(int class_index,
                                          const std::string &attribute_name);

    // If this method returns nullopt, then neither the specified class, nor any
    // of its ancestors has an attribute with this name.
    std::optional<int>
    transitive_get_attribute_type(int class_index,
                                  const std::string &attribute_name);

    const Expr *
    transitive_get_attribute_initializer(const std::string &class_name,
                                         const std::string &attribute_name);

    void set_attribute_initializer(const std::string &class_name,
                                   const std::string &attribute_name,
                                   std::unique_ptr<Expr> &&initializer);

    void set_argument_names(int class_index, const std::string &method_name,
                            std::vector<std::string> argument_names);

    void set_method_body(int class_index, const std::string &method_name,
                         std::unique_ptr<Expr> &&body);

    const Expr *get_method_body(int class_index,
                                const std::string &method_name);

    std::vector<std::string> get_method_names(int class_index);

    std::vector<std::string> get_argument_names(int class_index,
                                                const std::string &method_name);

    // Returns a map from each method that the given class provides to the last
    // ancestor in the ancestry of the given glass that overrides the method.
    //
    // The order is important (it is the order in which the methods are defined
    // by ancestors and the given class), which is why the map is represented by
    // vector of pairs.
    std::vector<std::pair<std::string, int>> get_all_methods(int class_index);

    // Returns the index of the given method_name in the output of
    // get_all_methods for the given class.
    //
    // Returns -1 if the method is not defined by any class in the ancestry of
    // the given class.
    int get_method_index(int class_index, const std::string &method_name);

    // If this method returns nullopt, then the specified class does not have a
    // method with this name.
    std::optional<std::vector<int>>
    get_signature(int class_index, const std::string &method_name);

    // If this method returns nullopt, then the specified class does not have a
    // method with this name at this source_location.
    std::optional<std::vector<int>>
    get_signature(int class_index, const std::string &method_name,
                  SourceLocation source_location);

    bool is_subclass_of(int class_index, int ancestor_index);

    // If this method returns nullopt, then neither the specified class, nor any
    // of its ancestors has a method with this name.
    std::optional<std::vector<int>>
    transitive_get_signature(int class_index, const std::string &method_name);

    const std::vector<std::string> &get_class_names();

    int get_num_of_classes();

    // TODO: sloppy; would be nice if Class is a view into a row
    int size() { return class_names_->size(); }

    // Returns -1 if the name is not a recognized class.
    int get_index(std::string_view name);

    std::string_view get_name(int class_index);

    int get_parent_index(int class_index);

    // Makes sure all heirs of a given class have consecutive indices.
    //
    // E.g. a class hierarchy might look like this:
    // 0
    //   1
    //   2
    //     3
    //     4
    //   5
    //
    // Note: this should be performed before type indeces are stored elsewhere
    // in the compiler, e.g. for argument types.
    void normalize_indexes();

    // Computes the sub_hierarchy_size field for each class in the hierarchy.
    void compute_sub_hierarchy_sizes();

    // Returns the list of classes starting from Object and leading to the given
    // class via inheritance.
    std::vector<int> get_ancestry(int type_index);

    // Returns the number of types that are subtypes of the given type.
    //
    // The result is >= 1, because subtyping is reflexive.
    int get_sub_hierarchy_size(int type_index);

    int class_least_upper_bound(int class_a, int class_b);

    ObjectEnvironment load_attribute_types(std::string current_class_name);
};

#endif
