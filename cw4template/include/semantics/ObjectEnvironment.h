#ifndef SEMANTICS_OBJECT_ENVIRONMENT_H_
#define SEMANTICS_OBJECT_ENVIRONMENT_H_

#include <string>
#include <unordered_map>
#include <vector>

class ObjectEnvironment {
  private:
    // It's okay to use indexes here, since they should be stablized by the time
    // type checking begins.
    std::vector<std::unordered_map<std::string, int>> scopes;

  public:
    // Add a scope with a single object in it. Remove the scope via `pop_scope`.
    void add_object(std::string name, int type_index);

    // -1 indicates no type, i.e. name not in scope
    int get_type(std::string name);

    // Add a bunch of objects at once, shadowing previously added objects with
    // the same names. Remove it via `pop_scope`.
    void push_scope(std::vector<std::string> names, std::vector<int> types);

    void pop_scope();
};

#endif
