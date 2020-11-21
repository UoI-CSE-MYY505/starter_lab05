
        .data
n1:
        .word  1
n15:
        .word  15
n_m5:
        .word  -5
       
        .globl main

        .text
main:   
L01:    lui  $at, 0x01001
L02:    ori  $t0, $at, 0
        # The above 2 instructios are "la   $t0, n1"
L03:    addi $t0, $t0, 8
L04:    lw   $t3, 0($t0)   # -5 = 32'b111...1_1011
L05:    addi $t0, $t0, -8
L06:    lw   $t2, 4($t0)   # 15 = 32'b000...0_1111
L07:    lw   $t1, 0($t0)   # 1
L08:    beq  $t1, $zero, notTaken
L09:    and  $t4, $t1, $t3 #  t4 = 32'b000...0_0001 
L10:    or   $t5, $t3, $t2 #  t5 = 32'b111...1_1111 = -1
L11:    slt  $t6, $t4, $t5 # Should be 0
L12:    beq  $t6, $zero, taken 
notTaken:  # should never get here!
L13:    sw   $t3, 0($t0)    # Detect it by storing -5 in n1
L14:    add  $t0, $t4, $t4  # should generate X's in simulation, break $t0!
taken:
L15:    sw   $t0, 0($t0)    # stores address of n1 in n1, if all OK.
L16:    sub  $t7, $t2, $t1 # Should be 14
L17:    addi $t7, $t7, 2   # Should be 16
