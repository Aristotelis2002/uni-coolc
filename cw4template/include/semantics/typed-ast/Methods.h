#ifndef SEMANTICS_TYPED_AST_METHODS_H_
#define SEMANTICS_TYPED_AST_METHODS_H_

#include <memory>
#include <optional>
#include <string>
#include <unordered_map>
#include <vector>

#include "Method.h"

class Methods {
  private:
    // This design keeps the order of the methods the same as their order of
    // being added to the class, while allowing quick lookup by name.
    std::vector<Method> methods_;
    std::unordered_map<std::string, int> method_name_to_index_;

  public:
    // Gets the signature of the method with the given name.
    std::optional<std::vector<int>>
    get_signature(const std::string &method_name);
    // Gets the signature of the method with the given name at the given source_location.
    //
    // This is only useful during semantic check, so ignore for codegen. If
    // semantic check succeeded, there will only ever be one method for a given
    // name, so the other `get_signature` is enough.
    std::optional<std::vector<int>>
    get_signature(const std::string &method_name,
                  SourceLocation source_location);

    void add_method(Method &&method);

    bool contains(const std::string &method_name);

    // Returns a vector of the names of the methods.
    std::vector<std::string> get_names();

    void set_argument_names(const std::string &method_name,
                            std::vector<std::string> argument_names);

    // Returns a vector of the names of the arguments of the method with the given name.
    std::vector<std::string> get_argument_names(const std::string &method_name);

    void set_body(const std::string &method_name, std::unique_ptr<Expr> &&body);

    // Returns a non-owning pointer to the body of the method with the given name.
    const Expr *get_body(const std::string &method_name);
};

#endif
