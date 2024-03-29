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

	li  $t1 , 180
	sw  $t1 , ANGLE
    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL

    add $t5 , $t5 , 1
    bge $t5 , 3   , compare

    j   end_help

end_help:

	li  $t1 , 270
	sw  $t1 , ANGLE
    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL

    j   compare


ru:
	lw  $s1 , BOT_X              #s1 : x
	lw  $s2 , BOT_Y              #s2 : y
    add $s2 , $s2 , 2
    mul $t2 , $s2 , 300
    add $t2 , $t2 , $s1
    add $t2 , $t2 , $s6
    lb  $t2 , 0($t2)
    li  $t4 , 1
    beq $t2 , $t4 , ru_while

	li  $t1 , 90
	sw  $t1 , ANGLE
    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL

    j   compare

ru_while:

	li  $t1 , 0
	sw  $t1 , ANGLE
    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
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

	li  $t1 , 180
	sw  $t1 , ANGLE
    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL

    j   compare

rl_while:

	li  $t1 , 90
	sw  $t1 , ANGLE
    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
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

	li  $t1 , 270
	sw  $t1 , ANGLE
    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL

    j   compare

ll_while:

	li  $t1 , 180
	sw  $t1 , ANGLE
    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
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

	li  $t1 , 0
	sw  $t1 , ANGLE
    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL


    j compare


lu_while:

	li  $t1 , 270
	sw  $t1 , ANGLE
    li  $t1 , 1
    sw  $t1 , ANGLE_CONTROL
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

    sub $sp, $sp, 64
    sw  $s0, 0($sp)
    sw  $s1, 4($sp)
    sw  $s2, 8($sp)
    sw  $s3, 12($sp)
    sw  $s4, 16($sp)
    sw  $s5, 20($sp)
    sw  $s6, 24($sp)
    sw  $s7, 28($sp)
	sw  $t0, 32($sp)
    sw  $t1, 36($sp)
    sw  $t2, 40($sp)
    sw  $t3, 44($sp)
    sw  $t4, 48($sp)
    sw  $t5, 52($sp)
    sw  $t6, 56($sp)
    sw  $t7, 60($sp)

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
	srl $t5, $s4, 16         # t5 : banana_x
    sll $s4, $s4, 16
    srl $t6, $s4, 16         # t6 : banana_y

compare_banana:

    lw  $s1 , BOT_X              #s1 : x
    lw  $s2 , BOT_Y              #s2 : y

	sub $t0, $t5, $s1
	sub $t1, $t6, $s2
	bge $t0, 0, see_y
	sub $t0, $0, $t0			# t0 = |delta x|

see_y:
	bge $t1, 0, abs_done
	sub $t1, $0, $t1			# t1 = |delta y|

abs_done:
	sge $t0, $t0, 5
	sge $t1, $t1, 5
	and $t0, $t0, $t1
	beq $t0, 1, finish

    mul $t2 , $s2 , 300
    add $t2 , $t2 , $s1
    add $t2 , $t2 , $s6
    lb  $s4 , 0($t2)

    sge $t1 , $s1 , 150
    sge $t2 , $s2 , 150

    li  $t4 , 1
    and $t3 , $t1 , $t2
    beq $t3 , $t4 , lower_right

    li  $t4 , 0
    or  $t3 , $t1 , $t2
    beq $t3 , $t4 , upper_left

    beq $t1 , $t4 , lower_left

    j   upper_right

upper_left:
	lw  $s1 , BOT_X
	add $s2, $s1, 2
	li  $t1 , 340
	sw  $t1 , ANGLE
	li  $t1 , 1
	sw  $t1 , ANGLE_CONTROL

loop_ul:
	lw  $s1 , BOT_X
	ble $s1, $s2, loop_ul

	li  $t1 , 270
	sw  $t1 , ANGLE
	li  $t1 , 1
	sw  $t1 , ANGLE_CONTROL
	j 	finish

upper_right:
	lw  $s1 , BOT_Y
	add $s2, $s1, 2
	li  $t1 , 70
	sw  $t1 , ANGLE
	li  $t1 , 1
	sw  $t1 , ANGLE_CONTROL

loop_ur:
	lw  $s1 , BOT_Y
	ble $s1, $s2, loop_ur

	li  $t1 , 0
	sw  $t1 , ANGLE
	li  $t1 , 1
	sw  $t1 , ANGLE_CONTROL
	j 	finish

lower_right:
	lw  $s1 , BOT_X
	sub $s2, $s1, 2

	li  $t1 , 160
	sw  $t1 , ANGLE
	li  $t1 , 1
	sw  $t1 , ANGLE_CONTROL

loop_lr:
	lw  $s1 , BOT_X
	bge $s1, $s2, loop_lr

	li  $t1 , 0
	sw  $t1 , ANGLE
	li  $t1 , 90
	sw  $t1 , ANGLE_CONTROL
	j 	finish

lower_left:
	lw  $s1 , BOT_Y
	sub $s2, $s1, 2

	li  $t1 , 250
	sw  $t1 , ANGLE
	li  $t1 , 1
	sw  $t1 , ANGLE_CONTROL

loop_ll:
	lw  $s1 , BOT_Y
	bge $s1, $s2, loop_ll

	li  $t1 , 180
	sw  $t1 , ANGLE
	li  $t1 , 1
	sw  $t1 , ANGLE_CONTROL

# lower_right:
# 	lw  $s1 , BOT_X              # s1 : x
# 	lw  $s2 , BOT_Y              # s2 : y
# 	lw 	$s3, ANGLE
# 	beq $s3, 180, lr_turn_left
#
# 	sub $t0, $t5, $s1			 # t0: banana_x - x
# 	slt $t1, $t0, 0
# 	sge $t2, $t0, -15
# 	and $t0, $t1, $t2
#
# 	beq $t0, 0,	finish
#
# 	li  $t1 , 90
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
#
# 	li  $t5, 0
# 	j 	loop_banana_lr_down
#
# lr_turn_left:
# 	# sub $t0, $t6, $s2			 # t0: banana_y - y
# 	# sgt $t1, $t0, 0
# 	# sle $t2, $t0, 15
# 	# and $t0, $t1, $t2
#
# 	beq $t0, 0,	finish
#
# 	li  $t1 , 180
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
#
# 	li  $t5, 0
# 	j 	loop_banana_lr_left
#
# upper_left:
# 	lw  $s1 , BOT_X              # s1 : x
# 	lw  $s2 , BOT_Y              # s2 : y
# 	lw 	$s3, ANGLE
# 	beq $t3, 270, ul_turn_right
#
# 	sub $t0, $t5, $s1			 # t0: banana_x - x
# 	sgt $t1, $t0, 0
# 	sle $t2, $t0, 15
# 	and $t0, $t1, $t2 			 # 0 < banana_x - x <= 15
#
# 	beq $t0, 0,	finish
#
# 	li  $t1 , 270
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
#
# 	li  $t5, 0
# 	j 	loop_banana_ul_up
#
# ul_turn_right:
# 	# sub $t0, $t6, $s2			 # t0: banana_y - y
# 	# slt $t1, $t0, 0
# 	# sge $t2, $t0, -15
# 	# and $t0, $t1, $t2 			 # -15 <= banana_y - y < 0
#
# 	beq $t0, 0,	finish
#
# 	li  $t1 , 0
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
#
# 	li  $t5, 0
# 	j 	loop_banana_ul_right
#
# lower_left:
# 	lw  $s1 , BOT_X              # s1 : x
# 	lw  $s2 , BOT_Y              # s2 : y
# 	lw 	$s3, ANGLE
# 	beq $s3, 180, ll_turn_up
#
# 	sub $t0, $t6, $s2			 # t0: banana_y - y
# 	slt $t1, $t0, 0
# 	sge $t2, $t0, -15
# 	and $t0, $t1, $t2
#
# 	beq $t0, 0,	finish
#
# 	li  $t1 , 180
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
#
#
# 	li  $t5, 0
# 	j 	loop_banana_ll_left
#
# ll_turn_up:
# 	# sub $t0, $t5, $s1			 # t0: banana_y - y
# 	# slt $t1, $t0, 0
# 	# sge $t2, $t0, -15
# 	# and $t0, $t1, $t2
#
# 	beq $t0, 0,	finish
#
# 	li  $t1 , 270
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
#
# 	li  $t5, 0
# 	j 	loop_banana_ll_up
#
# upper_right:
# 	lw  $s1 , BOT_X              # s1 : x
# 	lw  $s2 , BOT_Y              # s2 : y
# 	lw 	$s3, ANGLE
# 	beq $t3, 0, ur_turn_down
#
# 	sub $t0, $t6, $s2			 # t0: banana_y - y
# 	sgt $t1, $t0, 0
# 	sle $t2, $t0, 15
# 	and $t0, $t1, $t2
#
# 	beq $t0, 0,	finish
#
# 	li  $t1 , 0
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
#
#
# 	li  $t5, 0
# 	j 	loop_banana_ur_right
#
# ur_turn_down:
# 	# sub $t0, $t5, $s1			 # t0: banana_x - x
# 	# sgt $t1, $t0, 0
# 	# sle $t2, $t0, 15
# 	# and $t0, $t1, $t2 			 # 0 < banana_x - x <= 15
#
# 	beq $t0, 0,	finish
#
# 	li  $t1 , 270
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
#
# 	li  $t5, 0
# 	j 	loop_banana_ur_down
#
# loop_banana:
# 	bge $t5, 6000, finish
# 	add $t5, $t5, 1
# 	j 	loop_banana
#
# loop_banana_ul_up:
# 	lw  $s1 , BOT_X              # s1 : x
# 	lw  $s2 , BOT_Y              # s2 : y
# 	sub $s2 , $s2 , 2
#     mul $t2 , $s2 , 300
#     add $t2 , $t2 , $s1
#     add $t2 , $t2 , $s6
#
#     lb  $s5 , 0($t2)
#     li  $t4 , 2
#     beq $s5 , $t4 , loop_banana_ul_up
#
# 	li  $t1 , 0
# 	sw  $t1 , ANGLE
#     li  $t1 , 1
#     sw  $t1 , ANGLE_CONTROL
# 	j 	finish
#
# loop_banana_ul_right:
# 	lw  $s1 , BOT_X              # s1 : x
# 	lw  $s2 , BOT_Y              # s2 : y
# 	bge $s1, 150, loop_banana_ur_right
# 	add $s1 , $s1 , 2
#     mul $t2 , $s2 , 300
#     add $t2 , $t2 , $s1
#     add $t2 , $t2 , $s6
#
#     lb  $s5 , 0($t2)
#     li  $t4 , 2
#     beq $s5 , $t4 , loop_banana_ul_right
#
# 	li  $t1 , 270
# 	sw  $t1 , ANGLE
#     li  $t1 , 1
#     sw  $t1 , ANGLE_CONTROL
# 	j 	finish
#
# loop_banana_ur_right:
# 	lw  $s1 , BOT_X              #s1 : x
# 	lw  $s2 , BOT_Y              #s2 : y
# 	add $s1 , $s1 , 2
# 	mul $t2 , $s2 , 300
# 	add $t2 , $t2 , $s1
# 	add $t2 , $t2 , $s6
#
# 	lb  $t2 , 0($t2)
# 	li  $t4 , 2
# 	beq $t2 , $t4 , loop_banana_ur_right
#
# 	li  $t1 , 90
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
# 	j 	finish
#
# loop_banana_ur_down:
# 	lw  $s1 , BOT_X              #s1 : x
# 	lw  $s2 , BOT_Y              #s2 : y
# 	bge $s2, 150, loop_banana_lr_down
# 	add $s2 , $s2 , 2
# 	mul $t2 , $s2 , 300
# 	add $t2 , $t2 , $s1
# 	add $t2 , $t2 , $s6
#
# 	lb  $t2 , 0($t2)
# 	li  $t4 , 2
# 	beq $t2 , $t4 , loop_banana_ur_down
#
# 	li  $t1 , 0
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
# 	j 	finish
#
# loop_banana_lr_left:
# 	lw  $s1 , BOT_X              #s1 : x
# 	lw  $s2 , BOT_Y              #s2 : y
# 	ble $s1, 150, loop_banana_ll_left
# 	sub $s1 , $s1 , 2
# 	mul $t2 , $s2 , 300
# 	add $t2 , $t2 , $s1
# 	add $t2 , $t2 , $s6
#
# 	lb  $t2 , 0($t2)
# 	li  $t4 , 2
# 	beq $t2 , $t4 , loop_banana_lr_left
#
# 	li  $t1 , 90
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
# 	j 	finish
#
# loop_banana_lr_down:
# 	lw  $s1 , BOT_X              #s1 : x
# 	lw  $s2 , BOT_Y              #s2 : y
# 	add $s2 , $s2 , 2
# 	mul $t2 , $s2 , 300
# 	add $t2 , $t2 , $s1
# 	add $t2 , $t2 , $s6
#
# 	lb  $t2 , 0($t2)
# 	li  $t4 , 2
# 	beq $t2 , $t4 , loop_banana_lr_down
#
# 	li  $t1 , 180
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
# 	j 	finish
#
# loop_banana_ll_left:
# 	lw  $s1 , BOT_X              #s1 : x
# 	lw  $s2 , BOT_Y              #s2 : y
# 	sub $s1 , $s1 , 2
# 	mul $t2 , $s2 , 300
# 	add $t2 , $t2 , $s1
# 	add $t2 , $t2 , $s6
#
# 	lb  $t2 , 0($t2)
# 	li  $t4 , 2
# 	beq $t2 , $t4 , loop_banana_ll_left
#
# 	li  $t1 , 270
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
# 	j 	finish
#
# loop_banana_ll_up:
# 	lw  $s1 , BOT_X              #s1 : x
# 	lw  $s2 , BOT_Y              #s2 : y
# 	ble $s2, 150, loop_banana_ul_up
# 	sub $s2 , $s2 , 2
# 	mul $t2 , $s2 , 300
# 	add $t2 , $t2 , $s1
# 	add $t2 , $t2 , $s6
#
# 	lb  $t2 , 0($t2)
# 	li  $t4 , 2
# 	beq $t2 , $t4 , loop_banana_ll_up
#
# 	li  $t1 , 180
# 	sw  $t1 , ANGLE
# 	li  $t1 , 1
# 	sw  $t1 , ANGLE_CONTROL
# 	j 	finish

finish:
    lw  $s0, 0($sp)
    lw  $s1, 4($sp)
    lw  $s2, 8($sp)
    lw  $s3, 12($sp)
    lw  $s4, 16($sp)
    lw  $s5, 20($sp)
    lw  $s6, 24($sp)
    lw  $s7, 28($sp)
	lw  $t0, 32($sp)
    lw  $t1, 36($sp)
    lw  $t2, 40($sp)
    lw  $t3, 44($sp)
    lw  $t4, 48($sp)
    lw  $t5, 52($sp)
    lw  $t6, 56($sp)
    lw  $t7, 60($sp)

    add $sp, $sp, 64


    j	interrupt_dispatch

#--------------------------------------------------------------------------
puzzle_interrupt:
	sw  $a1, REQUEST_PUZZLE_ACK

	# TODO: Solve the puzzle

	j	interrupt_dispatch

#--------------------------------------------------------------------------

non_intrpt:				# was some non-interrupt
	li	$v0, PRINT_STRING
	la	$a0, non_intrpt_str
	syscall				# print out an error message
	# fall through to done

done:
    sw $s7 , REQUEST_RADAR

    la $a0, puzzle_data
    sw $a0, REQUEST_PUZZLE

	la	$k0, chunkIH
	lw	$a0, 0($k0)		# Restore saved registers
	lw	$a1, 4($k0)
.set noat
	move	$at, $k1		# Restore $at
.set at
	eret
