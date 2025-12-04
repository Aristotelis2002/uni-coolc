# This is the assembly code for the COOL RISC-V runtime.

# Global _start symbol: the entry point of the runtime.
.globl _start
_start:
    # Configure gp and sp
    # gp is the first free word in memory (RAM)
    la gp, __heap_start
    # sp is the last addressable word in memory
    li sp, 0xfffffffc

    jal _init_types

    # copy Main prototype

    # stack discipline:
    # caller:
    # - self object is passed in a0
    la a0, Main_protObj 
    # - control link is pushed first on the stack
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    # no arguments

    jal Object.copy

    # stack discipline:
    # caller:
    # - read return value from a0
    # no need, just forward (see next call)

    # initialize Main object

    # stack discipline:
    # caller:
    # - self object is passed in a0
    # carried over from previous call
    # - control link is pushed first on the stack
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    # no arguments

    call Main_init       # init Main object

    # stack discipline:
    # caller:
    # - read return value from a0
    # no need, just forward (see next call)

    # call user-defined main function (entry point)

    # stack discipline:
    # caller:
    # - self object is passed in a0
    # carried over from previous call
    # - control link is pushed first on the stack
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    # no arguments

    call Main.main

    # stack discipline:
    # caller:
    # - read return value from a0
    # unused

# Epilogue of the runtime
_end:
    # The next three lines tell Spike to stop the simulation.
    la t0, tohost
    li t1, 1
    sw t1, 0(t0)
    # Infinite loop until the simulation stops.
_inf_loop:
    j _inf_loop

# load the type tags from user-generated labels and store them in the type
# fields of the constants defined in this library
_init_types:
    lw t0, _int_tag
    la t1, _string1.length
    sw t0, 0(t1)
    la t1, _Object.abort.message_length
    sw t0, 0(t1)
    la t1, _String.substr.out_of_range.message_length
    sw t0, 0(t1)
    la t1, _colon_string.message_length
    sw t0, 0(t1)
    la t1, _case_abort_no_match.message_length
    sw t0, 0(t1)
    la t1, _case_abort_on_void.message_length
    sw t0, 0(t1)
    la t1, _newline_string.message_length
    sw t0, 0(t1)

    lw t0, _string_tag
    la t1, _string1.content
    sw t0, 0(t1)
    la t1, _Object.abort.message
    sw t0, 0(t1)
    la t1, _String.substr.out_of_range.message
    sw t0, 0(t1)
    la t1, _colon_string.message
    sw t0, 0(t1)
    la t1, _case_abort_no_match.message
    sw t0, 0(t1)
    la t1, _case_abort_on_void.message
    sw t0, 0(t1)
    la t1, _newline_string.message
    sw t0, 0(t1)

    ret


# ----------------- Object interface -------------------------------------------

.globl Object.abort
Object.abort:
    # stack discipline
    # callee:
    # - activation frame starts at the stack pointer
    add fp, sp, 0
    # - previous return address is first on the activation frame
    sw ra, 0(sp)
    addi sp, sp, -4

    # print abort message

    # stack discipline:
    # caller:
    # - self object is passed in a0
    # no need, since it's not modified
    # - control link is pushed first on the stack
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    la t0, _Object.abort.message
    sw t0, 0(sp)
    addi sp, sp, -4

    jal IO.out_string

    # stack discipline:
    # caller:
    # - read return value from a0
    # no need, since it's not used

    # The next three lines tell Spike to stop the simulation.
    la t0, tohost
    li t1, 1
    sw t1, 0(t0)

    # an infinite loop for good measure
    j _inf_loop

.globl Object.type_name
Object.type_name:
    # stack discipline
    # callee:
    # - activation frame starts at the stack pointer
    add fp, sp, 0
    # - previous return address is first on the activation frame
    sw ra, 0(sp)
    addi sp, sp, -4

    lw a0, 0(a0)          # t0 = class tag
    sll a0, a0, 2         # offset = class tag x 4
    la t0, class_nameTab  # t0 = class_nameTab
    add a0, t0, a0        # a0 = class_nameTab + offset = &X_className
    lw a0, 0(a0)          # a0 = X_className

    # stack discipline:
    # callee:
    # - restore used saved registers (s1 -- s11) from the stack
    # - ra is restored from first word on activation frame
    lw ra, 0(fp)
    # - ra, arguments, and control link are popped from the stack
    addi sp, sp, 8
    # - fp is restored from control link
    lw fp, 0(sp)
    # - result is stored in a0

    ret

# Copies the `from_object` passed as a0.
#
.globl Object.copy
Object.copy:
    # stack discipline
    # callee:
    # - activation frame starts at the stack pointer
    add fp, sp, 0
    # - previous return address is first on the activation frame
    sw ra, 0(sp)
    addi sp, sp, -4

    add t1, a0, zero     # t1 = &from_object
    lw t0, 4(a0)         # t0 = object size = words_left

    li t2, -1            # store GC tag first (before &to_object)
    sw t2, 0(gp)         # ...

    # TODO: rather than using gp directly, implement Mem functions
    addi gp, gp, 4       # move "to_object" ptr

    add a0, gp, zero     # result = &to_object

_Object.copy_loop:
    lw t2, 0(t1)         # copy word
    sw t2, 0(gp)         # ...

    addi t1, t1, 4       # move "from" ptr
    addi gp, gp, 4       # move "to" ptr
    addi t0, t0, -1      # --words_left
    bnez t0, _Object.copy_loop

    # stack discipline:
    # callee:
    # - restore used saved registers (s1 -- s11) from the stack
    # - ra is restored from first word on activation frame
    lw ra, 0(fp)
    # - ra, arguments, and control link are popped from the stack
    addi sp, sp, 8
    # - fp is restored from control link
    lw fp, 0(sp)
    # - result is stored in a0

    ret

# ----------------- IO interface -----------------------------------------------

# Prints the String provided in fn-arg1 to the stdout.
#
# Returns the a0 argument for method chaining.
.globl IO.out_string
IO.out_string:
    # stack discipline:
    # callee:
    # - activation frame starts at the stack pointer
    add fp, sp, 0
    # - previous return address is first on the activation frame
    sw ra, 0(sp)
    addi sp, sp, -4

    lw t2, 4(fp) # load the argument in t2

    la t0, tohost_data
    # 64 = sys_write
    li t1, 64
    sw t1, 0(t0)   # tohost_data[0] = t1 = 64

    # fd = file descriptor where to write
    # 1 = stdout
    li t1, 1
    sw t1, 8(t0)   # tohost_data[1] = t1 = 1

    # pbuf = address of data to write
    # 16(fn-arg): address of string start
    addi t1, t2, 16
    sw t1, 16(t0)  # tohost_data[2] = &content

    # len = length of data to write
    # 12(fn-arg): string length as Int
    lw t1, 12(t2)  # load address of Int
    lw t1, 12(t1)  # load value of Int
    sw t1, 24(t0)  # tohost_data[3] = length

    # make syscall
    la t0, tohost
    la t1, tohost_data
    sw t1, 0(t0)   # *tohost = tohost_data

    la t0, fromhost
    sw zero, 0(t0)              # fromhost[0] = 0
_IO.out_string.await_write:
    lw t1, 0(t0)                # t1 = fromhost[0]
    beq t1, zero, _IO.out_string.await_write  # while t1 == zero: loop

    # stack discipline:
    # callee:
    # - restore used saved registers (s1 -- s11) from the stack
    # - ra is restored from first word on activation frame
    lw ra, 0(fp)
    # - ra, arguments, and control link are popped from the stack
    addi sp, sp, 12
    # - fp is restored from control link
    lw fp, 0(sp)
    # - result is stored in a0
    # a0 is not touched by the impl, so self will be returned as 
    ret


# Prints the Int provided in fn-arg1 to the stdout.
#
# Returns the a0 argument for method chaining.
.globl IO.out_int
IO.out_int:
    # stack discipline:
    # callee:
    # - activation frame starts at the stack pointer
    add fp, sp, 0
    # - previous return address is first on the activation frame
    sw ra, 0(sp)
    addi sp, sp, -4

    # exploit the fact that the stack pointer is growing backwards and store the
    # terminating null char first
    add t3, sp, 0
    sb zero, 0(t3) # string terminating null char

    lw t0, 4(fp)  # t0 = fn-arg1
    lw t0, 12(t0) # t0 = fn-arg1->value
    li t4, 1
    beqz t0, _IO.out_int.print_zero

    bgtz t0, _IO.out_int.positive

    li t4, -1
    neg t0, t0

_IO.out_int.positive:   
    li t1, 10

_IO.out_int.loop:
    beqz t0, _IO.out_int.sign_adj

    rem t2, t0, t1
    addi t2, t2, 0x30 # convert digit to char

    addi t3, t3, -1
    sb t2, 0(t3) # print digit

    div t0, t0, t1
    j _IO.out_int.loop

_IO.out_int.sign_adj:
    bgez t4, _IO.out_int.print

    li t2, 0x2d 
    addi t3, t3, -1
    sb t2, 0(t3) # print '-'

    j _IO.out_int.print

_IO.out_int.print_zero:
    li t2, 0x30
    addi t3, t3, -1
    sb t2, 0(t3) # print '0'

_IO.out_int.print:
    sub t2, sp, t3  # length = sp - t3

    la t0, tohost_data
    # 64 = sys_write
    li t1, 64
    sw t1, 0(t0)   # tohost_data[0] = t1 = 64

    # fd = file descriptor where to write
    # 1 = stdout
    li t1, 1
    sw t1, 8(t0)   # tohost_data[1] = t1 = 1

    # pbuf = address of data to write
    # 16(t0): address of string start
    sw t3, 16(t0)  # tohost_data[2] = &content

    # len = length of data to write
    # 12(t0): string length as Int
    sw t2, 24(t0)  # tohost_data[3] = length

    # make syscall
    la t0, tohost
    la t1, tohost_data
    sw t1, 0(t0)   # *tohost = tohost_data

    la t0, fromhost
    sw zero, 0(t0)              # fromhost[0] = 0
_IO.out_int.await_write:
    lw t1, 0(t0)                # t1 = fromhost[0]
    beq t1, zero, _IO.out_int.await_write  # while t1 == zero: loop

    # not strictly needed, but improves sanity
_IO.out_int.clear_stack:
    sb zero, 0(t3)
    beq t3, sp, _IO.out_int.end
    addi t3, t3, 1
    j _IO.out_int.clear_stack

_IO.out_int.end:
    # stack discipline:
    # callee:
    # - restore used saved registers (s1 -- s11) from the stack
    # - ra is restored from first word on activation frame
    lw ra, 0(fp)
    # - ra, arguments, and control link are popped from the stack
    addi sp, sp, 12
    # - fp is restored from control link
    lw fp, 0(sp)
    # - result is stored in a0

    ret


# Reads a String from stdin and returns it to a0.
.globl IO.in_string
IO.in_string:
    # stack discipline:
    # callee:
    # - activation frame starts at the stack pointer
    add fp, sp, 0
    # - previous return address is first on the activation frame
    sw ra, 0(sp)
    addi sp, sp, -4

    # copy Int prototype first, to store the length

    # stack discipline:
    # caller:
    # - self object is passed in a0
    la a0, Int_protObj 
    # - control link is pushed first on the stack
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    # no arguments

    jal Object.copy

    # stack discipline:
    # caller:
    # - read return value from a0
    # save previous value of s1 first
    sw s1, 0(sp)
    addi sp, sp, -4
    # save address of Int before next fn call
    add s1, a0, zero   

    # copy String prototype

    # stack discipline:
    # caller:
    # - self object is passed in a0
    la a0, String_protObj 
    # - control link is pushed first on the stack
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    # no arguments

    jal Object.copy

    # stack discipline:
    # callee: restores sp so that fp is popped
    # next word on the stack: s1

    # stack discipline:
    # caller:
    # - read return value from a0
    sw s1, 12(a0)         # store address of Int

    addi t2, a0, 16

_IO.in_string.read_char:
    la t0, tohost_data
    # 63 = sys_read
    li t1, 63
    sw t1, 0(t0)

    # 0 = stdin
    li t1, 0
    sw t1, 8(t0)

    # address of where to store read byte
    # temporarily: address of string argument content
    sw t2, 16(t0)

    # 1 = length of data to read
    li t1, 1
    sw t1, 24(t0)

    # TODO: can 0 actually be read from stdin?
    # store 0, so that beqz can be used for _IO.in_string.await_data
    sb zero, 0(t2)

    # make syscall
    la t0, tohost
    la t1, tohost_data
    sw t1, 0(t0)

    li t1, 0
    # loop until byte is read; this is necessary, since reading does not block:
    # the byte would just "magically" appear, when the simulator sets it
_IO.in_string.await_data:
	# Load read byte in t1; Ctrl-C Spike and write `reg 0` to verify value
    lb t1, 0(t2)
    beqz t1, _IO.in_string.await_data

    # increase "to-read" pointer
    addi t2, t2, 1

    # loop until newline is read
    li t0, 0x0a # newline character
    bne t1, t0, _IO.in_string.read_char

    # move the pointer one char back to overwrite '\n'
    addi t2, t2, -1

    # store the length in the String
    addi t1, a0, 16
    sub t1, t2, t1

    lw t0, 12(a0)  # load address of Int
    sw t1, 12(t0)  # store value of Int

_IO.in_string.pad_with_zeros:
    sb zero, 0(t2)

    addi t2, t2, 1
    andi t1, t2, 3
    bnez t1, _IO.in_string.pad_with_zeros

    # store object size in the String
    addi t1, a0, 16
    sub t1, t2, t1
    sra t1, t1, 2
    addi t1, t1, 4 # add 4 words for tag, size, disptab, and length
    sw t1, 4(a0)

    # TODO: use Mem alloc or something for String
    # adjust gp; initially, Object.copy allocated 5 words for the string; the
    # real size is computed in t1
    addi t1, t1, -5 # t1 = remaining words
    sll t1, t1, 2   # t1 = remaining bytes
    add gp, gp, t1  # gp += remaining bytes

    # stack discipline:
    # callee:
    # - restore used saved registers (s1 -- s11) from the stack
    addi sp, sp, 4
    lw s1, 0(sp)
    # - ra is restored from first word on activation frame
    lw ra, 0(fp)
    # - ra, arguments, and control link are popped from the stack
    addi sp, sp, 8
    # - fp is restored from control link
    lw fp, 0(sp)
    # - result is stored in a0

    ret


# Reads an Int from stdin and returns it to a0.
#
# Ignores leading spaces, but nothing else. Ignores all symbols starting from
# the first non-digit until the first new-line.
#
# Examples:
# - [space]x4x\n is read as 0
# - [space]4x\n is read as 4
# - [space]x\n is read as 0
# - [space]4[space]4\n is read as 4
# - [space]4x4\n is read as 4
# - 4\n is read as 4
# - 4[space]\n is read as 4
# - 44\n is read as 44
# - -4\n is read as -4
# - -[space]4\n is read as 0
# - [space]-4\n is read as -4
# - [space]-44\n is read as -44
# - [space]-44x\n is read as -44
# - [space]--44x\n is read as 0
.globl IO.in_int
IO.in_int:
    # stack discipline:
    # callee:
    # - activation frame starts at the stack pointer
    add fp, sp, 0
    # - previous return address is first on the activation frame
    sw ra, 0(sp)
    addi sp, sp, -4

    # copy Int prototype

    # stack discipline:
    # caller:
    # - self object is passed in a0
    la a0, Int_protObj 
    # - control link is pushed first on the stack
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    # no arguments

    jal Object.copy

    # stack discipline:
    # caller:
    # - read return value from a0
    addi t2, a0, 8     # use dispatch_table as scratch memory, because YOLO
                       # (also, because there is no dispatch table for Int)

    add t3, zero, zero # t3 is the state of the function:
                       # 0 means "no digits or - seen yet"
                       # 1 means "digits are being read"
                       # 2 means "ignore until newline"

    li t4, 1 # t4 is whether the number is negative:
             # 1 means "number is positive"
             # -1 means "number is negative"

    sw zero, 12(a0) # start with a 0 and build from there

_IO.in_int.read_char:
    la t0, tohost_data
    # 63 = sys_read
    li t1, 63
    sw t1, 0(t0)

    # 0 = stdin
    li t1, 0
    sw t1, 8(t0)

    # address of where to store read byte
    # reusing dispatch_table field, if it works...
    sw t2, 16(t0)

    # 1 = length of data to read
    li t1, 1
    sw t1, 24(t0)

    # make syscall
    la t0, tohost
    la t1, tohost_data
    sw t1, 0(t0)

    la t6, fromhost
    sw zero, 0(t6)              # fromhost[0] = 0

    # loop until byte is read; this is necessary, since reading does not block:
    # the byte would just "magically" appear, when the simulator sets it
_IO.in_int.await_data:
    lw t1, 0(t6)              # t1 = fromhost[0]
    beqz t1, _IO.in_int.await_data

	# Load read byte in t1; Ctrl-C Spike and write `reg 0` to verify value
    lb t1, 0(t2)

    bne t3, zero, _IO.in_int.state_maybe1

_IO.in_int.state0:
    li t0, 0x20 # space character: just ignore
    beq t1, t0, _IO.in_int.read_char
    
    li t0, 0x2d # '-' character
    beq t1, t0, _IO.in_int.negate

    li t0, 0x30 # '0' character
    blt t1, t0, _IO.in_int.set_state2

    li t0, 0x39 # '9' character
    blt t0, t1, _IO.in_int.set_state2

    j _IO.in_int.set_state1

_IO.in_int.negate:
    li t4, -1              # number is negative
    li t3, 1               # state is now 1
    j _IO.in_int.read_char # loop

_IO.in_int.set_state1:
    li t3, 1
    j _IO.in_int.state1

_IO.in_int.state_maybe1:
    li t0, 1
    bne t3, t0, _IO.in_int.state2

_IO.in_int.state1:
    li t0, 0x39 # '9' character
    blt t0, t1, _IO.in_int.set_state2

    li t0, 0x30 # '0' character
    blt t1, t0, _IO.in_int.set_state2

    sub t1, t1, t0
    mul t1, t1, t4 # make negative, if needed

    lw t0, 12(a0)  # load intermediate result
    li t5, 10      # t5 = 10
    mul t0, t0, t5 # multiply by 10
    add t0, t0, t1 # add new contribution
    sw t0, 12(a0)  # update intermediate result

    j _IO.in_int.read_char # loop

_IO.in_int.set_state2:
    li t3, 2
    j _IO.in_int.state2

_IO.in_int.state2:
    # loop until newline is read
    li t0, 0x0a # newline character
    bne t1, t0, _IO.in_int.read_char

    sw zero, 8(a0) # reset dispatch_table to 0

    # stack discipline:
    # callee:
    # - restore used saved registers (s1 -- s11) from the stack
    # - ra is popped off the stack

    addi sp, sp, 4
    lw ra, 0(sp)

    # - arguments are popped off the stack
    # no arguments

    # - control link is popped from the stack
    addi sp, sp, 4
    lw fp, 0(sp)
    # - result is stored in a0


    ret

# ----------------- Int interface ----------------------------------------------

# none

# ----------------- String interface -------------------------------------------

# Returns in a0 the Int object, that represents the length of the String passed
# as a0.
.globl String.length
String.length:
    # stack discipline:
    # callee:
    # - activation frame starts at the stack pointer
    add fp, sp, 0
    # - previous return address is first on the activation frame
    sw ra, 0(sp)
    addi sp, sp, -4

    lw a0, 12(a0) # load address of Int

    # stack discipline:
    # callee:
    # - restore used saved registers (s1 -- s11) from the stack
    # - ra is restored from first word on activation frame
    lw ra, 0(fp)
    # - ra, arguments, and control link are popped from the stack
    addi sp, sp, 8
    # - fp is restored from control link
    lw fp, 0(sp)
    # - result is stored in a0

    ret


# Returns in a0 a new String object, that is the concatenation of the self
# String (passed in a0) and the method argument (passed in fn-arg1).
.globl String.concat
String.concat:
    # stack discipline:
    # callee:
    # - activation frame starts at the stack pointer
    add fp, sp, 0
    # - previous return address is first on the activation frame
    sw ra, 0(sp)
    addi sp, sp, -4

    sw s1, 0(sp)
    addi sp, sp, -4
    add s1, a0, zero   # store self in s1

    # copy Int prototype first, to store the length

    # stack discipline:
    # caller:
    # - self object is passed in a0
    la a0, Int_protObj
    # - control link is pushed first on the stack
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    # no arguments

    jal Object.copy

    # stack discipline:
    # caller:
    # - read return value from a0

    sw s2, 0(sp)
    addi sp, sp, -4
    add s2, a0, zero   # save address of Int before next fn call

    # copy String prototype

    # stack discipline:
    # caller:
    # - self object is passed in a0
    la a0, String_protObj
    # - control link is pushed first on the stack
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    # no arguments

    jal Object.copy

    # stack discipline:
    # caller:
    # - read return value from a0

    sw s2, 12(a0)         # store address of Int

    addi t2, a0, 16    # t2 = &new_content
    addi t4, s1, 16    # t4 = &self->content

    lw t3, 12(s1)      # t3 = &self->length
    lw t3, 12(t3)      # t3 = self->length->value

_String.concat.copy_first:
    beqz t3, _String.concat.copy_second

    lb t1, 0(t4)       # t1 = self->content[i]
    sb t1, 0(t2)       # new_content[i] = t1
    addi t4, t4, 1     # ++i
    addi t2, t2, 1     # ...
    addi t3, t3, -1    # ...
    j _String.concat.copy_first

_String.concat.copy_second:

    lw t3, 4(fp)       # t3 = fn-arg1
    lw t3, 12(t3)      # t3 = &arg->length
    lw t3, 12(t3)      # t3 = arg->length->value

    lw t4, 4(fp)       # t4 = fn-arg1
    addi t4, t4, 16    # t4 = &arg->content

_String.concat.copy_second_loop:
    beqz t3, _String.concat.compute_length

    lb t1, 0(t4)       # t1 = self->content[i]
    sb t1, 0(t2)       # new_content[i] = t1
    addi t4, t4, 1     # ++i
    addi t2, t2, 1     # ...
    addi t3, t3, -1    # ...
    j _String.concat.copy_second_loop

_String.concat.compute_length:
    # store the length in the String
    addi t1, a0, 16    # t1 = &result->content
    sub t1, t2, t1     # t1 = offset of [first byte past last written byte] from &result->content

    lw t0, 12(a0)  # load address of Int
    sw t1, 12(t0)  # store value of Int

_String.concat.pad_with_zeros:
    sb zero, 0(t2)

    addi t2, t2, 1
    andi t1, t2, 3
    bnez t1, _String.concat.pad_with_zeros

    # store object size in the String
    addi t1, a0, 16    # t1 = &result->content
    sub t1, t2, t1     # t1 = offset of [first byte past last zero-pad byte] from &result->content
    sra t1, t1, 2      # t1 /= 4
    addi t1, t1, 4     # add 4 words for tag, size, disptab, and length
    sw t1, 4(a0)       # result->object_size = t1

    # adjust gp; initially, Object.copy allocated 5 words for the string; the
    # real size is computed in t1
    addi t1, t1, -5 # t1 = remaining words
    sll t1, t1, 2   # t1 = remaining bytes
    add gp, gp, t1  # gp += remaining bytes
    # TODO: use Mem alloc or sth; (infinite buffer :sparkle:)

    # stack discipline:
    # callee:
    # - restore used saved registers (s1 -- s11) from the stack
    addi sp, sp, 4
    lw s2, 0(sp)
    addi sp, sp, 4
    lw s1, 0(sp)
    # - ra is restored from first word on activation frame
    lw ra, 0(fp)
    # - ra, arguments, and control link are popped from the stack
    addi sp, sp, 12
    # - fp is restored from control link
    lw fp, 0(sp)
    # - result is stored in a0

    ret


# Returns in a0 the String object, that represents the substring of the String passed
# as a0 starting from (0-indexed) index `from` (in fn-arg1; an Int) and length
# `length` (in fn-arg2; an Int).
#
# Execution terminates if the requested substring is out of range and an error
# message is printed.
.globl String.substr
String.substr:
    # stack discipline
    # callee:
    # - activation frame starts at the stack pointer
    add fp, sp, 0
    # - previous return address is first on the activation frame
    sw ra, 0(sp)
    addi sp, sp, -4

    lw t0, 8(fp)   # t0 = from (fn-arg1)
    lw t0, 12(t0)  # t0 = from->value
    bltz t0, _String.substr.out_of_range

    lw t1, 4(fp)   # t1 = length (fn-arg2)
    lw t1, 12(t1)  # t1 = length->value
    bltz t1, _String.substr.out_of_range

    lw t2, 12(a0)
    lw t2, 12(t2)  # t2 = self->length->value
    add t3, t0, t1 # t3 = from->value + length->value
    blt t2, t3, _String.substr.out_of_range

    # indexes are good; create a new String and copy content
    sw s1, 0(sp)
    addi sp, sp, -4
    add s1, a0, zero   # store self in s1

    # copy Int prototype first, to store the length

    # stack discipline:
    # caller:
    # - self object is passed in a0
    la a0, Int_protObj
    # - control link is pushed first on the stack
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    # no arguments

    jal Object.copy

    # stack discipline:
    # caller:
    # - read return value from a0
    sw s2, 0(sp)
    addi sp, sp, -4
    add s2, a0, zero   # save address of Int before next fn call

    # copy String prototype

    # stack discipline:
    # caller:
    # - self object is passed in a0
    la a0, String_protObj 
    # - control link is pushed first on the stack
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    # no arguments

    jal Object.copy       # ...

    # stack discipline:
    # caller:
    # - read return value from a0

    sw s2, 12(a0)      # store address of Int

    addi t2, a0, 16    # t2 = &new_content
    addi t4, s1, 16    # t4 = &self->content
    lw t0, 8(fp)       # t0 = from (fn-arg1)
    lw t0, 12(t0)      # t0 = from->value

    add t4, t4, t0    # t4 = &self->content[from->value]

    lw t3, 4(fp)       # t3 = length (fn-arg2)
    lw t3, 12(t3)      # t3 = length->value

_String.substr.copy:
    beqz t3, _String.substr.store_length

    lb t1, 0(t4)       # t1 = self->content[i]
    sb t1, 0(t2)       # new_content[i] = t1
    addi t4, t4, 1     # ++i
    addi t2, t2, 1     # ...
    addi t3, t3, -1    # ...
    j _String.substr.copy

_String.substr.store_length:
    # store the length in the String
    addi t1, a0, 16    # t1 = &result->content
    sub t1, t2, t1     # t1 = offset of [first byte past last written byte] from &result->content

    lw t0, 12(a0)  # load address of Int
    sw t1, 12(t0)  # store value of Int

_String.substr.pad_with_zeros:
    sb zero, 0(t2)

    addi t2, t2, 1
    andi t1, t2, 3
    bnez t1, _String.substr.pad_with_zeros

    # store object size in the String
    addi t1, a0, 16    # t1 = &result->content
    sub t1, t2, t1     # t1 = offset of [first byte past last zero-pad byte] from &result->content
    sra t1, t1, 2      # t1 /= 4
    addi t1, t1, 4     # add 4 words for tag, size, disptab, and length
    sw t1, 4(a0)       # result->object_size = t1

    # adjust gp; initially, Object.copy allocated 5 words for the string; the
    # real size is computed in t1
    addi t1, t1, -5 # t1 = remaining words
    sll t1, t1, 2   # t1 = remaining bytes
    add gp, gp, t1  # gp += remaining bytes
    # TODO: Mem alloc

    # stack discipline:
    # callee:
    # - restore used saved registers (s1 -- s11) from the stack
    addi sp, sp, 4
    lw s2, 0(sp)
    addi sp, sp, 4
    lw s1, 0(sp)
    # - ra is restored from first word on activation frame
    lw ra, 0(fp)
    # - ra, arguments, and control link are popped from the stack
    addi sp, sp, 16
    # - fp is restored from control link
    lw fp, 0(sp)
    # - result is stored in a0

    ret
    # function not over yet...

_String.substr.out_of_range:
    # print abort message

    # stack discipline:
    # caller:
    # - self object is passed in a0
    # no need, since it's not modified
    # - control link is pushed first on the stack
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    la t0, _String.substr.out_of_range.message
    sw t0, 0(sp)
    addi sp, sp, -4

    jal IO.out_string

    # stack discipline:
    # caller:
    # - read return value from a0
    # unused

    # The next three lines tell Spike to stop the simulation.
    la t0, tohost
    li t1, 1
    sw t1, 0(t0)

    # an infinite loop for good measure
    j _inf_loop


# ----------------- Bool interface ---------------------------------------------

# none

# ------------- End of implementation of predefined classes --------------------

# ----------------- Utility functions ------------------------------------------

.globl _compare_equal
_compare_equal:
# Caller convention: callee prelude
    add fp, sp, zero
    sw ra, 0(sp)    # fp[0]: ra
    addi sp, sp, -4
    sw a0, 0(sp)    # fp[-4]: self
    addi sp, sp, -4

    # copy Bool prototype to store the result
    la a0, Bool_protObj
    sw fp, 0(sp)
    addi sp, sp, -4
    jal Object.copy

    sw a0, 0(sp)    # fp[-8]: result
    addi sp, sp, -4

    lw t0, 4(fp)       # t0 = fn-arg1
    lw t1, -4(fp)      # t1 = self

    # check dynamic types are the same
    lw t2, 0(t0)
    lw t3, 0(t1)
    bne t2, t3, _compare_equal_end

    # if type is String: call _string_compare
    lw t3, _string_tag
    bne t2, t3, _compare_equal_not_string

    # call _string_compare
    lw a0, -4(fp)
    sw fp, 0(sp)
    addi sp, sp, -4
    lw t0, 4(fp)
    sw t0, 0(sp)
    addi sp, sp, -4
    jal _string_compare
    # result is in a0

    addi sp, sp, 8
    lw ra, 0(fp)
    addi sp, sp, 12
    lw fp, 0(sp)
    ret

_compare_equal_not_string:
    # if type is Int: subtract values, not pointers
    lw t3, _int_tag
    bne t2, t3, _compare_equal_not_int
    lw t0, 12(t0)
    lw t1, 12(t1)
    j _compare_equal_basic

_compare_equal_not_int:
    # if type is Bool: subtract values, not pointers
    lw t3, _bool_tag
    bne t2, t3, _compare_equal_basic
    lw t0, 12(t0)
    lw t1, 12(t1)
    j _compare_equal_basic

_compare_equal_basic:
    # subtract pointers and check if zero
    sub t0, t0, t1
    seqz t0, t0
    lw t1, -8(fp)
    sw t0, 12(t1)

_compare_equal_end:
    lw a0, -8(fp)    # result: fp[-8]
    addi sp, sp, 8

    lw ra, 0(fp)
    addi sp, sp, 12
    lw fp, 0(sp)

    ret


.globl _string_compare
_string_compare:
# Caller convention: callee prelude
    add fp, sp, zero
    sw ra, 0(sp)    # fp[0]: ra
    addi sp, sp, -4
    sw a0, 0(sp)    # fp[-4]: self
    addi sp, sp, -4

    # copy Bool prototype to store the result
    la a0, Bool_protObj
    sw fp, 0(sp)
    addi sp, sp, -4
    jal Object.copy

    sw a0, 0(sp)    # fp[-8]: result
    addi sp, sp, -4

    lw t0, 4(fp)       # t0 = fn-arg1
    lw t0, 12(t0)      # t0 = &arg->length
    lw t0, 12(t0)      # t0 = arg->length->value

    lw t1, -4(fp)      # t1 = self
    lw t1, 12(t1)      # t1 = &self->length
    lw t1, 12(t1)      # t1 = self->length->value

    # if lengths are different, return false
    bne t0, t1, _string_compare_end

_string_compare_pre_loop:
    # result = true by default
    addi t1, zero, 1
    sw t1, 12(a0)
    lw t1, 4(fp)       # t1 = fn-arg1
    addi t1, t1, 16    # t1 = &self->data
    lw t2, -4(fp)      # t2 = self
    addi t2, t2, 16    # t2 = &self->data

_string_compare_loop:
    beqz t0, _string_compare_end
    lb t3, 0(t1)
    lb t4, 0(t2)
    beq t3, t4, _string_compare_loop_again
    sw zero, 12(a0)
    j _string_compare_end
_string_compare_loop_again:
    addi t0, t0, -1
    addi t1, t1, 1
    addi t2, t2, 1
    j _string_compare_loop

_string_compare_end:
    lw a0, -8(fp)    # result: fp[-8]
    addi sp, sp, 8

    lw ra, 0(fp)
    addi sp, sp, 12
    lw fp, 0(sp)

    ret


# signature: _case_abort_no_match(file_name: String, line_no: Int, class_name: String): no_ret
.globl _case_abort_no_match
_case_abort_no_match:
    # stack discipline
    # callee:
    # - activation frame starts at the stack pointer
    add fp, sp, 0
    # - previous return address is first on the activation frame
    sw ra, 0(sp)
    addi sp, sp, -4

    # print abort message

    # print file name
    sw fp, 0(sp)
    addi sp, sp, -4
    lw t0, 12(fp) # file_name is first argument to _case_abort_no_match
    sw t0, 0(sp)
    addi sp, sp, -4
    jal IO.out_string

    # print colon
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    la t0, _colon_string.message
    sw t0, 0(sp)
    addi sp, sp, -4
    jal IO.out_string

    # print line number
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    lw t0, 8(fp) # line_no is the second argument of _case_abort_no_match
    sw t0, 0(sp)
    addi sp, sp, -4
    jal IO.out_int

    # print abort message
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    la t0, _case_abort_no_match.message
    sw t0, 0(sp)
    addi sp, sp, -4
    jal IO.out_string

    # print class name
    sw fp, 0(sp)
    addi sp, sp, -4
    lw t0, 4(fp) # class_name is third argument to _case_abort_no_match
    sw t0, 0(sp)
    addi sp, sp, -4
    jal IO.out_string

    # print newline
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    la t0, _newline_string.message
    sw t0, 0(sp)
    addi sp, sp, -4
    jal IO.out_string

    # The next three lines tell Spike to stop the simulation.
    la t0, tohost
    li t1, 1
    sw t1, 0(t0)

    # an infinite loop for good measure
    j _inf_loop


# signature: _case_abort_on_void(file_name: String, line_no: Int): no_ret
.globl _case_abort_on_void
_case_abort_on_void:
    # stack discipline
    # callee:
    # - activation frame starts at the stack pointer
    add fp, sp, 0
    # - previous return address is first on the activation frame
    sw ra, 0(sp)
    addi sp, sp, -4

    # print abort message

    # print file name
    sw fp, 0(sp)
    addi sp, sp, -4
    lw t0, 8(fp) # file_name is first argument to _case_abort_on_void
    sw t0, 0(sp)
    addi sp, sp, -4
    jal IO.out_string

    # print colon
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    la t0, _colon_string.message
    sw t0, 0(sp)
    addi sp, sp, -4
    jal IO.out_string

    # print line number
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    lw t0, 4(fp) # line_no is the second argument of _case_abort_on_void
    sw t0, 0(sp)
    addi sp, sp, -4
    jal IO.out_int

    # print abort message
    sw fp, 0(sp)
    addi sp, sp, -4
    # - arguments are pushed in reverse order on the stack
    la t0, _case_abort_on_void.message
    sw t0, 0(sp)
    addi sp, sp, -4
    jal IO.out_string

    # The next three lines tell Spike to stop the simulation.
    la t0, tohost
    li t1, 1
    sw t1, 0(t0)

    # an infinite loop for good measure
    j _inf_loop


# -----------End of Utility functions ------------------------------------------

.data

# ------------- Spike interop --------------------------------------------------

# Special symbols `tohost` and `fromhost` used to interact with the Spike
# simulator.
.p2align 4
tohost:
    .dword 0

fromhost:
    .dword 0

tohost_data:
    .dword 0, 0, 0, 0, 0, 0, 0, 0

fromhost_data:
    .dword 0, 0, 0, 0, 0, 0, 0, 0


# ------------- Class object table ---------------------------------------------
class_objTab:
    .word Object_protObj
    .word Object_init
    .word IO_protObj
    .word IO_init
    .word Int_protObj
    .word Int_init
    .word Bool_protObj
    .word Bool_init
    .word String_protObj
    .word String_init
    .word Main_protObj
    .word Main_init

    .word -1 # GC tag
_string1.length:
    .word -1  # class tag; loaded in _init_types
    .word 4  # object size;     4 words (16 bytes); GC tag not included
    .word 0  # dispatch table;  Int has no methods
    .word 13  # first attribute; value of Int

    .word -1 # GC tag
_string1.content:
    .word -1  # class tag; loaded in _init_types
    .word 17  # object size;    8 words (16 + 16 bytes); GC tag not included
    .word String_dispTab
    .word _string1.length # first attribute; pointer length
    .string "hello world!\n" # includes terminating null char
    .byte 0
    .byte 0

# ------------- System messages ------------------------------------------------

    .word -1 # GC tag
_Object.abort.message_length:
    .word -1  # class tag; loaded in _init_types
    .word 4  # object size;     4 words (16 bytes); GC tag not included
    .word 0  # dispatch table;  Int has no methods
    .word 49  # first attribute; value of Int

    .word -1 # GC tag
_Object.abort.message:
    .word -1  # class tag; loaded in _init_types
    .word 17  # object size;     17 words (16 + 52 bytes); GC tag not included
    .word String_dispTab
    .word _Object.abort.message_length # first attribute; pointer length
    .string "Program terminated due to call to Object.abort()\n" # includes terminating null char
    .byte 0
    .byte 0

    .word -1 # GC tag
_String.substr.out_of_range.message_length:
    .word -1  # class tag; loaded in _init_types
    .word 4  # object size;     4 words (16 bytes); GC tag not included
    .word 0  # dispatch table;  Int has no methods
    .word 59  # first attribute; value of Int

    .word -1 # GC tag
_String.substr.out_of_range.message:
    .word -1  # class tag; loaded in _init_types
    .word 19  # object size;     19 words (16 + 60 bytes); GC tag not included
    .word String_dispTab
    .word _String.substr.out_of_range.message_length # first attribute; pointer length
    .string "Call to String.substr() requested a substring out of range\n" # includes terminating null char
    # no padding needed, since length divides by 4

    .word -1 # GC tag
_colon_string.message_length:
    .word -1  # class tag; loaded in _init_types
    .word 4  # object size;     4 words (16 bytes); GC tag not included
    .word 0  # dispatch table;  Int has no methods
    .word 1  # first attribute; value of Int

    .word -1 # GC tag
_colon_string.message:
    .word -1  # class tag; loaded in _init_types
    .word 5  # object size;     5 words (16 + 4 bytes); GC tag not included
    .word String_dispTab
    .word _colon_string.message_length # first attribute; pointer length
    .string ":" # includes terminating null char
    .byte 0
    .byte 0

    .word -1 # GC tag
_case_abort_no_match.message_length:
    .word -1  # class tag; loaded in _init_types
    .word 4  # object size;     4 words (16 bytes); GC tag not included
    .word 0  # dispatch table;  Int has no methods
    .word 38  # first attribute; value of Int

    .word -1 # GC tag
_case_abort_no_match.message:
    .word -1  # class tag; loaded in _init_types
    .word 14  # object size;     14 words (16 + 40 bytes); GC tag not included
    .word String_dispTab
    .word _case_abort_no_match.message_length # first attribute; pointer length
    .string " No match in case statement for Class " # includes terminating null char
    .byte 0

    .word -1 # GC tag
_case_abort_on_void.message_length:
    .word -1  # class tag; loaded in _init_types
    .word 4  # object size;     4 words (16 bytes); GC tag not included
    .word 0  # dispatch table;  Int has no methods
    .word 34  # first attribute; value of Int

    .word -1 # GC tag
_case_abort_on_void.message:
    .word -1  # class tag; loaded in _init_types
    .word 13  # object size;     13 words (16 + 36 bytes); GC tag not included
    .word String_dispTab
    .word _case_abort_on_void.message_length # first attribute; pointer length
    .string " Match on void in case statement.\n" # includes terminating null char
    .byte 0

    .word -1 # GC tag
_newline_string.message_length:
    .word -1  # class tag; loaded in _init_types
    .word 4  # object size;     4 words (16 bytes); GC tag not included
    .word 0  # dispatch table;  Int has no methods
    .word 1  # first attribute; value of Int

    .word -1 # GC tag
_newline_string.message:
    .word -1  # class tag; loaded in _init_types
    .word 5  # object size;     5 words (16 + 4 bytes); GC tag not included
    .word String_dispTab
    .word _newline_string.message_length # first attribute; pointer length
    .string "\n" # includes terminating null char
    .byte 0
    .byte 0
