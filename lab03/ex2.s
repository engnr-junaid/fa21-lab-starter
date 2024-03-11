.globl main

.data
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
fun:
    addi t0, a0, 1  # t0 = x+1
    sub t1, x0, a0  # t1 = -x
    mul a0, t0, t1  # a0 = t0*t1 -> -x*(x+1)
    jr ra

main:
    # BEGIN PROLOGUE
    addi sp, sp, -20
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp)
    # END PROLOGUE
    addi t0, x0, 0 # Counter initialization t0 = k = 0 
    addi s0, x0, 0 # Sum = 0
    la s1, source  # source
    la s2, dest    # dest
loop:
    slli s3, t0, 2   # s3 = t0*4 --> k*4 
    add t1, s1, s3   # t1 = s1 + s3 --> adress of s[k] 
    lw t2, 0(t1)     # value stored at s[k]
    beq t2, x0, exit # if s[k] != 0 continue else exit  
    add a0, x0, t2   # a0 = t2 = s[k]
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t2, 4(sp)
    jal fun
    lw t0, 0(sp)
    lw t2, 4(sp)
    addi sp, sp, 8
    add t2, x0, a0  # t2 = a0 value returned from fun --> s[k] = fun(source[k]) 
    add t3, s2, s3  # t3 = s2 + s3 --> adress of dest[k]
    sw t2, 0(t3)    # t2 = dest[k] --> storing value of t2 at adress of dest[k]
    add s0, s0, t2  # s0 = s0 + t2 --> sum = sum + dest[k]
    addi t0, t0, 1  # t0 = t0 + 1  --> k = k + 1
    jal x0, loop
exit:
    add a0, x0, s0
    # BEGIN EPILOGUE
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    # END EPILOGUE
    jr ra
