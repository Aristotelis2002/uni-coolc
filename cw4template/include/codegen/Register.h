#ifndef CODEGEN_REGISTER_H_
#define CODEGEN_REGISTER_H_

#include <variant>

struct ZeroRegister {
    auto operator<=>(const ZeroRegister &) const = default;
};

struct ReturnAddress {
    auto operator<=>(const ReturnAddress &) const = default;
};

struct StackPointer {
    auto operator<=>(const StackPointer &) const = default;
};

struct GlobalPointer {
    auto operator<=>(const GlobalPointer &) const = default;
};

struct ThreadPointer {
    auto operator<=>(const ThreadPointer &) const = default;
};

// index is between 0 and 6
struct TempRegister {
    int index;

    auto operator<=>(const TempRegister &) const = default;
};

// also, SavedRegister 0
struct FramePointer {
    auto operator<=>(const FramePointer &) const = default;
};

// index is between 0 and 11
// note that s0 is fp
struct SavedRegister {
    int index;

    auto operator<=>(const SavedRegister &) const = default;
};

// index is between 0 and 8
struct ArgumentRegister {
    int index;

    auto operator<=>(const ArgumentRegister &) const = default;
};

// index is unrestricted
struct VirtualRegister {
    int index;

    auto operator<=>(const VirtualRegister &) const = default;
};

using Register =
    std::variant<ZeroRegister, ReturnAddress, StackPointer, GlobalPointer,
                 ThreadPointer, TempRegister, FramePointer, SavedRegister,
                 ArgumentRegister, VirtualRegister>;

// overload helper to allow "pattern-matching" Registers
template <class... Ts> struct overload : Ts... {
    using Ts::operator()...;
};
// Deduction guide
template <class... Ts> overload(Ts...) -> overload<Ts...>;

#endif
