#ifndef CODEGEN_MNEMONIC_H_
#define CODEGEN_MNEMONIC_H_

enum class Mnemonic {
    Add,
    AddImmediate,
    Subtract,
    Multiply,
    Divide,
    XorImmediate,
    ShiftLeftLogicalImmediate,
    SetEqualZero,
    SetLessThan,
    StoreWord,
    LoadWord,
    LoadAddress,
    Jump,
    JumpAndLink,
    Call,
    JumpAndLinkRegister,
    Return,
    BranchEqualZero,
    BranchNotEqualZero,
    BranchLessThanZero,
    BranchGreaterThanZero,
};

#endif
