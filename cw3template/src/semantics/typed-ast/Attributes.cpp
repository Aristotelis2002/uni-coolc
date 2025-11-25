#include "Attributes.h"

#include <cassert>

std::optional<int> Attributes::get_type(const std::string &attribute_name) {
    auto it = name_to_index_.find(attribute_name);
    if (it == name_to_index_.end()) {
        return std::nullopt;
    }

    return attributes_[it->second].get_type();
}

bool Attributes::add(Attribute &&attribute) {
    auto &attribute_name = attribute.get_name();
    if (contains(attribute_name)) {
        return false;
    }

    name_to_index_.insert({attribute_name, attributes_.size()});
    attributes_.push_back(std::move(attribute));

    return true;
}

Attribute *Attributes::get(const std::string &attribute_name) {
    auto it = name_to_index_.find(attribute_name);
    if (it == name_to_index_.end()) {
        return nullptr;
    }

    return &attributes_[it->second];
}

bool Attributes::contains(const std::string &attribute_name) {
    return name_to_index_.find(attribute_name) != name_to_index_.end();
}

std::vector<std::string> Attributes::get_names() {
    std::vector<std::string> attribute_names;
    attribute_names.reserve(attributes_.size());

    for (auto &attribute : attributes_) {
        attribute_names.push_back(attribute.get_name());
    }

    return attribute_names;
}

bool
Attributes::has_initializer(const std::string &attribute_name) const {
    return name_to_index_.contains(attribute_name);
}

const Expr *
Attributes::get_initializer(const std::string &attribute_name) const {
    return attributes_.at(name_to_index_.at(attribute_name)).get_initializer();
}

void Attributes::set_initializer(const std::string &attribute_name,
                                 std::unique_ptr<Expr> &&initializer) {
    attributes_[name_to_index_[attribute_name]].set_initializer(
        move(initializer));
}