# arrayFunction.asm
       .data 
array: .word 8, 2, 1, 6, 9, 7, 3, 5, 0, 4
newl:  .asciiz "\n"

       .text
main:
	# Print the original content of array
	# setup the parameter(s)
	# call the printArray function

	# For printArray
	la $a0 array
	li $a1 10

	# Call the printArray function
	jal printArray

	# Ask the user for two indices
	li   $v0, 5         	# System call code for read_int
	syscall           
	addi $t0, $v0, 0    	# first user input in $t0

	li   $v0, 5         	# System call code for read_int
	syscall           
	addi $t1, $v0, 0    	# second user input in $t1

	# Call the findMin function
	# setup the parameter(s)
	# call the function

	# For findMin
	la $t3 array
	# Multiply by 4 (word aligned)
	sll $t0, $t0, 2
	sll $t1, $t1, 2
	# Add to starting memory address of array
	add $a0, $t3, $t0
	add $a1, $t3, $t1

	# Call the findMin function
	jal findMin

	# Print the min item
	# place the min item in $t3	for printing
	# Set t3 to contain minimum value
	addi $t3, $t0, 0

	# Find no. of btyes from start of array
	la $t4 array
	sub $t2, $v0, $t4
	# Find index
	srl $t2, $t2, 2

	# Print an integer followed by a newline
	li   $v0, 1   		# system call code for print_int
    addi $a0, $t3, 0    # print $t3
    syscall       		# make system call

	li   $v0, 4   		# system call code for print_string
    la   $a0, newl    	# 
    syscall       		# print newline

	#Calculate and print the index of min item
	# Place the min index in $t3 for printing
	# Set t3 to contain minimum index
	addi $t3, $t2, 0

	# Print the min index
	# Print an integer followed by a newline
	li   $v0, 1   		# system call code for print_int
    addi $a0, $t3, 0    # print $t3
    syscall       		# make system call
	
	li   $v0, 4   		# system call code for print_string
    la   $a0, newl    	# 
    syscall       		# print newline
	
	# End of main, make a syscall to "exit"
	li   $v0, 10   		# system call code for exit
	syscall	       	# terminate program
	

#######################################################################
###   Function printArray   ### 
#Input: Array Address in $a0, Number of elements in $a1
#Output: None
#Purpose: Print array elements
#Registers used: $t0, $t1, $t2, $t3
#Assumption: Array element is word size (4-byte)

printArray:
	addi $t1, $a0, 0	#$t1 is the pointer to the item
	sll  $t2, $a1, 2	#$t2 is the offset beyond the last item
	add  $t2, $a0, $t2 	#$t2 is pointing beyond the last item
l1:	
	beq  $t1, $t2, e1
	lw   $t3, 0($t1)	#$t3 is the current item
	li   $v0, 1   		# system call code for print_int
     	addi $a0, $t3, 0    	# integer to print
     	syscall       		# print it
	addi $t1, $t1, 4
	j l1				# Another iteration
e1:
	li   $v0, 4   		# system call code for print_string
     	la   $a0, newl    	# 
     	syscall       		# print newline
	jr $ra			# return from this function


#######################################################################
###   Student Function findMin   ### 
#Input: Lower Array Pointer in $a0, Higher Array Pointer in $a1
#Output: $v0 contains the address of min item 
#Purpose: Find and return the minimum item 
#              between $a0 and $a1 (inclusive)
#Registers used: <Fill in with your register usage>
#Assumption: Array element is word size (4-byte), $a0 <= $a1
findMin:
	# Minimum value
	lw $t0, 0($a0)
	# Memory address of current item
	addi $t1, $a0, 0
	# Set memory address of current item
	addi $v0, $t1, 0
	# Memory address of end point
	addi $t2, $a1, 4

loop:
	beq $t1, $t2, exit
	# Current value
	lw $t3, 0($t1)
	# If value is less than minimum:
	slt $t4, $t3, $t0
	# Inverting if condition (value is less than minimum)
	beq $t4, $zero, moreThanOrEqual
	# Update minimum value
	addi $t0, $t3, 0
	# Update minimum value address
	addi $v0, $t1, 0

moreThanOrEqual:
	# Update pointer
	addi $t1, $t1, 4
	j loop

exit:
	jr $ra			# return from this function