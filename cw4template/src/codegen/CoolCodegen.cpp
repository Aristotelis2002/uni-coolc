#include "CoolCodegen.h"

using namespace std;

void CoolCodegen::generate(ostream &out) {

    // Emit code here.

    // 1. create an "object model class table" that uses the class_table_ to compute the layout of objects in memory

    // 2. create a class to contain static constants (to be emitted at the end)

    // 3. emit code for method bodies; possibly append to static constants

    // 4. emit prototype objects

    // 5. emit dispatch tables

    // 6. emit initialization methods for classes

    // 7. emit class name table

    // 8. emit static constants

    // Extra tip: implement code generation for expressions in a separate class and reuse it for method impls and init methods.


    // The following is an example manually written assembly that prints out "hello, world".

    // Start your work by removing it.

    out << "# 001.hello_world.example.s is inlined here\n\
.text\n\
\n\
_inf_loop:\n\
    j _inf_loop\n\
\n\
.globl Main.main\n\
Main.main:\n\
    # stack discipline:\n\
    # caller:\n\
    # - self object is passed in a0\n\
    # - control link is pushed first on the stack\n\
    # - arguments are pushed in reverse order on the stack\n\
    # callee:\n\
    # - activation frame starts at the stack pointer\n\
    add fp, sp, 0\n\
    # - previous return address is first on the activation frame\n\
    sw ra, 0(sp)\n\
    addi sp, sp, -4\n\
    # - size of activation frame is fixed per method, because it depends on\n\
    #   number of arguments\n\
    # - fp points to sp\n\
    # - sp points to next free stack memory\n\
    # before using saved registers (s1 -- s11), push them on the stack\n\
\n\
    # stack discipline:\n\
    # caller:\n\
    # - self object is passed in a0\n\
    # self already is a0, so no-op\n\
    # - control link is pushed first on the stack\n\
    sw fp, 0(sp)\n\
    addi sp, sp, -4\n\
    # - arguments are pushed in reverse order on the stack\n\
    la t0, _string1.content\n\
    sw t0, 0(sp)\n\
    addi sp, sp, -4\n\
\n\
    jal IO.out_string\n\
\n\
    # stack discipline:\n\
    # callee:\n\
    # - restore used saved registers (s1 -- s11) from the stack\n\
    # - ra is restored from first word on activation frame\n\
    lw ra, 0(fp)\n\
    # - ra, arguments, and control link are popped from the stack\n\
    addi sp, sp, 8\n\
    # - fp is restored from control link\n\
    lw fp, 0(sp)\n\
    # - result is stored in a0\n\
    # caller:\n\
    # - read return value from a0\n\
    ret\n\
\n\
.data\n\
# ------------- Name table of classes ------------------------------------------\n\
.p2align 2\n\
.globl class_nameTab\n\
class_nameTab:\n\
    .word Object_className\n\
    .word IO_className\n\
    .word Int_className\n\
    .word Bool_className\n\
    .word String_className\n\
    .word Main_className\n\
\n\
    .word -1 # GC tag\n\
Object_classNameLength:\n\
    .word 2  # class tag;       2 for Int\n\
    .word 4  # object size;     4 words (16 bytes); GC tag not included\n\
    .word 0  # dispatch table;  Int has no methods\n\
    .word 6  # first attribute; value of Int; default is 0\n\
\n\
    .word -1 # GC tag\n\
Object_className:\n\
    .word 4  # class tag;       4 for String\n\
    .word 6  # object size;     6 words (24 bytes); GC tag not included\n\
    .word String_dispTab\n\
    .word Object_classNameLength  # first attribute; pointer length\n\
    .string \"Object\"\n\
    .byte 0\n\
\n\
    .word -1 # GC tag\n\
IO_classNameLength:\n\
    .word 2  # class tag;       2 for Int\n\
    .word 4  # object size;     4 words (16 bytes); GC tag not included\n\
    .word 0  # dispatch table;  Int has no methods\n\
    .word 2  # first attribute; value of Int; default is 0\n\
\n\
    .word -1 # GC tag\n\
IO_className:\n\
    .word 4  # class tag;       4 for String\n\
    .word 5  # object size;     5 words (20 bytes); GC tag not included\n\
    .word String_dispTab\n\
    .word IO_classNameLength  # first attribute; pointer length\n\
    .string \"IO\" # includes terminating null char\n\
    .byte 0\n\
\n\
    .word -1 # GC tag\n\
Int_classNameLength:\n\
    .word 2  # class tag;       2 for Int\n\
    .word 4  # object size;     4 words (16 bytes); GC tag not included\n\
    .word 0  # dispatch table;  Int has no methods\n\
    .word 3  # first attribute; value of Int; default is 0\n\
\n\
    .word -1 # GC tag\n\
Int_className:\n\
    .word 4  # class tag;       4 for String\n\
    .word 5  # object size;     5 words (20 bytes); GC tag not included\n\
    .word String_dispTab\n\
    .word Int_classNameLength  # first attribute; pointer length\n\
    .string \"Int\" # includes terminating null char\n\
\n\
    .word -1 # GC tag\n\
Bool_classNameLength:\n\
    .word 2  # class tag;       2 for Int\n\
    .word 4  # object size;     4 words (16 bytes); GC tag not included\n\
    .word 0  # dispatch table;  Int has no methods\n\
    .word 4  # first attribute; value of Int; default is 0\n\
\n\
    .word -1 # GC tag\n\
Bool_className:\n\
    .word 4  # class tag;       4 for String\n\
    .word 6  # object size;     6 words (24 bytes); GC tag not included\n\
    .word String_dispTab\n\
    .word Bool_classNameLength  # first attribute; pointer length\n\
    .string \"Bool\" # includes terminating null char\n\
    .byte 0\n\
    .byte 0\n\
    .byte 0\n\
\n\
    .word -1 # GC tag\n\
String_classNameLength:\n\
    .word 2  # class tag;       2 for Int\n\
    .word 4  # object size;     4 words (16 bytes); GC tag not included\n\
    .word 0  # dispatch table;  Int has no methods\n\
    .word 6  # first attribute; value of Int; default is 0\n\
\n\
    .word -1 # GC tag\n\
String_className:\n\
    .word 4  # class tag;       4 for String\n\
    .word 6  # object size;     6 words (24 bytes); GC tag not included\n\
    .word String_dispTab\n\
    .word String_classNameLength  # first attribute; pointer length\n\
    .string \"String\" # includes terminating null char\n\
    .byte 0\n\
\n\
    .word -1 # GC tag\n\
Main_classNameLength:\n\
    .word 2  # class tag;       2 for Int\n\
    .word 4  # object size;     4 words (16 bytes); GC tag not included\n\
    .word 0  # dispatch table;  Int has no methods\n\
    .word 4  # first attribute; value of Int; default is 0\n\
\n\
    .word -1 # GC tag\n\
Main_className:\n\
    .word 4  # class tag;       4 for String\n\
    .word 6  # object size;     6 words (24 bytes); GC tag not included\n\
    .word String_dispTab\n\
    .word Main_classNameLength  # first attribute; pointer length\n\
    .string \"Main\" # includes terminating null char\n\
    .byte 0\n\
    .byte 0\n\
    .byte 0\n\
\n\
# ------------- Prototype objects ----------------------------------------------\n\
    .p2align 2\n\
    .word -1 # GC tag\n\
.globl Object_protObj\n\
Object_protObj:\n\
    .word 0  # class tag;       0 for Object\n\
    .word 3  # object size;     3 words (12 bytes); GC tag not included\n\
    .word Object_dispTab\n\
\n\
    .word -1 # GC tag\n\
.globl IO_protObj\n\
IO_protObj:\n\
    .word 1  # class tag;       1 for IO\n\
    .word 3  # object size;     3 words (12 bytes); GC tag not included\n\
    .word IO_dispTab\n\
\n\
    .word -1 # GC tag\n\
.globl Int_protObj\n\
Int_protObj:\n\
    .word 2  # class tag;       2 for Int\n\
    .word 4  # object size;     4 words (16 bytes); GC tag not included\n\
    .word 0  # dispatch table;  Int has no methods\n\
    .word 0  # first attribute; value of Int; default is 0\n\
\n\
    .word -1 # GC tag\n\
.globl Bool_protObj\n\
Bool_protObj:\n\
    .word 3  # class tag;       3 for Bool\n\
    .word 4  # object size;     4 words (16 bytes); GC tag not included\n\
    .word 0  # dispatch table;  Bool has no methods\n\
    .word 0  # first attribute; value of Bool; default is 0; means false\n\
\n\
    .word -1 # GC tag\n\
.globl String_protObj\n\
String_protObj:\n\
    .word 4  # class tag;       4 for String\n\
    .word 5  # object size;     5 words (20 bytes); GC tag not included\n\
    .word String_dispTab\n\
    .word 0  # first attribute; pointer to Int that is the length of the String\n\
    .word 0  # second attribute; terminating 0 character, since \"\" is default\n\
\n\
    .word -1 # GC tag\n\
.globl Main_protObj\n\
Main_protObj:\n\
    .word 5  # class tag;       5 for Main\n\
    .word 3  # object size;     3 words (12 bytes); GC tag not included\n\
    .word Main_dispTab\n\
\n\
# ------------- Dispatch tables ------------------------------------------------\n\
.globl Object_dispTab\n\
Object_dispTab:\n\
    .word Object.abort\n\
    .word Object.type_name\n\
    .word Object.copy\n\
\n\
.globl IO_dispTab\n\
IO_dispTab:\n\
    .word Object.abort\n\
    .word Object.type_name\n\
    .word Object.copy\n\
    .word IO.out_string\n\
    .word IO.in_string\n\
    .word IO.out_int\n\
    .word IO.in_int\n\
\n\
.globl Int_dispTab\n\
Int_dispTab:\n\
    .word Object.abort\n\
    .word Object.type_name\n\
    .word Object.copy\n\
\n\
.globl Bool_dispTab\n\
Bool_dispTab:\n\
    .word Object.abort\n\
    .word Object.type_name\n\
    .word Object.copy\n\
\n\
.globl String_dispTab\n\
String_dispTab:\n\
    .word Object.abort\n\
    .word Object.type_name\n\
    .word Object.copy\n\
    .word String.length\n\
    .word String.concat\n\
    .word String.substr\n\
\n\
# no need to export symbols for user-defined types\n\
Main_dispTab:\n\
    .word Object.abort\n\
    .word Object.type_name\n\
    .word Object.copy\n\
    .word IO.out_string\n\
    .word IO.out_int\n\
    .word IO.in_string\n\
    .word IO.in_int\n\
    .word Main.main\n\
\n\
# ----------------- Init methods -----------------------------------------------\n\
\n\
.globl Object_init\n\
Object_init:\n\
    # Most of the `init` functions of the default types are no-ops, so the\n\
    # implementation is the same.\n\
\n\
    # stack discipline:\n\
    # callee:\n\
    # - activation frame starts at the stack pointer\n\
    add fp, sp, 0\n\
    # - previous return address is first on the activation frame\n\
    sw ra, 0(sp)\n\
    addi sp, sp, -4\n\
    # before using saved registers (s1 -- s11), push them on the stack\n\
\n\
    # no op\n\
\n\
    # stack discipline:\n\
    # callee:\n\
    # - restore used saved registers (s1 -- s11) from the stack\n\
    # - ra is restored from first word on activation frame\n\
    lw ra, 0(fp)\n\
    # - ra, arguments, and control link are popped from the stack\n\
    addi sp, sp, 8\n\
    # - fp is restored from control link\n\
    lw fp, 0(sp)\n\
    # - result is stored in a0\n\
\n\
    ret\n\
\n\
\n\
.globl IO_init\n\
IO_init:\n\
    # Most of the `init` functions of the default types are no-ops, so the\n\
    # implementation is the same.\n\
\n\
    add fp, sp, 0\n\
    sw ra, 0(sp)\n\
    addi sp, sp, -4\n\
\n\
    # no op\n\
\n\
    lw ra, 0(fp)\n\
    addi sp, sp, 8\n\
    lw fp, 0(sp)\n\
    ret\n\
\n\
\n\
# Initializes an object of class Int passed in a0. In practice, a no-op, since\n\
# Int_protObj already has the first (and only) attribute set to 0.\n\
.globl Int_init\n\
Int_init:\n\
    # Most of the `init` functions of the default types are no-ops, so the\n\
    # implementation is the same.\n\
\n\
    add fp, sp, 0\n\
    sw ra, 0(sp)\n\
    addi sp, sp, -4\n\
\n\
    # no op\n\
\n\
    lw ra, 0(fp)\n\
    addi sp, sp, 8\n\
    lw fp, 0(sp)\n\
    ret\n\
\n\
\n\
# Initializes an object of class Bool passed in a0. In practice, a no-op, since\n\
# Bool_protObj already has the first (and only) attribute set to 0.\n\
.globl Bool_init\n\
Bool_init:\n\
    # Most of the `init` functions of the default types are no-ops, so the\n\
    # implementation is the same.\n\
\n\
    add fp, sp, 0\n\
    sw ra, 0(sp)\n\
    addi sp, sp, -4\n\
\n\
    # no op\n\
\n\
    lw ra, 0(fp)\n\
    addi sp, sp, 8\n\
    lw fp, 0(sp)\n\
    ret\n\
\n\
\n\
# Initializes an object of class String passed in a0. Allocates a new Int to\n\
# store the length of the String and links the length pointer to it. Returns the\n\
# initialized String in a0.\n\
#\n\
# Used in `new String`, but useless, in general, since it creates an empty\n\
# string. String only has methods `length`, `concat`, and `substr`.\n\
.globl String_init\n\
String_init:\n\
    # In addition to the default behavior, copies the Int prototype object and\n\
    # uses that as the length, rather than the prototype object directly. No\n\
    # practical reason for this, other than simulating the default init logic for\n\
    # an object with attributes.\n\
\n\
    add fp, sp, 0\n\
    sw ra, 0(sp)\n\
    addi sp, sp, -4\n\
\n\
    # store String argument\n\
    sw s1, 0(sp)\n\
    addi sp, sp, -4\n\
    add s1, a0, zero\n\
\n\
    # copy Int prototype first\n\
\n\
    la a0, Int_protObj\n\
    sw fp, 0(sp)\n\
    addi sp, sp, -4\n\
\n\
    call Object.copy\n\
\n\
    sw a0, 12(s1)      # store new Int as length; value of Int is 0 by default\n\
\n\
    add a0, s1, zero   # restore String argument\n\
\n\
    addi sp, sp, 4\n\
    lw s1, 0(sp)\n\
    lw ra, 0(fp)\n\
    addi sp, sp, 8\n\
    lw fp, 0(sp)\n\
\n\
    ret\n\
\n\
\n\
.globl Main_init\n\
Main_init:\n\
    # stack discipline:\n\
    # callee:\n\
    # - activation frame starts at the stack pointer\n\
    add fp, sp, 0\n\
    # - previous return address is first on the activation frame\n\
    sw ra, 0(sp)\n\
    addi sp, sp, -4\n\
    # before using saved registers (s1 -- s11), push them on the stack\n\
\n\
    # no op\n\
\n\
    # stack discipline:\n\
    # callee:\n\
    # - restore used saved registers (s1 -- s11) from the stack\n\
    # - ra is restored from first word on activation frame\n\
    lw ra, 0(fp)\n\
    # - ra, arguments, and control link are popped from the stack\n\
    addi sp, sp, 8\n\
    # - fp is restored from control link\n\
    lw fp, 0(sp)\n\
    # - result is stored in a0\n\
\n\
    ret\n\
\n\
\n\
# ------------- Class object table ---------------------------------------------\n\
class_objTab:\n\
    .word Object_protObj\n\
    .word Object_init\n\
    .word IO_protObj\n\
    .word IO_init\n\
    .word Int_protObj\n\
    .word Int_init\n\
    .word Bool_protObj\n\
    .word Bool_init\n\
    .word String_protObj\n\
    .word String_init\n\
    .word Main_protObj\n\
    .word Main_init\n\
\n\
    .word -1 # GC tag\n\
_string1.length:\n\
    .word 2  # class tag;       2 for Int\n\
    .word 4  # object size;     4 words (16 bytes); GC tag not included\n\
    .word 0  # dispatch table;  Int has no methods\n\
    .word 13  # first attribute; value of Int\n\
\n\
    .word -1 # GC tag\n\
_string1.content:\n\
    .word 4  # class tag;       4 for String\n\
    .word 8  # object size;     8 words (16 + 16 bytes); GC tag not included\n\
    .word String_dispTab\n\
    .word _string1.length # first attribute; pointer length\n\
    .string \"hello world!\\n\" # includes terminating null char\n\
    .byte 0\n\
    .byte 0\n\
.globl _bool_tag\n\
_bool_tag:\n\
    .word 3\n\
.globl _int_tag\n\
_int_tag:\n\
    .word 2\n\
.globl _string_tag\n\
_string_tag:\n\
    .word 4\n\
";

}
