#include "Methods.h"

#include <cassert>

using namespace std;

optional<vector<int>> Methods::get_signature(const string &method_name) {
    auto it = method_name_to_index_.find(method_name);
    if (it == method_name_to_index_.end()) {
        return nullopt;
    }

    return methods_[it->second].get_signature();
}

void Methods::add_method(Method &&method) {
    auto &method_name = method.get_name();
    assert(!contains(method_name));

    method_name_to_index_.insert({method_name, methods_.size()});
    methods_.push_back(move(method));
}

bool Methods::contains(const string &method_name) {
    return method_name_to_index_.find(method_name) != method_name_to_index_.end();
}

vector<string> Methods::get_names() {
    vector<string> method_names;
    method_names.reserve(methods_.size());

    for (auto &method : methods_) {
        method_names.push_back(method.get_name());
    }

    return method_names;
}

void Methods::set_argument_names(const string &method_name,
                                 vector<string> argument_names) {
    auto it = method_name_to_index_.find(method_name);
    assert(it != method_name_to_index_.end());

    methods_[it->second].set_argument_names(move(argument_names));
}

vector<string> Methods::get_argument_names(const string &method_name) {
    auto it = method_name_to_index_.find(method_name);
    assert(it != method_name_to_index_.end());

    return methods_[it->second].get_argument_names();
}

void Methods::set_body(const string &method_name, unique_ptr<Expr> &&body) {
    auto it = method_name_to_index_.find(method_name);
    assert(it != method_name_to_index_.end());

    methods_[it->second].set_body(move(body));
}

const Expr *Methods::get_body(const string &method_name) {
    auto it = method_name_to_index_.find(method_name);
    assert(it != method_name_to_index_.end());

    return methods_[it->second].get_body();
}