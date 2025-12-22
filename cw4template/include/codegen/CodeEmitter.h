#ifndef CODEGEN_CODE_EMITTER_H_
#define CODEGEN_CODE_EMITTER_H_

#include <ostream>
#include <string>

#include "Location.h"
#include "Mnemonic.h"
#include "Register.h"

namespace riscv_emit {

extern int if_then_else_fi_label_count;
extern int while_loop_pool_label_count;
extern int case_of_esac_count;

void emit_comment(std::ostream &out, std::string_view comment);

void emit_ident(std::ostream &out);

void emit_header_comment(std::ostream &out, std::string comment);

void emit_directive(std::ostream &out, std::string name);

void emit_p2align(std::ostream &out, int value);

// Emits a word that is a specific value; also optionally emits a comment.
void emit_word(std::ostream &out, int value, std::string inline_comment = "");

// Emits a word that is the address of a symbol.
void emit_word(std::ostream &out, std::string symbol);

void emit_add(std::ostream &out, Register dest, Register lhs, Register rhs);

void emit_add_immediate(std::ostream &out, Register dest, Register lhs,
                        int rhs);

void emit_subtract(std::ostream &out, Register dest, Register lhs,
                   Register rhs);

void emit_multiply(std::ostream &out, Register dest, Register lhs,
                   Register rhs);

void emit_divide(std::ostream &out, Register dest, Register lhs, Register rhs);

void emit_xor_immediate(std::ostream &out, Register dest, Register lhs,
                        int rhs);

void emit_shift_left_immediate(std::ostream &out, Register dest, Register src,
                               int immediate);

void emit_set_equal_zero(std::ostream &out, Register dest, Register src);

void emit_set_less_than(std::ostream &out, Register dest, Register lhs,
                        Register rhs);

void emit_label(std::ostream &out, std::string label);

void emit_globl(std::ostream &out, std::string label);

void emit_empty_line(std::ostream &out);

void emit_text_segment_tag(std::ostream &out);

void emit_data_segment_tag(std::ostream &out);

void emit_mnemonic(std::ostream &out, Mnemonic mnemonic);

void emit_register(std::ostream &out, Register reg);

void emit_memory_location(std::ostream &out, MemoryLocation location);

// Emits a "move" instruction that copies the `src` register into the `dest`
// register. Uses the concrete instsruction/mnemonic `add`.
//
// Example gen: [    add fp, sp, 0\n]
void emit_move(std::ostream &out, Register dest, Register src);

// Part of the callee discipline for the calling convention.
void emit_set_frame_pointer(std::ostream &out);

// Emits a "store word" instruction that stores the value of the `src` register
// into memory location `dest`. Uses the concrete instsruction/mnemonic `sw`.
//
// Example gen: [    sw ra, 0(sp)\n]
void emit_store_word(std::ostream &out, Register src, MemoryLocation dest);

// Emits a "load word" instruction that loads into the `dest` register the word
// at memory location `src`. Uses the concrete instsruction/mnemonic `lw`.
//
// Example gen: [    lw ra, 0(fp)\n]
void emit_load_word(std::ostream &out, Register dest, MemoryLocation src);

// Emits a "load address" instruction that loads into the `dest` register the
// memory address of the `label`. Uses the concrete instsruction/mnemonic `la`.
//
// Example gen: [    la t0, _string1.content\n]
void emit_load_address(std::ostream &out, Register dest, std::string label);

void emit_jump(std::ostream &out, std::string label);

// Emits a "jump and link" instruction that transfers control to the code at
// `function_label`. It automatically stores the return address before that.
// Uses the concrete instsruction/mnemonic `jal`.
//
// Example gen: [    jal IO.out_string\n]
void emit_jump_and_link(std::ostream &out, std::string function_label);

// Emits a "call" instruction that transfers control to the code at
// `function_label`. It automatically stores the return address before that.
// Uses the concrete instsruction/mnemonic `jal`.
//
// Example gen: [    call IO.out_string\n]
void emit_call(std::ostream &out, std::string function_label);

// Emits a "jump and link register" instruction that transfers control to the
// code at whatever address `reg` points at. It automatically stores the return
// address before that.
// Uses the concrete instsruction/mnemonic `jalr`.
//
// Example gen: [    jalr t0\n]
void emit_jump_and_link_register(std::ostream &out, Register reg);

void emit_branch_equal_zero(std::ostream &out, Register reg, std::string label);

void emit_branch_not_equal_zero(std::ostream &out, Register reg,
                                std::string label);

void emit_branch_less_than_zero(std::ostream &out, Register reg,
                                std::string label);

void emit_branch_greater_than_zero(std::ostream &out, Register reg,
                                   std::string label);

// Emits an instruction that adjusts the stack pointer according to the given
// `num_of_words` that the stack needs to be grown by. The stack grows towards
// negative addresses, so `num_of_words` is multiplied by -4.
//
// Example gen: [    addi sp, sp, -4\n]
void emit_grow_stack(std::ostream &out, int num_of_words);

// Emits a series of instructions that move data from one location to another.
// Supports reg to reg, mem to mem, mem to reg and reg to mem.
//
// If the locations are the same this is a no-op.
void emit_move_data_between_locations(std::ostream &out, Location src,
                                      Location dest);

void emit_push_register(std::ostream &out, Register reg);

void emit_pop_into_register(std::ostream &out, Register reg);

void emit_gc_tag(std::ostream &out);

} // namespace riscv_emit

#endif
