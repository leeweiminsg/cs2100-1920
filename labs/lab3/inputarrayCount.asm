# arrayCount.asm
  .data 
arrayA: .word 1, 0, 2, 0, 3, 1, 2, 3   # arrayA has 5 values
count:  .word 0             # dummy value

  .text
main:
    # code to setup the variable mappings
    add $zero, $zero, $zero  #dummy instructions, can be removed
    add $zero, $zero, $zero  #dummy instructions, can be removed
    add $zero, $zero, $zero  #dummy instructions, can be removed

    la $t0, arrayA

    la $t8, count
    lw $s0, 0($t8)

    addi $t1, $t0, 0
    addi $t2, $t0, 32

    # code for reading in the user input array values
loop: beq  $t1, $t2, end
      li   $v0, 5
      syscall
      sw   $v0, 0($t1)
      addi $t1, $t1, 4
      j loop
end:

    # code for reading in the user input x
    li   $v0, 5
    syscall
    addi $t3, $v0, 0

    # code for counting multiples of X in arrayA
    addi $t1, $t0, 0

    addi $t4, $t3, -1


looptwo: beq  $t1, $t2, endtwo
         
         lw $t5, 0($t1)
         and $t6, $t5, $t4
         bne $t6, $zero, skip
         addi $s0, $s0, 1

skip:    addi $t1, $t1, 4
         j looptwo
endtwo:

    # code for printing result
    li   $v0, 1    # system call code for print_int
    add $a0, $s0, $zero
    syscall        # print the integer

    # code for terminating program
    li  $v0, 10
    syscall