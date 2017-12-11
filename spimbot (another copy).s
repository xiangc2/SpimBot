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

inv_sbox:
.byte 0x52 0x09 0x6A 0xD5 0x30 0x36 0xA5 0x38 0xBF 0x40 0xA3 0x9E 0x81 0xF3 0xD7 0xFB
.byte 0x7C 0xE3 0x39 0x82 0x9B 0x2F 0xFF 0x87 0x34 0x8E 0x43 0x44 0xC4 0xDE 0xE9 0xCB
.byte 0x54 0x7B 0x94 0x32 0xA6 0xC2 0x23 0x3D 0xEE 0x4C 0x95 0x0B 0x42 0xFA 0xC3 0x4E
.byte 0x08 0x2E 0xA1 0x66 0x28 0xD9 0x24 0xB2 0x76 0x5B 0xA2 0x49 0x6D 0x8B 0xD1 0x25
.byte 0x72 0xF8 0xF6 0x64 0x86 0x68 0x98 0x16 0xD4 0xA4 0x5C 0xCC 0x5D 0x65 0xB6 0x92
.byte 0x6C 0x70 0x48 0x50 0xFD 0xED 0xB9 0xDA 0x5E 0x15 0x46 0x57 0xA7 0x8D 0x9D 0x84
.byte 0x90 0xD8 0xAB 0x00 0x8C 0xBC 0xD3 0x0A 0xF7 0xE4 0x58 0x05 0xB8 0xB3 0x45 0x06
.byte 0xD0 0x2C 0x1E 0x8F 0xCA 0x3F 0x0F 0x02 0xC1 0xAF 0xBD 0x03 0x01 0x13 0x8A 0x6B
.byte 0x3A 0x91 0x11 0x41 0x4F 0x67 0xDC 0xEA 0x97 0xF2 0xCF 0xCE 0xF0 0xB4 0xE6 0x73
.byte 0x96 0xAC 0x74 0x22 0xE7 0xAD 0x35 0x85 0xE2 0xF9 0x37 0xE8 0x1C 0x75 0xDF 0x6E
.byte 0x47 0xF1 0x1A 0x71 0x1D 0x29 0xC5 0x89 0x6F 0xB7 0x62 0x0E 0xAA 0x18 0xBE 0x1B
.byte 0xFC 0x56 0x3E 0x4B 0xC6 0xD2 0x79 0x20 0x9A 0xDB 0xC0 0xFE 0x78 0xCD 0x5A 0xF4
.byte 0x1F 0xDD 0xA8 0x33 0x88 0x07 0xC7 0x31 0xB1 0x12 0x10 0x59 0x27 0x80 0xEC 0x5F
.byte 0x60 0x51 0x7F 0xA9 0x19 0xB5 0x4A 0x0D 0x2D 0xE5 0x7A 0x9F 0x93 0xC9 0x9C 0xEF
.byte 0xA0 0xE0 0x3B 0x4D 0xAE 0x2A 0xF5 0xB0 0xC8 0xEB 0xBB 0x3C 0x83 0x53 0x99 0x61
.byte 0x17 0x2B 0x04 0x7E 0xBA 0x77 0xD6 0x26 0xE1 0x69 0x14 0x63 0x55 0x21 0x0C 0x7D

inv_mix:
.byte 0x00 0x0e 0x1c 0x12 0x38 0x36 0x24 0x2a 0x70 0x7e 0x6c 0x62 0x48 0x46 0x54 0x5a
.byte 0xe0 0xee 0xfc 0xf2 0xd8 0xd6 0xc4 0xca 0x90 0x9e 0x8c 0x82 0xa8 0xa6 0xb4 0xba
.byte 0xdb 0xd5 0xc7 0xc9 0xe3 0xed 0xff 0xf1 0xab 0xa5 0xb7 0xb9 0x93 0x9d 0x8f 0x81
.byte 0x3b 0x35 0x27 0x29 0x03 0x0d 0x1f 0x11 0x4b 0x45 0x57 0x59 0x73 0x7d 0x6f 0x61
.byte 0xad 0xa3 0xb1 0xbf 0x95 0x9b 0x89 0x87 0xdd 0xd3 0xc1 0xcf 0xe5 0xeb 0xf9 0xf7
.byte 0x4d 0x43 0x51 0x5f 0x75 0x7b 0x69 0x67 0x3d 0x33 0x21 0x2f 0x05 0x0b 0x19 0x17
.byte 0x76 0x78 0x6a 0x64 0x4e 0x40 0x52 0x5c 0x06 0x08 0x1a 0x14 0x3e 0x30 0x22 0x2c
.byte 0x96 0x98 0x8a 0x84 0xae 0xa0 0xb2 0xbc 0xe6 0xe8 0xfa 0xf4 0xde 0xd0 0xc2 0xcc
.byte 0x41 0x4f 0x5d 0x53 0x79 0x77 0x65 0x6b 0x31 0x3f 0x2d 0x23 0x09 0x07 0x15 0x1b
.byte 0xa1 0xaf 0xbd 0xb3 0x99 0x97 0x85 0x8b 0xd1 0xdf 0xcd 0xc3 0xe9 0xe7 0xf5 0xfb
.byte 0x9a 0x94 0x86 0x88 0xa2 0xac 0xbe 0xb0 0xea 0xe4 0xf6 0xf8 0xd2 0xdc 0xce 0xc0
.byte 0x7a 0x74 0x66 0x68 0x42 0x4c 0x5e 0x50 0x0a 0x04 0x16 0x18 0x32 0x3c 0x2e 0x20
.byte 0xec 0xe2 0xf0 0xfe 0xd4 0xda 0xc8 0xc6 0x9c 0x92 0x80 0x8e 0xa4 0xaa 0xb8 0xb6
.byte 0x0c 0x02 0x10 0x1e 0x34 0x3a 0x28 0x26 0x7c 0x72 0x60 0x6e 0x44 0x4a 0x58 0x56
.byte 0x37 0x39 0x2b 0x25 0x0f 0x01 0x13 0x1d 0x47 0x49 0x5b 0x55 0x7f 0x71 0x63 0x6d
.byte 0xd7 0xd9 0xcb 0xc5 0xef 0xe1 0xf3 0xfd 0xa7 0xa9 0xbb 0xb5 0x9f 0x91 0x83 0x8d
.byte 0x00 0x0b 0x16 0x1d 0x2c 0x27 0x3a 0x31 0x58 0x53 0x4e 0x45 0x74 0x7f 0x62 0x69
.byte 0xb0 0xbb 0xa6 0xad 0x9c 0x97 0x8a 0x81 0xe8 0xe3 0xfe 0xf5 0xc4 0xcf 0xd2 0xd9
.byte 0x7b 0x70 0x6d 0x66 0x57 0x5c 0x41 0x4a 0x23 0x28 0x35 0x3e 0x0f 0x04 0x19 0x12
.byte 0xcb 0xc0 0xdd 0xd6 0xe7 0xec 0xf1 0xfa 0x93 0x98 0x85 0x8e 0xbf 0xb4 0xa9 0xa2
.byte 0xf6 0xfd 0xe0 0xeb 0xda 0xd1 0xcc 0xc7 0xae 0xa5 0xb8 0xb3 0x82 0x89 0x94 0x9f
.byte 0x46 0x4d 0x50 0x5b 0x6a 0x61 0x7c 0x77 0x1e 0x15 0x08 0x03 0x32 0x39 0x24 0x2f
.byte 0x8d 0x86 0x9b 0x90 0xa1 0xaa 0xb7 0xbc 0xd5 0xde 0xc3 0xc8 0xf9 0xf2 0xef 0xe4
.byte 0x3d 0x36 0x2b 0x20 0x11 0x1a 0x07 0x0c 0x65 0x6e 0x73 0x78 0x49 0x42 0x5f 0x54
.byte 0xf7 0xfc 0xe1 0xea 0xdb 0xd0 0xcd 0xc6 0xaf 0xa4 0xb9 0xb2 0x83 0x88 0x95 0x9e
.byte 0x47 0x4c 0x51 0x5a 0x6b 0x60 0x7d 0x76 0x1f 0x14 0x09 0x02 0x33 0x38 0x25 0x2e
.byte 0x8c 0x87 0x9a 0x91 0xa0 0xab 0xb6 0xbd 0xd4 0xdf 0xc2 0xc9 0xf8 0xf3 0xee 0xe5
.byte 0x3c 0x37 0x2a 0x21 0x10 0x1b 0x06 0x0d 0x64 0x6f 0x72 0x79 0x48 0x43 0x5e 0x55
.byte 0x01 0x0a 0x17 0x1c 0x2d 0x26 0x3b 0x30 0x59 0x52 0x4f 0x44 0x75 0x7e 0x63 0x68
.byte 0xb1 0xba 0xa7 0xac 0x9d 0x96 0x8b 0x80 0xe9 0xe2 0xff 0xf4 0xc5 0xce 0xd3 0xd8
.byte 0x7a 0x71 0x6c 0x67 0x56 0x5d 0x40 0x4b 0x22 0x29 0x34 0x3f 0x0e 0x05 0x18 0x13
.byte 0xca 0xc1 0xdc 0xd7 0xe6 0xed 0xf0 0xfb 0x92 0x99 0x84 0x8f 0xbe 0xb5 0xa8 0xa3
.byte 0x00 0x0d 0x1a 0x17 0x34 0x39 0x2e 0x23 0x68 0x65 0x72 0x7f 0x5c 0x51 0x46 0x4b
.byte 0xd0 0xdd 0xca 0xc7 0xe4 0xe9 0xfe 0xf3 0xb8 0xb5 0xa2 0xaf 0x8c 0x81 0x96 0x9b
.byte 0xbb 0xb6 0xa1 0xac 0x8f 0x82 0x95 0x98 0xd3 0xde 0xc9 0xc4 0xe7 0xea 0xfd 0xf0
.byte 0x6b 0x66 0x71 0x7c 0x5f 0x52 0x45 0x48 0x03 0x0e 0x19 0x14 0x37 0x3a 0x2d 0x20
.byte 0x6d 0x60 0x77 0x7a 0x59 0x54 0x43 0x4e 0x05 0x08 0x1f 0x12 0x31 0x3c 0x2b 0x26
.byte 0xbd 0xb0 0xa7 0xaa 0x89 0x84 0x93 0x9e 0xd5 0xd8 0xcf 0xc2 0xe1 0xec 0xfb 0xf6
.byte 0xd6 0xdb 0xcc 0xc1 0xe2 0xef 0xf8 0xf5 0xbe 0xb3 0xa4 0xa9 0x8a 0x87 0x90 0x9d
.byte 0x06 0x0b 0x1c 0x11 0x32 0x3f 0x28 0x25 0x6e 0x63 0x74 0x79 0x5a 0x57 0x40 0x4d
.byte 0xda 0xd7 0xc0 0xcd 0xee 0xe3 0xf4 0xf9 0xb2 0xbf 0xa8 0xa5 0x86 0x8b 0x9c 0x91
.byte 0x0a 0x07 0x10 0x1d 0x3e 0x33 0x24 0x29 0x62 0x6f 0x78 0x75 0x56 0x5b 0x4c 0x41
.byte 0x61 0x6c 0x7b 0x76 0x55 0x58 0x4f 0x42 0x09 0x04 0x13 0x1e 0x3d 0x30 0x27 0x2a
.byte 0xb1 0xbc 0xab 0xa6 0x85 0x88 0x9f 0x92 0xd9 0xd4 0xc3 0xce 0xed 0xe0 0xf7 0xfa
.byte 0xb7 0xba 0xad 0xa0 0x83 0x8e 0x99 0x94 0xdf 0xd2 0xc5 0xc8 0xeb 0xe6 0xf1 0xfc
.byte 0x67 0x6a 0x7d 0x70 0x53 0x5e 0x49 0x44 0x0f 0x02 0x15 0x18 0x3b 0x36 0x21 0x2c
.byte 0x0c 0x01 0x16 0x1b 0x38 0x35 0x22 0x2f 0x64 0x69 0x7e 0x73 0x50 0x5d 0x4a 0x47
.byte 0xdc 0xd1 0xc6 0xcb 0xe8 0xe5 0xf2 0xff 0xb4 0xb9 0xae 0xa3 0x80 0x8d 0x9a 0x97
.byte 0x00 0x09 0x12 0x1b 0x24 0x2d 0x36 0x3f 0x48 0x41 0x5a 0x53 0x6c 0x65 0x7e 0x77
.byte 0x90 0x99 0x82 0x8b 0xb4 0xbd 0xa6 0xaf 0xd8 0xd1 0xca 0xc3 0xfc 0xf5 0xee 0xe7
.byte 0x3b 0x32 0x29 0x20 0x1f 0x16 0x0d 0x04 0x73 0x7a 0x61 0x68 0x57 0x5e 0x45 0x4c
.byte 0xab 0xa2 0xb9 0xb0 0x8f 0x86 0x9d 0x94 0xe3 0xea 0xf1 0xf8 0xc7 0xce 0xd5 0xdc
.byte 0x76 0x7f 0x64 0x6d 0x52 0x5b 0x40 0x49 0x3e 0x37 0x2c 0x25 0x1a 0x13 0x08 0x01
.byte 0xe6 0xef 0xf4 0xfd 0xc2 0xcb 0xd0 0xd9 0xae 0xa7 0xbc 0xb5 0x8a 0x83 0x98 0x91
.byte 0x4d 0x44 0x5f 0x56 0x69 0x60 0x7b 0x72 0x05 0x0c 0x17 0x1e 0x21 0x28 0x33 0x3a
.byte 0xdd 0xd4 0xcf 0xc6 0xf9 0xf0 0xeb 0xe2 0x95 0x9c 0x87 0x8e 0xb1 0xb8 0xa3 0xaa
.byte 0xec 0xe5 0xfe 0xf7 0xc8 0xc1 0xda 0xd3 0xa4 0xad 0xb6 0xbf 0x80 0x89 0x92 0x9b
.byte 0x7c 0x75 0x6e 0x67 0x58 0x51 0x4a 0x43 0x34 0x3d 0x26 0x2f 0x10 0x19 0x02 0x0b
.byte 0xd7 0xde 0xc5 0xcc 0xf3 0xfa 0xe1 0xe8 0x9f 0x96 0x8d 0x84 0xbb 0xb2 0xa9 0xa0
.byte 0x47 0x4e 0x55 0x5c 0x63 0x6a 0x71 0x78 0x0f 0x06 0x1d 0x14 0x2b 0x22 0x39 0x30
.byte 0x9a 0x93 0x88 0x81 0xbe 0xb7 0xac 0xa5 0xd2 0xdb 0xc0 0xc9 0xf6 0xff 0xe4 0xed
.byte 0x0a 0x03 0x18 0x11 0x2e 0x27 0x3c 0x35 0x42 0x4b 0x50 0x59 0x66 0x6f 0x74 0x7d
.byte 0xa1 0xa8 0xb3 0xba 0x85 0x8c 0x97 0x9e 0xe9 0xe0 0xfb 0xf2 0xcd 0xc4 0xdf 0xd6
.byte 0x31 0x38 0x23 0x2a 0x15 0x1c 0x07 0x0e 0x79 0x70 0x6b 0x62 0x5d 0x54 0x4f 0x46

.align 2
event_horizon_data: .space 90000

.align 2
coin_data: .space 9000

.align 2
puzzle_data: .space 512
plaintext: .space 512
sol: .space 512
uniq_chars: .space 25

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

    sge $t1 , $s1 , 150
    sge $t2 , $s2 , 150

    li  $t4 , 1
    and $t3 , $t1 , $t2
    beq $t3 , $t4 , rl

    li  $t4 , 0
    or  $t3 , $t1 , $t2
    beq $t3 , $t4 , l_u

    beq $t1 , $t4 , l_l

    j   ru


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

   

    beq $s0, 0xffffffff , find_banana
    srl $s1, $s0, 16         # s1 : target_x
    sll $s0, $s0, 16
    srl $s0, $s0, 16         # s0 : target_y

    lw  $s2 , BOT_X              #s2 : x
    lw  $s3 , BOT_Y              #s3 : y

    bge $s3 , $s0 , go_up
     j   go_down

 go_up:

     lw  $s4 , BOT_X              #s2 : x
     lw  $s5 , BOT_Y              #s3 : y
     ble $s5 , $s0 , go_y

     li  $t4 , 1
     sw  $t4 , ANGLE_CONTROL
     li  $t4 , 270
     sw  $t4 , ANGLE
     j   go_up

 go_down:

     lw  $s4 , BOT_X              #s2 : x
     lw  $s5 , BOT_Y              #s3 : y
     bge $s5 , $s0 , go_y
     li  $t4 , 1
     sw  $t4 , ANGLE_CONTROL
     li  $t4 , 90
     sw  $t4 , ANGLE
     j   go_down

 go_y:

     ble $s4 , $s1 , go_right
     j   go_left

 go_right:

     lw  $s4 , BOT_X              #s2 : x
     lw  $s5 , BOT_Y              #s3 : y
     bge $s4 , $s1 , go_back
     li  $t4 , 1
     sw  $t4 , ANGLE_CONTROL
     li  $t4 , 0
     sw  $t4 , ANGLE
     j   go_right

 go_left:

     lw  $s4 , BOT_X              #s2 : x
     lw  $s5 , BOT_Y              #s3 : y
     ble $s4 , $s1 , go_back
     li  $t4 , 1
     sw  $t4 , ANGLE_CONTROL
     li  $t4 , 180
     sw  $t4 , ANGLE
     j   go_left

 go_back:

     move $s6 , $s0
     move $s0 , $s3
     move $s3 , $s6
     move $s6 , $s1
     move $s1 , $s2
     move $s2 , $s6

     bge $s3 , $s0 , bgo_up
     j   bgo_down

 bgo_up:

     lw  $s4 , BOT_X              #s2 : x
     lw  $s5 , BOT_Y              #s3 : y
     ble $s5 , $s0 , bgo_y

     li  $t4 , 1
     sw  $t4 , ANGLE_CONTROL
     li  $t4 , 270
     sw  $t4 , ANGLE
     j   bgo_up

 bgo_down:

     lw  $s4 , BOT_X              #s2 : x
     lw  $s5 , BOT_Y              #s3 : y
     bge $s5 , $s0 , bgo_y
     li  $t4 , 1
     sw  $t4 , ANGLE_CONTROL
     li  $t4 , 90
     sw  $t4 , ANGLE
     j   bgo_down

 bgo_y:

     ble $s4 , $s1 , bgo_right
     j   bgo_left

 bgo_right:

     lw  $s4 , BOT_X              #s2 : x
     lw  $s5 , BOT_Y              #s3 : y
     bge $s4 , $s1 , find_banana
     li  $t4 , 1
     sw  $t4 , ANGLE_CONTROL
     li  $t4 , 0
     sw  $t4 , ANGLE
     j   bgo_right

 bgo_left:

     lw  $s4 , BOT_X              #s2 : x
     lw  $s5 , BOT_Y              #s3 : y
     ble $s4 , $s1 , find_banana
     li  $t4 , 1
     sw  $t4 , ANGLE_CONTROL
     li  $t4 , 180
     sw  $t4 , ANGLE
     j   bgo_left

#-------------------------------------------------

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
    # TODO: Solve the puzzle
	sub $sp, $sp, 24
	sw  $a0,	0($sp)
	sw	$a1,	4($sp)
	sw	$a2,	8($sp)
	sw	$a3,	12($sp)
	#sw	$t8		16($sp)
	sw	$t6		16($sp)
#NEED TO DECRYPT FOUR TIMES
# decrypt(uint8_t *ciphertext, uint8_t *plaintext, uint8_t *key, uint8_t rounds)
	add $a0, $t6, 0	#encrypt first 16 char
	la 	$a1, plaintext	#output
	add	$a2, $t6, 64	#key
	lb	$a3, 208($t6)	#rounds
	jal	decrypt

lw	$t6, 16($sp)
	add $a0, $t6, 16	#encrypt second 16 char
	la 	$a1, plaintext	#output
	add	$a1, $a1, 16
lw	$t6, 16($sp)
	add	$a2, $t6, 64	#key
lw	$t6, 16($sp)
	lb	$a3, 208($t6)	#rounds
	jal	decrypt

lw	$t6, 16($sp)
	add $a0, $t6, 32	#encrypt third 16 char
	la 	$a1, plaintext	#output
	add	$a1, $a1, 32
lw	$t6, 16($sp)
	add	$a2, $t6, 64	#key
lw	$t6, 16($sp)
	lb	$a3, 208($t6)	#rounds
	jal	decrypt

lw	$t6, 16($sp)
	add $a0, $t6, 48	#encrypt fouth 16 char
	la 	$a1, plaintext	#output
	add	$a1, $a1, 48
lw	$t6, 16($sp)
	add	$a2, $t6, 64	#key
lw	$t6, 16($sp)
	lb	$a3, 208($t6)	#rounds
	jal	decrypt


#max_unique_n_substr(char *in_str, char *out_str, int n)
	la	$a0, plaintext
	la	$a1, sol
lw	$t6, 16($sp)
	lb	$a2, 212($t6)	#unique_chars
	jal	max_unique_n_substr


	la	$t8, sol
	sw	$t8, SUBMIT_SOLUTION

	lw  $a0,	0($sp)
	lw	$a1,	4($sp)
	lw	$a2,	8($sp)
	lw	$a3,	12($sp)
	#sw	$t8		16($sp)
	sw	$t6		16($sp)
	add	$sp, $sp, 20

	j	done

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
	sub	$sp, $sp, 40
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)			# $s0 = char *in_str
	sw	$s1, 8($sp)			# $s1 = char *out_str
	sw	$s2, 12($sp)			# $s2 = int n
	sw	$s3, 16($sp)			# $s3 = char *max_marker
	sw	$s4, 20($sp)			# $s4 = unsigned int len_max
	sw	$s5, 24($sp)			# $s5 = unsigned int len_in_str
	sw	$s6, 28($sp)			# $s6 = unsigned int cur_pos
	sw	$s7, 32($sp)			# $s7 = int len_cur
	sw	$t6, 36($sp)
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
	lw		$t6, 36($sp)
	add	$sp, $sp, 40

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
	sw	$t6, 36($sp)

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
	lw	$t6, 36($sp)
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
for_loopisr:
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
	j	for_loopisr
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


.globl rearrange_matrix
rearrange_matrix:
	move	$t0, $zero
rm_for_loop: 
	bge	$t0, 4, end_for_looprm

	#pointer to out
	mul	$t1, $t0, 4
	add	$t1, $t1, $a1

	sw	$zero, 0($t1)

	move	$t2, $zero
second_for_loop:
	#load in
	bge	$t2, 4, end_second_for_loop
	mul	$t3, $t2, 4  
	add	$t3, $t3, $t0
	add	$t3, $a0, $t3

	lbu	$t4, 0($t3)         
	mul	$t5, $t2 ,8
	sllv	$t4, $t4, $t5

	lw	$t5, 0($t1)
	or	$t5, $t5, $t4
	sw	$t5, 0($t1)

	add	$t2, $t2, 1
	j	second_for_loop

end_second_for_loop:
	add	$t0, $t0, 1
	j	rm_for_loop
end_for_looprm:
	jr	$ra


.globl circular_shift
circular_shift:
	mul	$t0, $a1, 8
	srl	$t1, $a0, $t0
	sub	$t2, $0, $t0
	add	$t2, $t2, 32
	sll	$t2, $a0, $t2
	or	$v0, $t1, $t2
	jr	$ra

.globl my_strlen
my_strlen:
	move	$v0, $0			# $v0 = unsigned int count = 0
	bne	$a0, $0, ms_while	# if (in != NULL), skip
	jr	$ra			# return 0

ms_while:
	lb	$t0, 0($a0)		# $t0 = *in
	beq	$t0, $0, ms_done	# if (in == 0), done

	add	$v0, $v0, 1		# count++
	add	$a0, $a0, 1		# in++
	j	ms_while

ms_done:
	jr	$ra			# return count




.globl nth_uniq_char
nth_uniq_char:
	beq	$a0, $0, nuc_abort 		# !in_str
	beq	$a1, $0, nuc_abort		# !n
	j	nuc_ok

nuc_abort:
	li	$v0, -1				# return -1
	jr	$ra

nuc_ok:
	la	$t0, uniq_chars			# $t0 = uniq_chars = &uniq_chars[0]
	lb	$t9, 0($a0)			# *in_str
	sb	$t9, 0($t0)			# uniq_chars[0] = *in_str

	li	$t1, 1				# $t1 = int uniq_so_far = 1
	li	$t2, 0				# $t2 = int position = 0
	add	$a0, $a0, 1			# in_str++

nuc_while:
	bge	$t1, $a1, nuc_while_end 	# if (uniq_so_far >= n), end
	lb	$t9, 0($a0)			# *in_str
	beq	$t9, $0, nuc_while_end		# if (*in_str == 0), end

	li	$t3, 1				# $t3 = char is_uniq = 1

	li	$t4, 0				# $t4 = int j = 0
nuc_for:
	bge	$t4, $t1, nuc_for_end

	add	$t9, $t0, $t4			# &uniq_chars[j]
	lb	$t9, 0($t9)			# uniq_chars[j]
	lb	$t8, 0($a0)			# *in_str
	bne	$t9, $t8, nuc_for_cont		# if (uniq_chars[j] != *in_str), skip
	li	$t3, 0
	j	nuc_for_end

nuc_for_cont:
	add	$t4, $t4, 1			# j++
	j	nuc_for

nuc_for_end:
	beq	$t3, $0, nuc_while_cont 	# if (is_uniq == 0), continue
	lb	$t9, 0($a0)			# *in_str
	add	$t8, $t0, $t1			# &uniq_chars[uniq_so_far]
	sb	$t9, 0($t8)			# uniq_chars[uniq_so_far] = *in_str
	add	$t1, $t1, 1			# uniq_so_far++

nuc_while_cont:
	add	$t2, $t2, 1			# position++
	add	$a0, $a0, 1			# in_str++
	j	nuc_while

nuc_while_end:
	bge	$t1, $a1, nuc_end 		# if (uniq_so_far >= n), skip
	add	$t2, $t2, 1			# position++

nuc_end:
	move	$v0, $t2			# return position
	jr	$ra



