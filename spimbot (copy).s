# syscall constants
PRINT_STRING = 4
PRINT_CHAR   = 11
PRINT_INT    = 1

# debug constants
PRINT_INT_ADDR   = 0xffff0080
PRINT_FLOAT_ADDR = 0xffff0084
PRINT_HEX_ADDR   = 0xffff0088

# spimbot memory-mapped I/O
VELOCITY       = 0xffff0010
ANGLE          = 0xffff0014
ANGLE_CONTROL  = 0xffff0018
BOT_X          = 0xffff0020
BOT_Y          = 0xffff0024
OTHER_BOT_X    = 0xffff00a0
OTHER_BOT_Y    = 0xffff00a4
TIMER          = 0xffff001c
SCORES_REQUEST = 0xffff1018

REQUEST_JETSTREAM	= 0xffff00dc
REQUEST_RADAR		= 0xffff00e0
BANANA			= 0xffff0040
MUSHROOM		= 0xffff0044
STARCOIN		= 0xffff0048

REQUEST_PUZZLE		= 0xffff00d0
SUBMIT_SOLUTION		= 0xffff00d4

# interrupt constants
BONK_MASK	= 0x1000
BONK_ACK	= 0xffff0060

TIMER_MASK	= 0x8000
TIMER_ACK	= 0xffff006c

REQUEST_RADAR_INT_MASK	= 0x4000
REQUEST_RADAR_ACK	= 0xffff00e4

REQUEST_PUZZLE_ACK	= 0xffff00d8
REQUEST_PUZZLE_INT_MASK	= 0x800


.data
# put your data things here

.align 2
event_horizon_data: .space 90000

.align 2
coin_data: .space 9000

.align 2
puzzle_data: .space 512
plaintext: .space 512
sol: .space 512
.text

main:

    # enable interrupts

	or	$t4, $t4, BONK_MASK	                  # bonk interrupt bit
    or  $t4, $t4, REQUEST_RADAR_INT_MASK
    or 	$t4, $t4, REQUEST_PUZZLE_INT_MASK
	or	$t4, $t4, 1		# global interrupt enable
	mtc0	$t4, $12		# set interrupt mask (Status register)


	# user code

    la $s6 , event_horizon_data
    sw $s6 , REQUEST_JETSTREAM

    la $s7 , coin_data
    sw $s7 , REQUEST_RADAR

    # request puzzle
	la $t6, puzzle_data
	sw $t6, REQUEST_PUZZLE

    lw $s1 , BOT_X              #s1 : x
    lw $s2 , BOT_Y              #s2 : y
    li $t1 , 10
    sw $t1 , VELOCITY

compare:

    lw  $s1 , BOT_X              #s1 : x
    lw  $s2 , BOT_Y              #s2 : y

    mul $t2 , $s2 , 300
    add $t2 , $t2 , $s1
    add $t2 , $t2 , $s6
    lb  $s4 , 0($t2)

    sge $t1 , $s1 , 150
    sge $t2 , $s2 , 150

    seq $t4 , $s2 , 146
    slt $t5 , $s1 , 150
    and $t4 , $t4 , $t5

    li  $t5 , 0
    beq $t4 , 1   , help

    li  $t4 , 1
    and $t3 , $t1 , $t2
    beq $t3 , $t4 , rl

    li  $t4 , 0
    or  $t3 , $t1 , $t2
    beq $t3 , $t4 , l_u

    beq $t1 , $t4 , l_l

    j   ru

help:

    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
    li  $t1 , 180
    sw  $t1 , ANGLE

    add $t5 , $t5 , 1
    bge $t5 , 3   , compare

    j   end_help

end_help:

    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
    li  $t1 , 270
    sw  $t1 , ANGLE

    j   compare


ru:


    add $s2 , $s2 , 2
    mul $t2 , $s2 , 300
    add $t2 , $t2 , $s1
    add $t2 , $t2 , $s6
    lb  $t2 , 0($t2)
    li  $t4 , 1
    beq $t2 , $t4 , ru_while

    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
    li  $t1 , 90
    sw  $t1 , ANGLE

    j   compare

ru_while:

    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
    li  $t1 , 0
    sw  $t1 , ANGLE
    lw  $s1 , BOT_X              #s1 : x
    lw  $s2 , BOT_Y              #s2 : y
    j   compare

rl:


    lw  $s1 , BOT_X              #s1 : x
    lw  $s2 , BOT_Y              #s2 : y
    sub $s1 , $s1 , 2
    mul $t2 , $s2 , 300
    add $t2 , $t2 , $s1
    add $t2 , $t2 , $s6
    lb  $t2 , 0($t2)
    li  $t4 , 1
    beq $t2 , $t4 , rl_while

    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
    li  $t1 , 180
    sw  $t1 , ANGLE

    j   compare

rl_while:

    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
    li  $t1 , 90
    sw  $t1 , ANGLE
    lw  $s1 , BOT_X              #s1 : x
    lw  $s2 , BOT_Y              #s2 : y

    j   compare


l_l:


    lw  $s1 , BOT_X              #s1 : x
    lw  $s2 , BOT_Y              #s2 : y
    sub $s2 , $s2 , 2
    mul $t2 , $s2 , 300
    add $t2 , $t2 , $s1
    add $t2 , $t2 , $s6
    lb  $t2 , 0($t2)
    li  $t4 , 1
    beq $t2 , $t4 , ll_while

    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
    li  $t1 , 270
    sw  $t1 , ANGLE

    j   compare

ll_while:

    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
    li  $t1 , 180
    sw  $t1 , ANGLE
    lw  $s1 , BOT_X              #s1 : x
    lw  $s2 , BOT_Y              #s2 : y

    j compare

l_u:

    lw  $s1 , BOT_X              #s1 : x
    lw  $s2 , BOT_Y              #s2 : y
    add $s1 , $s1 , 2
    mul $t2 , $s2 , 300
    add $t2 , $t2 , $s1
    add $t2 , $t2 , $s6

    lb  $s5 , 0($t2)
    li  $t4 , 1
    beq $s5 , $t4 , lu_while

    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
    li  $t1 , 0
    sw  $t1 , ANGLE


    j compare


lu_while:

    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
    li  $t1 , 280
    sw  $t1 , ANGLE
    lw  $s1 , BOT_X              #s1 : x
    lw  $s2 , BOT_Y              #s2 : y

    j   compare



	# note that we infinite loop to avoid stopping the simulation early
	j	main

#--------------------------------------------------------------------------------

.kdata				# interrupt handler data (separated just for readability)
chunkIH:	.space 8	# space for two registers
non_intrpt_str:	.asciiz "Non-interrupt exception\n"
unhandled_str:	.asciiz "Unhandled interrupt type\n"


.ktext 0x80000180
interrupt_handler:
.set noat
	move	$k1, $at		# Save $at
.set at
	la	$k0, chunkIH
	sw	$a0, 0($k0)		# Get some free registers
	sw	$a1, 4($k0)		# by storing them to a global variable

	mfc0	$k0, $13		# Get Cause register
	srl	$a0, $k0, 2
	and	$a0, $a0, 0xf		# ExcCode field
	bne	$a0, 0, non_intrpt

interrupt_dispatch:			# Interrupt:
	mfc0	$k0, $13		# Get Cause register, again
	beq	$k0, 0, done		# handled all outstanding interrupts

	and	$a0, $k0, BONK_MASK	# is there a bonk interrupt?
	bne	$a0, 0, bonk_interrupt

	and	$a0, $k0, TIMER_MASK	# is there a timer interrupt?
	bne	$a0, 0, timer_interrupt




    # add dispatch for other interrupt types here.

    and $a0, $k0, REQUEST_RADAR_INT_MASK
    bne $a0, 0, star_coin_interrupt

    and $a0, $k0, REQUEST_PUZZLE_INT_MASK
    bne $a0, 0, puzzle_interrupt

	li	$v0, PRINT_STRING	# Unhandled interrupt types
	la	$a0, unhandled_str
	syscall
	j	done

bonk_interrupt:
      sw      $a1, 0xffff0060($zero)   # acknowledge interrupt

      li      $a1, 10                  #  ??
      lw      $a0, 0xffff001c($zero)   # what
      and     $a0, $a0, 1              # does
      bne     $a0, $zero, bonk_skip    # this
      li      $a1, -10                 # code
bonk_skip:                             #  do
      sw      $a1, 0xffff0010($zero)   #  ??

      j       interrupt_dispatch       # see if other interrupts are waiting

timer_interrupt:
	sw	$a1, TIMER_ACK		# acknowledge interrupt


	j	interrupt_dispatch	# see if other interrupts are waiting




#--------------------------------------------------------------------------

star_coin_interrupt:

    sub $sp, $sp, 32
    sw  $s0, 0($sp)
    sw  $s1, 4($sp)
    sw  $s2, 8($sp)
    sw  $s3, 12($sp)
    sw  $s4, 16($sp)
    sw  $s5, 20($sp)
    sw  $s6, 24($sp)
    sw  $s7, 28($sp)

    sw  $a1, REQUEST_RADAR_ACK

    la  $s0, coin_data
    lw  $s0, 0($s7)      # s0 : coin data

#     beq $s0, 0xffffffff , find_banana
#     srl $s1, $s0, 16         # s1 : target_x
#     sll $s0, $s0, 16
#     srl $s0, $s0, 16         # s0 : target_y
#
#     lw  $s2 , BOT_X              #s2 : x
#     lw  $s3 , BOT_Y              #s3 : y
#
#     bge $s3 , $s0 , go_up
#     j   go_down
#
# go_up:
#
#     lw  $s4 , BOT_X              #s2 : x
#     lw  $s5 , BOT_Y              #s3 : y
#     ble $s5 , $s0 , go_y
#
#     li  $t4 , 1
#     sw  $t4 , ANGLE_CONTROL
#     li  $t4 , 270
#     sw  $t4 , ANGLE
#     j   go_up
#
# go_down:
#
#     lw  $s4 , BOT_X              #s2 : x
#     lw  $s5 , BOT_Y              #s3 : y
#     bge $s5 , $s0 , go_y
#     li  $t4 , 1
#     sw  $t4 , ANGLE_CONTROL
#     li  $t4 , 90
#     sw  $t4 , ANGLE
#     j   go_down
#
# go_y:
#
#     ble $s4 , $s1 , go_right
#     j   go_left
#
# go_right:
#
#     lw  $s4 , BOT_X              #s2 : x
#     lw  $s5 , BOT_Y              #s3 : y
#     bge $s4 , $s1 , go_back
#     li  $t4 , 1
#     sw  $t4 , ANGLE_CONTROL
#     li  $t4 , 0
#     sw  $t4 , ANGLE
#     j   go_right
#
# go_left:
#
#     lw  $s4 , BOT_X              #s2 : x
#     lw  $s5 , BOT_Y              #s3 : y
#     ble $s4 , $s1 , go_back
#     li  $t4 , 1
#     sw  $t4 , ANGLE_CONTROL
#     li  $t4 , 180
#     sw  $t4 , ANGLE
#     j   go_left
#
# go_back:
#
#     move $s6 , $s0
#     move $s0 , $s3
#     move $s3 , $s6
#     move $s6 , $s1
#     move $s1 , $s2
#     move $s2 , $s6
#
#  bge $s3 , $s0 , bgo_up
#     j   bgo_down
#
# bgo_up:
#
#     lw  $s4 , BOT_X              #s2 : x
#     lw  $s5 , BOT_Y              #s3 : y
#     ble $s5 , $s0 , bgo_y
#
#     li  $t4 , 1
#     sw  $t4 , ANGLE_CONTROL
#     li  $t4 , 270
#     sw  $t4 , ANGLE
#     j   bgo_up
#
# bgo_down:
#
#     lw  $s4 , BOT_X              #s2 : x
#     lw  $s5 , BOT_Y              #s3 : y
#     bge $s5 , $s0 , bgo_y
#     li  $t4 , 1
#     sw  $t4 , ANGLE_CONTROL
#     li  $t4 , 90
#     sw  $t4 , ANGLE
#     j   bgo_down
#
# bgo_y:
#
#     ble $s4 , $s1 , bgo_right
#     j   bgo_left
#
# bgo_right:
#
#     lw  $s4 , BOT_X              #s2 : x
#     lw  $s5 , BOT_Y              #s3 : y
#     bge $s4 , $s1 , find_banana
#     li  $t4 , 1
#     sw  $t4 , ANGLE_CONTROL
#     li  $t4 , 0
#     sw  $t4 , ANGLE
#     j   bgo_right
#
# bgo_left:
#
#     lw  $s4 , BOT_X              #s2 : x
#     lw  $s5 , BOT_Y              #s3 : y
#     ble $s4 , $s1 , find_banana
#     li  $t4 , 1
#     sw  $t4 , ANGLE_CONTROL
#     li  $t4 , 180
#     sw  $t4 , ANGLE
#     j   bgo_left


find_banana:
	la 	$s3, coin_data
	lw  $s4, 0($s3)

banana_loop:
	beq $s4, 0xffffffff, read_banana
	add $s3, $s3, 4
	lw  $s4, 0($s3)
	j 	banana_loop

read_banana:
	add $s3, $s3, 4
	lw  $s4, 0($s3)
	beq	$s4, 0xffffffff, finish
	srl $s1, $s4, 16         # s1 : target_x
    sll $s4, $s4, 16
    srl $s0, $s4, 16         # s0 : target_y

finish:
    lw  $s0, 0($sp)
    lw  $s1, 4($sp)
    lw  $s2, 8($sp)
    lw  $s3, 12($sp)
    lw  $s4, 16($sp)
    lw  $s5, 20($sp)
    lw  $s6, 24($sp)
    lw  $s7, 28($sp)

    add $sp, $sp, 32


    j	interrupt_dispatch

#--------------------------------------------------------------------------
puzzle_interrupt:
	sw  $a1, REQUEST_PUZZLE_ACK

	# TODO: Solve the puzzle
	sub $sp, $sp, 16
	sw  $a0,	0($sp)
	sw	$a1,	4($sp)
	sw	$a2,	8($sp)
	sw	$a3,	12($sp)
#NEED TO DECRYPT FOUR TIMES
# decrypt(uint8_t *ciphertext, uint8_t *plaintext, uint8_t *key, uint8_t rounds)
	add $a0, $t6, 0	#encrypt first 16 char
	la 	$a1, plaintext	#output
	add	$s2, $t6, 64	#key
	lb	$a3, 208($t6)	#rounds
	jal	decrypt


	add $a0, $t6, 0	#encrypt second 16 char
	la 	$a1, plaintext	#output
	add	$a1, a1, 16
	add	$s2, $t6, 64	#key
	lb	$a3, 208($t6)	#rounds
	jal	decrypt

	add $a0, $t6, 32	#encrypt third 16 char
	la 	$a1, plaintext	#output
	add	$a1, a1, 32
	add	$s2, $t6, 64	#key
	lb	$a3, 208($t6)	#rounds
	jal	decrypt

	add $a0, $t6, 48	#encrypt third 16 char
	la 	$a1, plaintext	#output
	add	$a1, a1, 48
	add	$s2, $t6, 64	#key
	lb	$a3, 208($t6)	#rounds
	jal	decrypt


#max_unique_n_substr(char *in_str, char *out_str, int n)
	la	$a0, plaintext
	la	$a1, sol
	lb	$a2, 212($t6)	#unique_chars
	jal	max_unique_n_substr

	sw	$a1, SUBMIT_SOLUTION

	lw  $a0,	0($sp)
	lw	$a1,	4($sp)
	lw	$a2,	8($sp)
	lw	$a3,	12($sp)
	add	$sp, $sp, 16 
	j	interrupt_dispatch

#--------------------------------------------------------------------------

non_intrpt:				# was some non-interrupt
	li	$v0, PRINT_STRING
	la	$a0, non_intrpt_str
	syscall				# print out an error message
	# fall through to done

done:
    sw $s7 , REQUEST_RADAR

    la $t6, puzzle_data
    sw $t6, REQUEST_PUZZLE

	la	$k0, chunkIH
	lw	$a0, 0($k0)		# Restore saved registers
	lw	$a1, 4($k0)
.set noat
	move	$at, $k1		# Restore $at
.set at
	eret


#-----------------------------------------------------------------------------------
.globl max_unique_n_substr
max_unique_n_substr:
	beq	$a0, $0, muns_abort 		# !in_str
	beq	$a1, $0, muns_abort		# !out_str
	beq	$a2, $0, muns_abort		# !n
	j	muns_do

muns_abort:
	jr	$ra

muns_do:
	sub	$sp, $sp, 36
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)			# $s0 = char *in_str
	sw	$s1, 8($sp)			# $s1 = char *out_str
	sw	$s2, 12($sp)			# $s2 = int n
	sw	$s3, 16($sp)			# $s3 = char *max_marker
	sw	$s4, 20($sp)			# $s4 = unsigned int len_max
	sw	$s5, 24($sp)			# $s5 = unsigned int len_in_str
	sw	$s6, 28($sp)			# $s6 = unsigned int cur_pos
	sw	$s7, 32($sp)			# $s7 = int len_cur

	move	$s0, $a0
	move	$s1, $a1
	move	$s2, $a2

	move	$s3, $a0			# max_marker = in_str
	li	$s4, 0				# len_max = 0

	jal	my_strlen			# my_strlen(in_str)
	move	$s5, $v0			# len_in_str = my_strlen(in_str)

	li	$s6, 0				# cur_pos = 0
muns_for:
	bge	$s6, $s5, muns_for_end 		# if (cur_pos >= len_in_str), end

	add	$s7, $s0, $s6			# i = in_str + cur_pos

	move	$a0, $s7
	add	$a1, $s2, 1
	jal	nth_uniq_char			# nth_uniq_char(i, n + 1)

	ble	$v0, $s4, muns_for_cont		# if (len_cur <= len_max), continue
	move	$s4, $v0			# len_max = len_cur
	move	$s3, $s7			# max_marker = i

muns_for_cont:
	add	$s6, $s6, 1			# cur_pos++
	j	muns_for

muns_for_end:
	## Setup call to my_strncpy
	move	$a0, $s1
	move	$a1, $s3
	move	$a2, $s4

	lw      $ra, 0($sp)
	lw      $s0, 4($sp)
	lw      $s1, 8($sp)
	lw      $s2, 12($sp)
	lw      $s3, 16($sp)
	lw      $s4, 20($sp)
	lw      $s5, 24($sp)
	lw      $s6, 28($sp)
	lw      $s7, 32($sp)
	add	$sp, $sp, 36

	## Tail call
	j	my_strncpy			# my_strncpy(out_str, max_marker, len_max)


.globl my_strncpy
my_strncpy:
	sub	$sp, $sp, 16
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	sw	$s2, 8($sp)
	sw	$ra, 12($sp)
	move	$s0, $a0
	move	$s1, $a1
	move	$s2, $a2

	move	$a0, $a1
	jal	my_strlen
	add	$v0, $v0, 1
	bge	$s2, $v0, my_strncpy_if
	move	$v0, $s2
my_strncpy_if:
	li	$t0, 0
my_strncpy_for:
	bge	$t0, $v0, my_strncpy_end
	add	$t1, $s1, $t0
	lb	$t2, 0($t1)
	add	$t1, $s0, $t0
	sb	$t2, 0($t1)
	add	$t0, $t0, 1
	j	my_strncpy_for
my_strncpy_end:
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$ra, 12($sp)
	add	$sp, $sp, 16
	jr	$ra

.globl decrypt
decrypt:
    # Your code goes here :)
    #There is the stack mem and the saved reg 
    sub $sp, $sp, 100 
 	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	sw	$s3, 16($sp)
	sw	$s4, 20($sp)
	sw	$s5, 24($sp)
	sw	$s6, 28($sp)
	sw	$s7, 32($sp)


    #Args, except rounds
    move $s0, $a0
    move $s1, $a1
    move $s2, $a2
    #stored in s7
    move $s7, $a3

    #A,B,C D loc 
    add $s3, $sp, 36
    add $s4, $sp, 52
    add $s5, $sp, 68
    add $s6, $sp, 84
    
    move $a0, $s0
    mul $t0, $s7,16
    add $a1,$s2 ,$t0
    move $a2, $s5
    jal key_addition

    move $a0, $s5
    move $a1, $s4
    jal inv_shift_rows

    move $a0,$s4
    move $a1,$s3
    jal inv_byte_substitution

    #Rounds - 1
    sub $s7, $s7, 1
for_loop:
    ble $s7, 0,end_for_loop

    move $a0, $s3
    mul $t0, $s7,16
    add $a1, $s2,$t0
    move $a2, $s6
    jal key_addition

    move $a0, $s6
    move $a1, $s5
    jal inv_mix_column

    move $a0, $s5
    move $a1, $s4
    jal inv_shift_rows

    move $a0,$s4
    move $a1,$s3
    jal inv_byte_substitution

    sub $s7, $s7, 1
    j for_loop
end_for_loop:

    move $a0, $s3
    move $a1, $s2 
    move $a2, $s1
    jal key_addition    

 	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	lw	$s3, 16($sp)
	lw	$s4, 20($sp)
	lw	$s5, 24($sp)
	lw	$s6, 28($sp)
	lw	$s7, 32($sp)
    add $sp, $sp, 100 

    jr $ra

.globl key_addition
key_addition:
	li	$t0, 0
key_addition_for:
	bge	$t0, 16, key_addition_end
	add	$t1, $a0, $t0
	add	$t2, $a1, $t0
	lbu	$t1, 0($t1)
	lbu	$t2, 0($t2)
	xor	$t1, $t1, $t2
	add	$t2, $a2, $t0
	sb	$t1, 0($t2)
	add	$t0, $t0, 1
	j	key_addition_for
key_addition_end:
	jr	$ra


.globl inv_mix_column
inv_mix_column:
	sub	$sp, $sp, 16
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	sw	$s2, 8($sp)
	sw	$s3, 12($sp)

	move	$s0, $zero
for_first:
	bge	$s0, 4, for_first_done
	move	$s1, $zero
for_second:
	bge	$s1, 4, for_second_done    

	#store where out[4*k+i] is 
	mul	$t0, $s0, 4    
	add	$t0, $t0, $s1
	add	$s3, $a1, $t0
	sb	$zero, 0($s3)

	move	$s2, $zero
for_third:
	bge	$s2, 4, for_third_done
	mul	$t0, $s2, 256     
	add	$t1, $s1, $s2
	rem	$t1, $t1, 4
	mul	$t2, $s0, 4
	add	$t2, $t2, $t1
	add	$t2, $t2, $a0

	lbu	$t2, 0($t2)

	add	$t0, $t0, $t2
	la	$t4, inv_mix
	add	$t0, $t0, $t4
	lbu	$t0, 0($t0)    

	lb	$t5, 0($s3)
	xor	$t5, $t5, $t0
	sb	$t5, 0($s3)

	add	$s2, $s2, 1
	j	for_third
for_third_done:
	add	$s1, $s1, 1
	j	for_second
for_second_done:
	add	$s0, $s0, 1
	j	for_first
for_first_done:
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$s3, 12($sp)
	add	$sp, $sp, 16
	jr	$ra



.globl inv_shift_rows
inv_shift_rows:
	#7 saved registers, 20 for stack
	sub	$sp, $sp, 36
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	sw	$s3, 16($sp)

	#Assign M
	add	$s0, $sp, 20
	#Assign in
	move	$s1, $a0
	#assign out
	move	$s2, $a1

	move	$a0, $s1
	move	$a1, $s0
	jal	rearrange_matrix

	#Assign I
	move	$s3, $zero
for_loop:
	bge	$s3, 4, end_for

	li	$a1, 4
	sub	$a1, $a1, $s3

	mul	$t0, $s3, 4
	add	$t0, $s0, $t0

	lw	$a0, 0($t0)
	jal	circular_shift

	mul	$t0, $s3, 4
	add	$t0, $s0, $t0
	sw	$v0, 0($t0)

	add	$s3, $s3, 1
	j	for_loop
end_for:
	move	$a0, $s0
	move	$a1, $s2
	jal	rearrange_matrix

	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	lw	$s3, 16($sp)
	add	$sp, $sp, 36
	jr	$ra

.globl inv_byte_substitution
inv_byte_substitution:
	li	$t0, 0
	la	$t1, inv_sbox
inv_byte_substitution_for:
	bge	$t0, 16, inv_byte_substitution_end
	add	$t9, $a0, $t0
	lbu	$t9, 0($t9)
	add	$t9, $t1, $t9
	lbu	$t9, 0($t9)
	add	$t8, $a1, $t0
	sb	$t9, 0($t8)
	add	$t0, $t0, 1
	j	inv_byte_substitution_for
inv_byte_substitution_end:
	jr	$ra

