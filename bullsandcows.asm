		.data
words:		.asciiz	"girl", "calf", "verb", "duck"
guessWord:	.asciiz ""

	.text
main:
	# Get a random number between 0 and 3
	li $v0, 42
	li $a1, 4
	syscall
	
	# Multiply that number by 5 to get the offset from the start of the array
	mulu $t0, $a0, 5
	
	# Print a random word from the array using the random offset
	li $v0, 4
	la $a0, words($t0)
	syscall
	
	#la $a0, words($t0)
	la $a0, words($t0)
	la $a1, words

# Start point for the find cows subtoutine
findCowsMain:
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	add $t4, $zero, $zero
	j findCowsLoop

# Increment i in the outer for loop
findCowsIncrementI:
	add $t0, $t0, 1

# Outer for loop
findCowsLoop:
	bgt $t0, 3, findCowsEnd
	add $t1, $zero, $zero

# Inner for loop
findCowsLoop2:
	bgt $t1, 3, findCowsIncrementI
	
	# Get the address of the characters to compare
	add $t2, $a0, $t0
	add $t3, $a1, $t1
	
	# Put the charactesr in registers
	lb $t2, ($t2)
	lb $t3, ($t3)
	
	# Branch to the increment lable if they are equal
	beq $t2, $t3, findCowsIncrement
	add $t1, $t1, 1
	j findCowsLoop2

# Increment cows counter
findCowsIncrement:
	add $t4, $t4, 1
	add $t1, $t1, 1
	j findCowsLoop2

# Return number of cows
findCowsEnd:
	add $v0, $zero, $t4
	
	
findBulls:
	addi $t0, $zero, 0	# i = 0
	addi $t5, $zero, 0	# num bulls = 0
	j forLoop
increment_i:
	addi $t0, $t0, 1	# i++
forLoop:
	bgt $t0, 3, endLoop	# if i > 3
	add $t3, $a0, $t0
	add $t4, $a1, $t0
	lb $t3, ($t3)
	lb $t4, ($t4)
	beq $t3, $t4, addBulls	# compare characters
	j increment_i
addBulls:
	addi $t5, $t5, 1	#increment num bulls
	j increment_i
endLoop:
	move $v0, $t5		# return num bulls
	jr $ra
