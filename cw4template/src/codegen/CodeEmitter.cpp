#include "CodeEmitter.h"

#include <cassert>
#include <cmath>
#include <iostream>

using namespace std;

namespace riscv_emit {

int if_then_else_fi_label_count = 0;
int while_loop_pool_label_count = 0;
int case_of_esac_count = 0;

void emit_comment(ostream &out, string_view comment) {
    out << "# " << comment << endl;
}

void emit_ident(ostream &out) { out << "    "; }

void emit_header_comment(ostream &out, string comment) {
    string half_line((76 - comment.length()) / 2, '-');
    string rounding = comment.length() % 2 == 1 ? "-" : "";
    emit_comment(out, half_line + " " + comment + " " + half_line + rounding);
}

void emit_directive(ostream &out, string name) { out << "." << name; }

void emit_p2align(ostream &out, int value) {
    emit_ident(out);
    emit_directive(out, "p2align");
    out << " " << value << endl;
}

// Emits a word that is a specific value; also optionally emits a comment.
void emit_word(ostream &out, int value, string inline_comment) {
    emit_ident(out);
    emit_directive(out, "word");
    out << " " << value;
    if (!inline_comment.empty()) {
        out << "  ";
        emit_comment(out, inline_comment);
    } else {
        out << endl;
    }
}

// Emits a string that is a specific value; also optionally emits a comment.
void emit_string(ostream &out, string value, string inline_comment) {
    emit_ident(out);
    emit_directive(out, "string");
    out << " " << value;
    if (!inline_comment.empty()) {
        out << "  ";
        emit_comment(out, inline_comment);
    } else {
        out << endl;
    }
}

// Emits a byte that is a specific value; also optionally emits a comment.
void emit_byte(ostream &out, int value, string inline_comment) {
    emit_ident(out);
    emit_directive(out, "byte");
    out << " " << value;
    if (!inline_comment.empty()) {
        out << "  ";
        emit_comment(out, inline_comment);
    } else {
        out << endl;
    }
}

// Emits a word that is the address of a symbol.
void emit_word(ostream &out, string symbol) {
    emit_ident(out);
    emit_directive(out, "word");
    out << " " << symbol << endl;
}

void emit_add(ostream &out, Register dest, Register lhs, Register rhs) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::Add);
    out << " ";
    emit_register(out, dest);
    out << ", ";
    emit_register(out, lhs);
    out << ", ";
    emit_register(out, rhs);
    out << endl;
}

void emit_add_immediate(ostream &out, Register dest, Register lhs, int rhs) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::AddImmediate);
    out << " ";
    emit_register(out, dest);
    out << ", ";
    emit_register(out, lhs);
    out << ", " << rhs << endl;
}

void emit_subtract(ostream &out, Register dest, Register lhs, Register rhs) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::Subtract);
    out << " ";
    emit_register(out, dest);
    out << ", ";
    emit_register(out, lhs);
    out << ", ";
    emit_register(out, rhs);
    out << endl;
}

void emit_multiply(ostream &out, Register dest, Register lhs, Register rhs) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::Multiply);
    out << " ";
    emit_register(out, dest);
    out << ", ";
    emit_register(out, lhs);
    out << ", ";
    emit_register(out, rhs);
    out << endl;
}

void emit_divide(ostream &out, Register dest, Register lhs, Register rhs) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::Divide);
    out << " ";
    emit_register(out, dest);
    out << ", ";
    emit_register(out, lhs);
    out << ", ";
    emit_register(out, rhs);
    out << endl;
}

void emit_xor_immediate(ostream &out, Register dest, Register lhs, int rhs) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::XorImmediate);
    out << " ";
    emit_register(out, dest);
    out << ", ";
    emit_register(out, lhs);
    out << ", " << rhs << endl;
}

void emit_shift_left_immediate(ostream &out, Register dest, Register src,
                               int immediate) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::ShiftLeftLogicalImmediate);
    out << " ";
    emit_register(out, dest);
    out << ", ";
    emit_register(out, src);
    out << ", ";
    out << immediate;
    out << endl;
}

void emit_set_equal_zero(ostream &out, Register dest, Register src) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::SetEqualZero);
    out << " ";
    emit_register(out, dest);
    out << ", ";
    emit_register(out, src);
    out << endl;
}

void emit_set_less_than(ostream &out, Register dest, Register lhs,
                        Register rhs) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::SetLessThan);
    out << " ";
    emit_register(out, dest);
    out << ", ";
    emit_register(out, lhs);
    out << ", ";
    emit_register(out, rhs);
    out << endl;
}

void emit_label(ostream &out, string label) { out << label << ":" << endl; }

void emit_globl(ostream &out, string label) {
    emit_directive(out, "globl");
    out << " " << label << endl;
}

// In reality: just "emit new line", but useful for readability of code using
// this library. Not so useful inside the library, so resist temptation to reuse
// in all places that use "out << endl" in this file.
void emit_empty_line(ostream &out) { out << endl; }

void emit_text_segment_tag(ostream &out) {
    emit_directive(out, "text");
    out << endl;
}

void emit_data_segment_tag(ostream &out) {
    emit_directive(out, "data");
    out << endl;
}

void emit_mnemonic(ostream &out, Mnemonic mnemonic) {
    switch (mnemonic) {
    case Mnemonic::Add:
        out << "add";
        break;
    case Mnemonic::AddImmediate:
        out << "addi";
        break;
    case Mnemonic::Subtract:
        out << "sub";
        break;
    case Mnemonic::Multiply:
        out << "mul";
        break;
    case Mnemonic::Divide:
        out << "div";
        break;
    case Mnemonic::XorImmediate:
        out << "xori";
        break;
    case Mnemonic::ShiftLeftLogicalImmediate:
        out << "slli";
        break;
    case Mnemonic::SetEqualZero:
        out << "seqz";
        break;
    case Mnemonic::SetLessThan:
        out << "slt";
        break;
    case Mnemonic::StoreWord:
        out << "sw";
        break;
    case Mnemonic::LoadWord:
        out << "lw";
        break;
    case Mnemonic::LoadAddress:
        out << "la";
        break;
    case Mnemonic::Jump:
        out << "j";
        break;
    case Mnemonic::JumpAndLink:
        out << "jal";
        break;
    case Mnemonic::Call:
        out << "call";
        break;
    case Mnemonic::JumpAndLinkRegister:
        out << "jalr";
        break;
    case Mnemonic::Return:
        out << "ret";
        break;
    case Mnemonic::BranchEqualZero:
        out << "beqz";
        break;
    case Mnemonic::BranchNotEqualZero:
        out << "bnez";
        break;
    case Mnemonic::BranchLessThanZero:
        out << "bltz";
        break;
    case Mnemonic::BranchGreaterThanZero:
        out << "bgtz";
        break;
    default:
        cerr << "ICE: emit_mnemonic has no branch for "
             << static_cast<int>(mnemonic) << endl;
        abort();
    }
}

template <typename> constexpr bool always_false = false;

#include <typeinfo>

void emit_register(ostream &out, Register reg) {
    std::visit(
        overload{[&out](ZeroRegister zero) { out << "zero"; },
                 [&out](ReturnAddress ra) { out << "ra"; },
                 [&out](StackPointer sp) { out << "sp"; },
                 [&out](FramePointer fp) { out << "fp"; },
                 [&out](TempRegister reg) { out << "t" << reg.index; },
                 [&out](SavedRegister reg) { out << "s" << reg.index; },
                 [&out](ArgumentRegister reg) { out << "a" << reg.index; },
                 [](auto &&other) {
                     cerr << "TODO: unhandled register variant" << endl;
                     abort();
                 }},
        reg);
}

void emit_memory_location(ostream &out, MemoryLocation location) {
    out << location.offset_in_bytes << "(";
    emit_register(out, location.base);
    out << ")";
}

// Emits a "move" instruction that copies the `src` register into the `dest`
// register. Uses the concrete instsruction/mnemonic `add`.
//
// Example gen: [    add fp, sp, 0\n]
void emit_move(ostream &out, Register dest, Register src) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::Add);
    out << " ";
    emit_register(out, dest);
    out << ", ";
    emit_register(out, src);
    out << ", ";
    emit_register(out, ZeroRegister{});
    out << endl;
}

// Emits a "store word" instruction that stores the value of the `src` register
// into memory pointed at by the `dest` register and offset with
// `offset_in_bytes` number of bytes. Uses the concrete instsruction/mnemonic
// `sw`.
//
// Example gen: [    sw ra, 0(sp)\n]
void emit_store_word(ostream &out, Register src, MemoryLocation dest) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::StoreWord);
    out << " ";
    emit_register(out, src);
    out << ", ";
    emit_memory_location(out, dest);
    out << endl;
}

// Emits a "load word" instruction that loads into the `dest` register the
// memory pointed at by the `src` register and offset with `offset_in_bytes`
// number of bytes. Uses the concrete instsruction/mnemonic `lw`.
//
// Example gen: [    lw ra, 0(fp)\n]
void emit_load_word(ostream &out, Register dest, MemoryLocation src) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::LoadWord);
    out << " ";
    emit_register(out, dest);
    out << ", ";
    emit_memory_location(out, src);
    out << endl;
}

// Emits a "load address" instruction that loads into the `dest` register the
// memory address of the `src` label. Uses the concrete instsruction/mnemonic
// `la`.
//
// Example gen: [    la t0, _string1.content\n]
void emit_load_address(ostream &out, Register dest, string label) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::LoadAddress);
    out << " ";
    emit_register(out, dest);
    out << ", ";
    out << label;
    out << endl;
}

void emit_jump(ostream &out, string label) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::Jump);
    out << " ";
    out << label;
    out << endl;
}

// Emits a "jump and link" instruction that transfers control to the code at
// `function_label`. It automatically stores the return address before that.
// Uses the concrete instsruction/mnemonic `jal`.
//
// Example gen: [    jal IO.out_string\n]
void emit_jump_and_link(ostream &out, string function_label) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::JumpAndLink);
    out << " ";
    out << function_label;
    out << endl;
}

// Emits a "call" instruction that transfers control to the code at
// `function_label`. It automatically stores the return address before that.
// Uses the concrete instsruction/mnemonic `call`.
//
// Example gen: [    call IO.out_string\n]
void emit_call(ostream &out, string function_label) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::Call);
    out << " ";
    out << function_label;
    out << endl;
}

// Emits a "jump and link register" instruction that transfers control to the
// code at whatever address `reg` + `offset` points at. It automatically stores
// the return address before that.
// Uses the concrete instsruction/mnemonic `jalr`.
//
// Example gen: [    jalr t0\n]
void emit_jump_and_link_register(ostream &out, Register reg) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::JumpAndLinkRegister);
    out << " ";
    out << 0; // offset: see end of function
    out << "(";
    emit_register(out, reg);
    out << ")";
    out << endl;

    // offset; not much use to jumping to an offset label...; this lead me to a
    // 15 min debug, so perhaps worth expanding: one might mistake the
    // following:
    //
    // lw t0 28(t0)
    // jalr 0(t0)
    //
    // and
    //
    // jalr 28(t0)
    //
    // ... but they're different. The latter offsets the address and jumps
    // there; the former offsets the address, loads the contents, and jumps
    // there. Huge difference.
}

void emit_branch_equal_zero(ostream &out, Register reg, string label) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::BranchEqualZero);
    out << " ";
    emit_register(out, reg);
    out << ", ";
    out << label;
    out << endl;
}

void emit_branch_not_equal_zero(ostream &out, Register reg, string label) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::BranchNotEqualZero);
    out << " ";
    emit_register(out, reg);
    out << ", ";
    out << label;
    out << endl;
}

void emit_branch_less_than_zero(ostream &out, Register reg, string label) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::BranchLessThanZero);
    out << " ";
    emit_register(out, reg);
    out << ", ";
    out << label;
    out << endl;
}

void emit_branch_greater_than_zero(ostream &out, Register reg, string label) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::BranchGreaterThanZero);
    out << " ";
    emit_register(out, reg);
    out << ", ";
    out << label;
    out << endl;
}

// Emits an instruction that adjusts the stack pointer according to the given
// `num_of_words` that the stack needs to be grown by. The stack grows towards
// negative addresses, so `num_of_words` is multiplied by -4.
//
// Example gen: [    addi sp, sp, -4\n]
void emit_grow_stack(ostream &out, int num_of_words) {
    emit_ident(out);
    emit_mnemonic(out, Mnemonic::AddImmediate);
    out << " ";
    emit_register(out, StackPointer{});
    out << ", ";
    emit_register(out, StackPointer{});
    out << ", ";
    out << (-4) * num_of_words;
    out << endl;
}

void emit_push_register(ostream &out, Register reg) {
    emit_store_word(out, reg, MemoryLocation{0, StackPointer{}});
    emit_grow_stack(out, /*num_of_words=*/1);
}

void emit_pop_into_register(ostream &out, Register reg) {
    emit_grow_stack(out, /*num_of_words=*/-1);
    emit_load_word(out, reg, MemoryLocation{0, StackPointer{}});
}

// Emits a series of instructions that move data from one location to another.
// Supports reg to reg, mem to reg, and reg to mem. TODO: mem to mem is not
// supported.
void emit_move_data_between_locations(std::ostream &out, Location src,
                                      Location dest) {
    if (src == dest) {
        return;
    }

    std::visit(
        [&out](auto &&src, auto &&dest) {
            using T_SRC = std::decay_t<decltype(src)>;
            using T_DEST = std::decay_t<decltype(dest)>;

            if constexpr (std::is_same_v<T_SRC, Register> &&
                          std::is_same_v<T_DEST, Register>) {
                emit_move(out, dest, src);
            } else if constexpr (std::is_same_v<T_SRC, MemoryLocation> &&
                                 std::is_same_v<T_DEST, Register>) {
                emit_load_word(out, dest, src);
            } else if constexpr (std::is_same_v<T_SRC, Register> &&
                                 std::is_same_v<T_DEST, MemoryLocation>) {
                emit_store_word(out, src, dest);
            } else {
                cerr << "ICE: not supported arguments " << typeid(src).name()
                     << " and " << typeid(dest).name()
                     << " for emit_move_data_between_locations" << endl;
                abort();
            }
        },
        src, dest);
}

constexpr int GC_TAG = -1;

void emit_gc_tag(ostream &out) { emit_word(out, GC_TAG, "GC tag"); }

} // namespace riscv_emit
