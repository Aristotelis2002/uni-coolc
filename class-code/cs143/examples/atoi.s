	.data
	.align	2
	.globl	class_nameTab
	.globl	Main_protObj
	.globl	Int_protObj
	.globl	String_protObj
	.globl	bool_const0
	.globl	bool_const1
	.globl	_int_tag
	.globl	_bool_tag
	.globl	_string_tag
_int_tag:
	.word	2
_bool_tag:
	.word	3
_string_tag:
	.word	4
	.globl	_MemMgr_INITIALIZER
_MemMgr_INITIALIZER:
	.word	_NoGC_Init
	.globl	_MemMgr_COLLECTOR
_MemMgr_COLLECTOR:
	.word	_NoGC_Collect
	.globl	_MemMgr_TEST
_MemMgr_TEST:
	.word	0
	.word	-1
str_const22:
	.word	4
	.word	6
	.word	String_dispTab
	.word	int_const4
	.ascii	"Main"
	.byte	0	
	.align	2
	.word	-1
str_const21:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const3
	.ascii	"A2I"
	.byte	0	
	.align	2
	.word	-1
str_const20:
	.word	4
	.word	6
	.word	String_dispTab
	.word	int_const6
	.ascii	"String"
	.byte	0	
	.align	2
	.word	-1
str_const19:
	.word	4
	.word	6
	.word	String_dispTab
	.word	int_const4
	.ascii	"Bool"
	.byte	0	
	.align	2
	.word	-1
str_const18:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const3
	.ascii	"Int"
	.byte	0	
	.align	2
	.word	-1
str_const17:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const2
	.ascii	"IO"
	.byte	0	
	.align	2
	.word	-1
str_const16:
	.word	4
	.word	6
	.word	String_dispTab
	.word	int_const6
	.ascii	"Object"
	.byte	0	
	.align	2
	.word	-1
str_const15:
	.word	4
	.word	8
	.word	String_dispTab
	.word	int_const11
	.ascii	"<basic class>"
	.byte	0	
	.align	2
	.word	-1
str_const14:
	.word	4
	.word	6
	.word	String_dispTab
	.word	int_const4
	.ascii	"2.cl"
	.byte	0	
	.align	2
	.word	-1
str_const13:
	.word	4
	.word	9
	.word	String_dispTab
	.word	int_const12
	.ascii	"../examples/atoi.cl"
	.byte	0	
	.align	2
	.word	-1
str_const12:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const1
	.ascii	"+"
	.byte	0	
	.align	2
	.word	-1
str_const11:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const1
	.ascii	"-"
	.byte	0	
	.align	2
	.word	-1
str_const10:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const0
	.byte	0	
	.align	2
	.word	-1
str_const9:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const1
	.ascii	"9"
	.byte	0	
	.align	2
	.word	-1
str_const8:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const1
	.ascii	"8"
	.byte	0	
	.align	2
	.word	-1
str_const7:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const1
	.ascii	"7"
	.byte	0	
	.align	2
	.word	-1
str_const6:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const1
	.ascii	"6"
	.byte	0	
	.align	2
	.word	-1
str_const5:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const1
	.ascii	"5"
	.byte	0	
	.align	2
	.word	-1
str_const4:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const1
	.ascii	"4"
	.byte	0	
	.align	2
	.word	-1
str_const3:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const1
	.ascii	"3"
	.byte	0	
	.align	2
	.word	-1
str_const2:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const1
	.ascii	"2"
	.byte	0	
	.align	2
	.word	-1
str_const1:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const1
	.ascii	"1"
	.byte	0	
	.align	2
	.word	-1
str_const0:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const1
	.ascii	"0"
	.byte	0	
	.align	2
	.word	-1
int_const12:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	19
	.word	-1
int_const11:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	13
	.word	-1
int_const10:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	10
	.word	-1
int_const9:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	9
	.word	-1
int_const8:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	8
	.word	-1
int_const7:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	7
	.word	-1
int_const6:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	6
	.word	-1
int_const5:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	5
	.word	-1
int_const4:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	4
	.word	-1
int_const3:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	3
	.word	-1
int_const2:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	2
	.word	-1
int_const1:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	1
	.word	-1
int_const0:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	0
	.word	-1
bool_const0:
	.word	3
	.word	4
	.word	Bool_dispTab
	.word	0
	.word	-1
bool_const1:
	.word	3
	.word	4
	.word	Bool_dispTab
	.word	1
class_nameTab:
	.word	str_const16
	.word	str_const17
	.word	str_const18
	.word	str_const19
	.word	str_const20
	.word	str_const21
	.word	str_const22
class_objTab:
	.word	Object_protObj
	.word	Object_init
	.word	IO_protObj
	.word	IO_init
	.word	Int_protObj
	.word	Int_init
	.word	Bool_protObj
	.word	Bool_init
	.word	String_protObj
	.word	String_init
	.word	A2I_protObj
	.word	A2I_init
	.word	Main_protObj
	.word	Main_init
Object_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
Main_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	Main.main
A2I_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	A2I.c2i
	.word	A2I.i2c
	.word	A2I.a2i
	.word	A2I.a2i_aux
	.word	A2I.i2a
	.word	A2I.i2a_aux
String_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	String.length
	.word	String.concat
	.word	String.substr
Bool_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
Int_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
IO_dispTab:
	.word	Object.abort
	.word	Object.type_name
	.word	Object.copy
	.word	IO.out_string
	.word	IO.out_int
	.word	IO.in_string
	.word	IO.in_int
	.word	-1
Object_protObj:
	.word	0
	.word	3
	.word	Object_dispTab
	.word	-1
Main_protObj:
	.word	6
	.word	3
	.word	Main_dispTab
	.word	-1
A2I_protObj:
	.word	5
	.word	3
	.word	A2I_dispTab
	.word	-1
String_protObj:
	.word	4
	.word	5
	.word	String_dispTab
	.word	int_const0
	.word	0
	.word	-1
Bool_protObj:
	.word	3
	.word	4
	.word	Bool_dispTab
	.word	0
	.word	-1
Int_protObj:
	.word	2
	.word	4
	.word	Int_dispTab
	.word	0
	.word	-1
IO_protObj:
	.word	1
	.word	3
	.word	IO_dispTab
	.globl	heap_start
heap_start:
	.word	0
	.text
	.globl	Main_init
	.globl	Int_init
	.globl	String_init
	.globl	Bool_init
	.globl	Main.main
Object_init:
	addiu	$sp $sp -12
	sw	$fp 12($sp)
	sw	$s0 8($sp)
	sw	$ra 4($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	move	$a0 $s0
	lw	$fp 12($sp)
	lw	$s0 8($sp)
	lw	$ra 4($sp)
	addiu	$sp $sp 12
	jr	$ra	
Main_init:
	addiu	$sp $sp -12
	sw	$fp 12($sp)
	sw	$s0 8($sp)
	sw	$ra 4($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Object_init
	move	$a0 $s0
	lw	$fp 12($sp)
	lw	$s0 8($sp)
	lw	$ra 4($sp)
	addiu	$sp $sp 12
	jr	$ra	
A2I_init:
	addiu	$sp $sp -12
	sw	$fp 12($sp)
	sw	$s0 8($sp)
	sw	$ra 4($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Object_init
	move	$a0 $s0
	lw	$fp 12($sp)
	lw	$s0 8($sp)
	lw	$ra 4($sp)
	addiu	$sp $sp 12
	jr	$ra	
String_init:
	addiu	$sp $sp -12
	sw	$fp 12($sp)
	sw	$s0 8($sp)
	sw	$ra 4($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Object_init
	move	$a0 $s0
	lw	$fp 12($sp)
	lw	$s0 8($sp)
	lw	$ra 4($sp)
	addiu	$sp $sp 12
	jr	$ra	
Bool_init:
	addiu	$sp $sp -12
	sw	$fp 12($sp)
	sw	$s0 8($sp)
	sw	$ra 4($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Object_init
	move	$a0 $s0
	lw	$fp 12($sp)
	lw	$s0 8($sp)
	lw	$ra 4($sp)
	addiu	$sp $sp 12
	jr	$ra	
Int_init:
	addiu	$sp $sp -12
	sw	$fp 12($sp)
	sw	$s0 8($sp)
	sw	$ra 4($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Object_init
	move	$a0 $s0
	lw	$fp 12($sp)
	lw	$s0 8($sp)
	lw	$ra 4($sp)
	addiu	$sp $sp 12
	jr	$ra	
IO_init:
	addiu	$sp $sp -12
	sw	$fp 12($sp)
	sw	$s0 8($sp)
	sw	$ra 4($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	jal	Object_init
	move	$a0 $s0
	lw	$fp 12($sp)
	lw	$s0 8($sp)
	lw	$ra 4($sp)
	addiu	$sp $sp 12
	jr	$ra	
Main.main:
	addiu	$sp $sp -16
	sw	$fp 16($sp)
	sw	$s0 12($sp)
	sw	$ra 8($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	la	$a0 IO_protObj
	jal	Object.copy
	jal	IO_init
	bne	$a0 $zero label0
	la	$a0 str_const14
	li	$t1 1
	jal	_dispatch_abort
label0:
	lw	$t1 8($a0)
	lw	$t1 20($t1)
	jalr		$t1
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 A2I_protObj
	jal	Object.copy
	jal	A2I_init
	bne	$a0 $zero label1
	la	$a0 str_const14
	li	$t1 1
	jal	_dispatch_abort
label1:
	lw	$t1 8($a0)
	lw	$t1 20($t1)
	jalr		$t1
	move	$s1 $a0
	la	$a0 int_const1
	jal	Object.copy
	lw	$t2 12($a0)
	lw	$t1 12($s1)
	add	$t1 $t1 $t2
	sw	$t1 12($a0)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 A2I_protObj
	jal	Object.copy
	jal	A2I_init
	bne	$a0 $zero label2
	la	$a0 str_const14
	li	$t1 1
	jal	_dispatch_abort
label2:
	lw	$t1 8($a0)
	lw	$t1 28($t1)
	jalr		$t1
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 IO_protObj
	jal	Object.copy
	jal	IO_init
	bne	$a0 $zero label3
	la	$a0 str_const14
	li	$t1 1
	jal	_dispatch_abort
label3:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
	lw	$fp 16($sp)
	lw	$s0 12($sp)
	lw	$ra 8($sp)
	addiu	$sp $sp 16
	jr	$ra	
A2I.c2i:
	addiu	$sp $sp -16
	sw	$fp 16($sp)
	sw	$s0 12($sp)
	sw	$ra 8($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	lw	$s1 16($fp)
	la	$t2 str_const0
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label6
	la	$a1 bool_const0
	jal	equality_test
label6:
	lw	$t1 12($a0)
	beqz	$t1 label4
	la	$a0 int_const0
	b	label5
label4:
	lw	$s1 16($fp)
	la	$t2 str_const1
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label9
	la	$a1 bool_const0
	jal	equality_test
label9:
	lw	$t1 12($a0)
	beqz	$t1 label7
	la	$a0 int_const1
	b	label8
label7:
	lw	$s1 16($fp)
	la	$t2 str_const2
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label12
	la	$a1 bool_const0
	jal	equality_test
label12:
	lw	$t1 12($a0)
	beqz	$t1 label10
	la	$a0 int_const2
	b	label11
label10:
	lw	$s1 16($fp)
	la	$t2 str_const3
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label15
	la	$a1 bool_const0
	jal	equality_test
label15:
	lw	$t1 12($a0)
	beqz	$t1 label13
	la	$a0 int_const3
	b	label14
label13:
	lw	$s1 16($fp)
	la	$t2 str_const4
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label18
	la	$a1 bool_const0
	jal	equality_test
label18:
	lw	$t1 12($a0)
	beqz	$t1 label16
	la	$a0 int_const4
	b	label17
label16:
	lw	$s1 16($fp)
	la	$t2 str_const5
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label21
	la	$a1 bool_const0
	jal	equality_test
label21:
	lw	$t1 12($a0)
	beqz	$t1 label19
	la	$a0 int_const5
	b	label20
label19:
	lw	$s1 16($fp)
	la	$t2 str_const6
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label24
	la	$a1 bool_const0
	jal	equality_test
label24:
	lw	$t1 12($a0)
	beqz	$t1 label22
	la	$a0 int_const6
	b	label23
label22:
	lw	$s1 16($fp)
	la	$t2 str_const7
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label27
	la	$a1 bool_const0
	jal	equality_test
label27:
	lw	$t1 12($a0)
	beqz	$t1 label25
	la	$a0 int_const7
	b	label26
label25:
	lw	$s1 16($fp)
	la	$t2 str_const8
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label30
	la	$a1 bool_const0
	jal	equality_test
label30:
	lw	$t1 12($a0)
	beqz	$t1 label28
	la	$a0 int_const8
	b	label29
label28:
	lw	$s1 16($fp)
	la	$t2 str_const9
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label33
	la	$a1 bool_const0
	jal	equality_test
label33:
	lw	$t1 12($a0)
	beqz	$t1 label31
	la	$a0 int_const9
	b	label32
label31:
	move	$a0 $s0
	bne	$a0 $zero label34
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label34:
	lw	$t1 8($a0)
	lw	$t1 0($t1)
	jalr		$t1
	la	$a0 int_const0
label32:
label29:
label26:
label23:
label20:
label17:
label14:
label11:
label8:
label5:
	lw	$fp 16($sp)
	lw	$s0 12($sp)
	lw	$ra 8($sp)
	addiu	$sp $sp 20
	jr	$ra	
A2I.i2c:
	addiu	$sp $sp -16
	sw	$fp 16($sp)
	sw	$s0 12($sp)
	sw	$ra 8($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	lw	$s1 16($fp)
	la	$t2 int_const0
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label37
	la	$a1 bool_const0
	jal	equality_test
label37:
	lw	$t1 12($a0)
	beqz	$t1 label35
	la	$a0 str_const0
	b	label36
label35:
	lw	$s1 16($fp)
	la	$t2 int_const1
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label40
	la	$a1 bool_const0
	jal	equality_test
label40:
	lw	$t1 12($a0)
	beqz	$t1 label38
	la	$a0 str_const1
	b	label39
label38:
	lw	$s1 16($fp)
	la	$t2 int_const2
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label43
	la	$a1 bool_const0
	jal	equality_test
label43:
	lw	$t1 12($a0)
	beqz	$t1 label41
	la	$a0 str_const2
	b	label42
label41:
	lw	$s1 16($fp)
	la	$t2 int_const3
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label46
	la	$a1 bool_const0
	jal	equality_test
label46:
	lw	$t1 12($a0)
	beqz	$t1 label44
	la	$a0 str_const3
	b	label45
label44:
	lw	$s1 16($fp)
	la	$t2 int_const4
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label49
	la	$a1 bool_const0
	jal	equality_test
label49:
	lw	$t1 12($a0)
	beqz	$t1 label47
	la	$a0 str_const4
	b	label48
label47:
	lw	$s1 16($fp)
	la	$t2 int_const5
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label52
	la	$a1 bool_const0
	jal	equality_test
label52:
	lw	$t1 12($a0)
	beqz	$t1 label50
	la	$a0 str_const5
	b	label51
label50:
	lw	$s1 16($fp)
	la	$t2 int_const6
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label55
	la	$a1 bool_const0
	jal	equality_test
label55:
	lw	$t1 12($a0)
	beqz	$t1 label53
	la	$a0 str_const6
	b	label54
label53:
	lw	$s1 16($fp)
	la	$t2 int_const7
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label58
	la	$a1 bool_const0
	jal	equality_test
label58:
	lw	$t1 12($a0)
	beqz	$t1 label56
	la	$a0 str_const7
	b	label57
label56:
	lw	$s1 16($fp)
	la	$t2 int_const8
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label61
	la	$a1 bool_const0
	jal	equality_test
label61:
	lw	$t1 12($a0)
	beqz	$t1 label59
	la	$a0 str_const8
	b	label60
label59:
	lw	$s1 16($fp)
	la	$t2 int_const9
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label64
	la	$a1 bool_const0
	jal	equality_test
label64:
	lw	$t1 12($a0)
	beqz	$t1 label62
	la	$a0 str_const9
	b	label63
label62:
	move	$a0 $s0
	bne	$a0 $zero label65
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label65:
	lw	$t1 8($a0)
	lw	$t1 0($t1)
	jalr		$t1
	la	$a0 str_const10
label63:
label60:
label57:
label54:
label51:
label48:
label45:
label42:
label39:
label36:
	lw	$fp 16($sp)
	lw	$s0 12($sp)
	lw	$ra 8($sp)
	addiu	$sp $sp 20
	jr	$ra	
A2I.a2i:
	addiu	$sp $sp -16
	sw	$fp 16($sp)
	sw	$s0 12($sp)
	sw	$ra 8($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	lw	$a0 16($fp)
	bne	$a0 $zero label69
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label69:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
	move	$s1 $a0
	la	$t2 int_const0
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label68
	la	$a1 bool_const0
	jal	equality_test
label68:
	lw	$t1 12($a0)
	beqz	$t1 label66
	la	$a0 int_const0
	b	label67
label66:
	la	$a0 int_const0
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 int_const1
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$a0 16($fp)
	bne	$a0 $zero label73
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label73:
	lw	$t1 8($a0)
	lw	$t1 20($t1)
	jalr		$t1
	move	$s1 $a0
	la	$t2 str_const11
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label72
	la	$a1 bool_const0
	jal	equality_test
label72:
	lw	$t1 12($a0)
	beqz	$t1 label70
	la	$a0 int_const1
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$a0 16($fp)
	bne	$a0 $zero label74
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label74:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
	move	$s1 $a0
	la	$a0 int_const1
	jal	Object.copy
	lw	$t2 12($a0)
	lw	$t1 12($s1)
	sub	$t1 $t1 $t2
	sw	$t1 12($a0)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$a0 16($fp)
	bne	$a0 $zero label75
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label75:
	lw	$t1 8($a0)
	lw	$t1 20($t1)
	jalr		$t1
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	move	$a0 $s0
	bne	$a0 $zero label76
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label76:
	lw	$t1 8($a0)
	lw	$t1 24($t1)
	jalr		$t1
	jal	Object.copy
	lw	$t1 12($a0)
	neg	$t1 $t1
	sw	$t1 12($a0)
	b	label71
label70:
	la	$a0 int_const0
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 int_const1
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$a0 16($fp)
	bne	$a0 $zero label80
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label80:
	lw	$t1 8($a0)
	lw	$t1 20($t1)
	jalr		$t1
	move	$s1 $a0
	la	$t2 str_const12
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label79
	la	$a1 bool_const0
	jal	equality_test
label79:
	lw	$t1 12($a0)
	beqz	$t1 label77
	la	$a0 int_const1
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$a0 16($fp)
	bne	$a0 $zero label81
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label81:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
	move	$s1 $a0
	la	$a0 int_const1
	jal	Object.copy
	lw	$t2 12($a0)
	lw	$t1 12($s1)
	sub	$t1 $t1 $t2
	sw	$t1 12($a0)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$a0 16($fp)
	bne	$a0 $zero label82
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label82:
	lw	$t1 8($a0)
	lw	$t1 20($t1)
	jalr		$t1
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	move	$a0 $s0
	bne	$a0 $zero label83
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label83:
	lw	$t1 8($a0)
	lw	$t1 24($t1)
	jalr		$t1
	b	label78
label77:
	lw	$a0 16($fp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	move	$a0 $s0
	bne	$a0 $zero label84
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label84:
	lw	$t1 8($a0)
	lw	$t1 24($t1)
	jalr		$t1
label78:
label71:
label67:
	lw	$fp 16($sp)
	lw	$s0 12($sp)
	lw	$ra 8($sp)
	addiu	$sp $sp 20
	jr	$ra	
A2I.a2i_aux:
	addiu	$sp $sp -28
	sw	$fp 28($sp)
	sw	$s0 24($sp)
	sw	$ra 20($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	la	$s1 int_const0
	lw	$a0 28($fp)
	sw	$s1 0($fp)
	bne	$a0 $zero label85
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label85:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
	lw	$s1 0($fp)
	move	$s2 $a0
	la	$s3 int_const0
label86:
	move	$s4 $s3
	lw	$t1 12($s4)
	lw	$t2 12($s2)
	la	$a0 bool_const1
	blt	$t1 $t2 label88
	la	$a0 bool_const0
label88:
	lw	$t1 12($a0)
	beq	$t1 $zero label87
	move	$s4 $s1
	la	$a0 int_const10
	jal	Object.copy
	lw	$t2 12($a0)
	lw	$t1 12($s4)
	mul	$t1 $t1 $t2
	sw	$t1 12($a0)
	move	$s4 $a0
	sw	$s3 0($sp)
	addiu	$sp $sp -4
	la	$a0 int_const1
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	lw	$a0 28($fp)
	sw	$s1 0($fp)
	sw	$s2 4($fp)
	sw	$s3 8($fp)
	sw	$s4 12($fp)
	bne	$a0 $zero label89
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label89:
	lw	$t1 8($a0)
	lw	$t1 20($t1)
	jalr		$t1
	lw	$s1 0($fp)
	lw	$s2 4($fp)
	lw	$s3 8($fp)
	lw	$s4 12($fp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	move	$a0 $s0
	sw	$s1 0($fp)
	sw	$s2 4($fp)
	sw	$s3 8($fp)
	sw	$s4 12($fp)
	bne	$a0 $zero label90
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label90:
	lw	$t1 8($a0)
	lw	$t1 12($t1)
	jalr		$t1
	lw	$s1 0($fp)
	lw	$s2 4($fp)
	lw	$s3 8($fp)
	lw	$s4 12($fp)
	jal	Object.copy
	lw	$t2 12($a0)
	lw	$t1 12($s4)
	add	$t1 $t1 $t2
	sw	$t1 12($a0)
	move	$s1 $a0
	move	$s4 $s3
	la	$a0 int_const1
	jal	Object.copy
	lw	$t2 12($a0)
	lw	$t1 12($s4)
	add	$t1 $t1 $t2
	sw	$t1 12($a0)
	move	$s3 $a0
	b	label86
label87:
	move	$a0 $zero
	move	$a0 $s1
	lw	$fp 28($sp)
	lw	$s0 24($sp)
	lw	$ra 20($sp)
	addiu	$sp $sp 32
	jr	$ra	
A2I.i2a:
	addiu	$sp $sp -16
	sw	$fp 16($sp)
	sw	$s0 12($sp)
	sw	$ra 8($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	lw	$s1 16($fp)
	la	$t2 int_const0
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label93
	la	$a1 bool_const0
	jal	equality_test
label93:
	lw	$t1 12($a0)
	beqz	$t1 label91
	la	$a0 str_const0
	b	label92
label91:
	la	$s1 int_const0
	lw	$a0 16($fp)
	lw	$t1 12($s1)
	lw	$t2 12($a0)
	la	$a0 bool_const1
	blt	$t1 $t2 label96
	la	$a0 bool_const0
label96:
	lw	$t1 12($a0)
	beqz	$t1 label94
	lw	$a0 16($fp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	move	$a0 $s0
	bne	$a0 $zero label97
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label97:
	lw	$t1 8($a0)
	lw	$t1 32($t1)
	jalr		$t1
	b	label95
label94:
	lw	$s1 16($fp)
	la	$a0 int_const1
	jal	Object.copy
	lw	$t1 12($a0)
	neg	$t1 $t1
	sw	$t1 12($a0)
	jal	Object.copy
	lw	$t2 12($a0)
	lw	$t1 12($s1)
	mul	$t1 $t1 $t2
	sw	$t1 12($a0)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	move	$a0 $s0
	bne	$a0 $zero label98
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label98:
	lw	$t1 8($a0)
	lw	$t1 32($t1)
	jalr		$t1
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	la	$a0 str_const11
	bne	$a0 $zero label99
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label99:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
label95:
label92:
	lw	$fp 16($sp)
	lw	$s0 12($sp)
	lw	$ra 8($sp)
	addiu	$sp $sp 20
	jr	$ra	
A2I.i2a_aux:
	addiu	$sp $sp -24
	sw	$fp 24($sp)
	sw	$s0 20($sp)
	sw	$ra 16($sp)
	addiu	$fp $sp 4
	move	$s0 $a0
	lw	$s1 24($fp)
	la	$t2 int_const0
	move	$t1 $s1
	la	$a0 bool_const1
	beq	$t1 $t2 label102
	la	$a1 bool_const0
	jal	equality_test
label102:
	lw	$t1 12($a0)
	beqz	$t1 label100
	la	$a0 str_const10
	b	label101
label100:
	lw	$s1 24($fp)
	la	$a0 int_const10
	jal	Object.copy
	lw	$t2 12($a0)
	lw	$t1 12($s1)
	div	$t1 $t1 $t2
	sw	$t1 12($a0)
	move	$s1 $a0
	lw	$s2 24($fp)
	move	$s3 $s1
	la	$a0 int_const10
	jal	Object.copy
	lw	$t2 12($a0)
	lw	$t1 12($s3)
	mul	$t1 $t1 $t2
	sw	$t1 12($a0)
	jal	Object.copy
	lw	$t2 12($a0)
	lw	$t1 12($s2)
	sub	$t1 $t1 $t2
	sw	$t1 12($a0)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	move	$a0 $s0
	sw	$s1 0($fp)
	bne	$a0 $zero label103
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label103:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
	lw	$s1 0($fp)
	sw	$a0 0($sp)
	addiu	$sp $sp -4
	sw	$s1 0($sp)
	addiu	$sp $sp -4
	move	$a0 $s0
	sw	$s1 0($fp)
	bne	$a0 $zero label104
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label104:
	lw	$t1 8($a0)
	lw	$t1 32($t1)
	jalr		$t1
	lw	$s1 0($fp)
	sw	$s1 0($fp)
	bne	$a0 $zero label105
	la	$a0 str_const13
	li	$t1 1
	jal	_dispatch_abort
label105:
	lw	$t1 8($a0)
	lw	$t1 16($t1)
	jalr		$t1
	lw	$s1 0($fp)
label101:
	lw	$fp 24($sp)
	lw	$s0 20($sp)
	lw	$ra 16($sp)
	addiu	$sp $sp 28
	jr	$ra	
