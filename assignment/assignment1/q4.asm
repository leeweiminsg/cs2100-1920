        addi $t1, $zero, 1
        add $t2, $s0, $zero
        addi $t3, $s0, 64
Loop:   beq $t2, $t3, Exit
        lw $t4, 0($t2)
        bne $t4, $zero, Else
        sw $t1, 0($s1)
        j Continue
Else:   sw $zero, 0($s1)

Continue: addi $t2, $t2, 4
          j Loop
Exit: