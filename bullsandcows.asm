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