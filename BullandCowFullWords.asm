	#	Team Name: Pro Coders
	#
	#	Team Members: Edgardo Ramirez, Adam Johnson, Luis Castro Ochoa
	#
	#	CS 3340.001
	#
	#
.data
words:		.asciiz	"alum","apex","axed","blip","bins","bine","bosh","bowl","dewy","diel","dims","dime","duce","dump","cure","foxy","evil","frat","fowl","gale","gaes",
"gamy","geds","hams","hail","hays","helm","idol","iron","jabs","jade","jean","jerk","join","kale","keys","knot","lace","lack","lark","lock","lube","mach","mash","meat","mile","mold","nods","norm","nose","oath","oily","oink",
"orca","owls","pelt","peas","pets","plan","ping","pong","rail","rain","read","rune","rush","scar","sank","sand","shot","ship","tick","tofu","toed","turf","ugly","unit","undo","verb","veil","vent","vain","wane","want","whoa",
"wife","worm","wrap","yelp","yolk","yogi","your","yoga","zero","zest","zinc","zing","zaps","zeal","worn"
guessWord:	.asciiz ""
newln: .asciiz "\n"
mesg1: .asciiz "Welcome to Bulls and Cows!\n"
mesg2: .asciiz "In this game you will try to guess a four letter word in 10 guesses.\n"
mesg3: .asciiz "The word will not have two of the same letter, and will only contain alphabetic symbols.\n"
mesg4: .asciiz "Please enter your guess(or 0 to exit): "
inval1: .asciiz "Invalid input.\nYour guess has to be a 4-letter word of all lowercase alphabetic symbols\n"
inval2: .asciiz "Invalid input.\nYour guess cannot contain two of the same letters\n""
cows: .asciiz "Num Cows: "
bulls: .asciiz "Num Bulls: "
guessword: .space 20
winner: .asciiz "Congragulations you won!\n"
loser: .asciiz "You lose!\n"
music: .asciiz "\nBackground music that we wanted to impliment:"
numbull: .word 0
numcow: .word 0
winword: .word 0
loser2: .asciiz "The word was: "

vic1: .asciiz "You won in "
vic2: .asciiz " move(s)!\n"
.text
# $t0 holds the rng word, $t1 holds the input word
# $t7 is being used to hold the total count of the program 
main:
	# Get a random number between 0 and 3
	li $v0, 42 
	li $a1, 100 #word will load into $a0
	syscall

	
	# Multiply that number by 5 to get the offset from the start of the array
	mulu $t0, $a0, 5
	
	# Print a random word from the array using the random offset
	#li $v0, 4
	#la $a0, words($t0)
	sw $t0, winword
	#syscall
	
	li $v0, 4
	la $a0, newln
	syscall
	
	jal s1
	#display game messages
	li $v0, 4
	la $a0, mesg1
	syscall
	
	jal s2 #playing music
	
	li $v0, 4
	la $a0, mesg2
	syscall

	jal s3

	li $v0, 4
	la $a0, mesg3
	syscall
	
	jal s4
	
	add $t7, $zero, $zero #set value of counter to 0
	
	j game
	
invalidguess1:
	jal invalid	# play invalid sound
	li $v0, 4
	la $a0, inval1	#print error message
	syscall	
	j game
invalidguess2:
	jal invalid	# play invalid sound
	li $v0, 4
	la $a0, inval2	#print error message
	syscall	
	j game
	
game:
	#display message asking for input
	li $v0, 4
	la $a0, mesg4
	syscall
	
	li $v0, 8 #take in input
	la $a0, guessword
	li $a1, 20
	move $t1, $a0
	syscall
	
checkinput:
	lbu $t1, ($t1)		# get first byte
	beq $t1, 0x30, defeat	# exit if user enter 0
	addi $t0, $zero, 0	# i = 0
	addi $t1, $zero, 3	# j = 3	
	j outerloop
incrementI:
	addi $t0, $t0, 1	#i++
outerloop:
	bgt $t0, 3, cont	# guess is valid continue to game
	addi $t1, $t1, 3	# reset j to 3
innerloop:
	beq $t0, $t1, incrementI	# if i == j, continue
	beq $t1, -1, incrementI
	add $t2, $a0, $t0	# get first byte of guess
	add $t3, $a0, $t1	# get last byte of guess
	lbu $t2, ($t2)
	lbu $t3, ($t3)
	addi $t4, $a0, 4	
	lbu $t4, ($t4)
	bne $t4, 10, invalidguess1	# invalid if more than 4 letters
	blt $t2, 97, invalidguess1	# invalid if not a lowercase alphabetic character
	bgt $t2, 122, invalidguess1
	beq $t2, $t3, invalidguess2	# compare characters , if equal then its invalid
	subi $t1, $t1, 1
	j innerloop


	#temporary, setting $t2 to 0 so program will run 
	add $t2, $zero, $zero
	#jal validcheck #check if valid input, will return 0 if they are the same 
	beqz $t2, cont
	
cont:	##get and display display number of cows and bulls
	
	lw $t0, winword
	la $a0, words($t0)
	la $a1, guessword
	jal findBulls
	jal findCowsMain
	move $t0, $a0
	move $t1, $a1
	add $t7, $t7, 1
	
	
	#if you win will play victory music and exit
	lw $t0, numbull
	beq $t0, 4, win
	lw $t1, numcow
	
	#subtracts number of bulls from number of cows to get correct number of cows
	sub $t1, $t1, $t0
	sw $t1, numcow
	
	li $v0, 4
	la $a0, cows
	syscall
	
	li $v0, 1
	lw $t0, numcow
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, newln
	syscall
	
	li $v0, 4
	la $a0, bulls
	syscall
	
	li $v0, 1
	lw $t0, numbull
	move $a0, $t0
	syscall
	
	li $v0, 4
	la $a0, newln
	syscall
	

	li $v0, 4
	la $a0, newln
	syscall
	beq $t7, 10, defeat
	jal valid
	j game


# Find num Cows subroutine
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
	addi $t4, $t4, 1
	addi $t1, $t1, 1
	j findCowsLoop2

# Return number of cows
findCowsEnd:
	sw $t4, numcow
	jr $ra
	
# Find num Bulls subroutine	
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
	sw $t5, numbull
	jr $ra

# If the player wins, display the number of moves needed and play winning sound
win:
	li $v0, 4
	la $a0, winner
	syscall
	
	jal victory
	
	li $v0, 4
	la $a0, vic1
	syscall
	
	li $v0, 1
	la $a0, ($t7)
	syscall
	
	li $v0, 4
	la $a0, vic2
	syscall
	
	j musical 

# if the player loses, display the secret word and play loser sound
defeat:
	li $v0, 4
	la $a0, loser
	syscall
	
	li $v0, 4
	la $a0, loser2
	syscall
	
	lw $t0, winword
	la $a0, words($t0)
	li $v0, 4
	syscall

	
	jal lose
	j musical
# Background music
musical:
	jal pause2
	jal pause2
	jal pause2
	li $v0, 4
	la $a0, music
	syscall
	jal song
	jal song
	j exit
validcheck:
	jal valid
	jal pause3
	jal invalid

	jr $ra

# sound played if player wins
victory:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra

jal note1
jal pause
jal note2
jal pause
jal note3

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

# sound played if player inputs invalid guess
invalid:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra

jal note4
jal pause
jal note5

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer

jr $ra

valid:

addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra

jal note5
jal pause
jal note4

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer

jr $ra
# Sound played if player loses
lose:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra

jal note6
jal pause2
jal note7
jal pause2
jal note8

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer

jr $ra

# Sounds played throughout the game
s1:

addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra

jal note70
jal note65
jal n70
jal n70
jal note60
jal n65
jal n65
jal note55
jal note70
jal pause
lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

s2:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
jal note70
jal note65
jal n70
jal n70
jal note60
jal note65
jal note55
jal note50

jal pause

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

s3:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
jal note70
jal note65
jal n70
jal n70
jal note60
jal note65
jal note55
jal note70
jal pause

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

s4:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
jal n70
jal n65
jal n70
jal n75
jal n80
jal n80
jal note50
jal pause
jal n50
jal n55
jal pause
jal n55
jal n60
jal pause
jal n60
jal n65
jal pause
jal n65
jal n65
jal n65
jal pause

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

song:

addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra

jal note70
jal note65
jal n70
jal n70
jal note60
jal n65
jal n65
jal note55
jal note70

jal pause
jal note70
jal note65
jal n70
jal n70
jal note60
jal note65
jal note55
jal note50

jal pause

jal note70
jal note65
jal n70
jal n70
jal note60
jal note65
jal note55
jal note70
jal pause

jal n70
jal n65
jal n70
jal n75
jal n80
jal n80
jal note50
jal pause

jal n50
jal n55

jal pause
jal n55
jal n60

jal pause
jal n60
jal n65

jal pause

jal n65

#j song #used to loop for now, makes program never ending, will remove


lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

pause:
li $v0, 32
li $a0, 500
syscall
jr $ra

pause2:
li $v0, 32
li $a0, 750
syscall
jr $ra

pause3:
li $v0, 32
li $a0, 250
syscall
jr $ra

note2:
li $v0, 31

la $a0, 70
addi $t2,$a0,12
la $a1, 700

li $a2, 35
li $a3, 100 #volume
move $t2,$a0
move $t3,$a1

syscall
jr $ra

note3:
li $v0, 31

la $a0, 75
addi $t2,$a0,12
la $a1, 750

li $a2, 35
li $a3, 100 #volume
move $t2,$a0
move $t3,$a1

syscall
jr $ra

note1:
li $v0, 31

la $a0, 75
addi $t2,$a0,12
la $a1, 500

li $a2, 35
li $a3, 100 #volume
move $t2,$a0
move $t3,$a1

syscall
jr $ra

note4:
li $v0, 31

la $a0, 50
addi $t2,$a0,12
la $a1, 1000

li $a2, 10
li $a3, 100 #volume
move $t2,$a0
move $t3,$a1

syscall
jr $ra

note5:
li $v0, 31

la $a0, 43
addi $t2,$a0,12
la $a1, 1000

li $a2, 10
li $a3, 100 #volume
move $t2,$a0
move $t3,$a1

syscall
jr $ra


note6:
li $v0, 31

la $a0, 47
addi $t2,$a0,12
la $a1, 1000

li $a2, 1
li $a3, 100 #volume
move $t2,$a0
move $t3,$a1

syscall
jr $ra

note7:
li $v0, 31

la $a0, 44
addi $t2,$a0,12
la $a1, 1000

li $a2, 1
li $a3, 100 #volume
move $t2,$a0
move $t3,$a1

syscall
jr $ra

note8:
li $v0, 31

la $a0, 41
addi $t2,$a0,12
la $a1, 1750

li $a2, 1
li $a3, 100 #volume
move $t2,$a0
move $t3,$a1

syscall
jr $ra


note70:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 70
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

note75:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 75
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

note65:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 65
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

note60:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 60
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

note55:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 55
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

note50:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 50
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

note80:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 80
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra


n70:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 70
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause3

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

n75:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 75
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause3

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

n65:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 65
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause3

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

n60:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 60
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause3

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

n55:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 55
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause3

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

n50:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 50
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause3

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

n80:
addi    $sp,$sp,-12             # make room on stack
sw      $ra,8($sp)              # save ra
li $v0, 31

la $a0, 80
addi $t2,$a0,12
la $a1, 700

li $a2, 45
li $a3, 50 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause3

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra

exit:
