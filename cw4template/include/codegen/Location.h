#ifndef CODEGEN_LOCATION_H_
#define CODEGEN_LOCATION_H_

#include <ostream>
#include <variant>

#include "Register.h"

struct MemoryLocation {
    int offset_in_bytes;
    Register base;

    auto operator<=>(const MemoryLocation &) const = default;
};

std::ostream &operator<<(std::ostream &out, const MemoryLocation &);

struct NoLocation {
    auto operator<=>(const NoLocation &) const = default;
};

struct AttributeLocation {
    int offset_in_bytes; // offset from the start of the object in memory, i.e.
                         // the pointer to the object

    auto operator<=>(const AttributeLocation &) const = default;
};

// The location of a variable: either a register (possibly virtual) or a memory
// location.
using Location =
    std::variant<Register, MemoryLocation, NoLocation, AttributeLocation>;

#endif
