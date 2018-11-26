
.data
words:		.asciiz	"alum","apex","axed","blip","bins","bine","bosh","bowl","dewy","diel","dims","dime","duce","dump","cure","foxy","evil","frat","fowl","gale","gaes",
"gamy","geds","hams","hail","hays","helm","idol","iron","jabs","jade","jean","jerk","join","kale","keys","knot","lace","lack","lark","lock","lube","mach","mash","meat","mile","mold","nods","norm","nose","oath","oily","oink",
"orca","owls","pelt","peas","pets","plan","ping","pong","rail","rain","read","rune","rush","scar","sank","sans","shot","ship","tick","tofu","toed","turf","ugly","unit","undo","verb","veil","vent","vain","wane","want","whoa",
"wife","worm","wrap","yelp","yolk","yogi","your","yoga","zero","zest","zinc","zing","zoos","zoom","worn"
guessWord:	.asciiz ""
newln: .asciiz "\n"
mesg1: .asciiz "Welcome to Bulls and Cows!\n"
mesg2: .asciiz "In this game you will try to guess a four letter word in 10 guesses.\n"
mesg3: .asciiz "The word will not have two of the same letter, and will only contain alphabetic symbols.\n"
mesg4: .asciiz "Please enter your guess(or 0 to exit): "
inval: .asciiz "Invalid input.\n"
cows: .asciiz "Num Cows: "
bulls: .asciiz "Num Bulls: "
buffer: .space 20
winner: .asciiz "Congragulations you won!\n"
loser: .asciiz "You lose!\n"
music: .asciiz "Background music that we wanted to impliment"
.text
# $t0 holds the random genrated word, $t1 holds the input word
# $t7 is being used to hold the total count of the program 
main:
	# Get a random number between 0 and 3
	li $v0, 42 
	li $a1, 100 #word will load into $a0
	syscall
	
	# Multiply that number by 5 to get the offset from the start of the array
	mulu $t0, $a0, 5
	
	# Print a random word from the array using the random offset
	li $v0, 4
	la $a0, words($t0)
	syscall
	
	li $v0, 4
	la $a0, newln
	syscall
	#display game messages
	li $v0, 4
	la $a0, mesg1
	syscall
	
	li $v0, 4
	la $a0, mesg2
	syscall
	
	li $v0, 4
	la $a0, mesg3
	syscall
	
	add $t7, $zero, $zero #set value of counter to 0
	
game:
	#display message asking for input
	li $v0, 4
	la $a0, mesg4
	syscall
	
	li $v0, 8 #take in input
	la $a0, buffer
	li $a1, 20
	move $t1, $a0
	syscall

	#temporary, setting $t2 to 0 so program will run 
	add $t2, $zero, $zero
	#jal validcheck #check if valid input, will return 0 if they are the same 
	beqz $t2, cont
	
cont:	##get and display display number of cows and bulls
	#jal compfunc1
	#jal compfunc2
	add $t7, $t7, 1
	#beq bull, 4, win #if there are 4 bulls, then the person got all 4 letters correct
	
	#sub cow, cow, bull #cows-= buills
	
	li $v0, 4
	la $a0, cows
	syscall
	
	li $v0, 4
	la $a0, newln
	syscall
	
	li $v0, 4
	la $a0, bulls
	syscall
	
	li $v0, 4
	la $a0, newln
	syscall
	
	la $a0, buffer
	move $a0, $t1 #display the input word
	li $v0, 4
	syscall
	

	beq $t7, 10, defeat

	j game

win:
	li $v0, 4
	la $a0, winner
	syscall
	jal victory
	
	j musical 
	
defeat:
	li $v0, 4
	la $a0, loser
	syscall
	jal lose
	j musical

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
