# sample file for sounds
#a0 holds pitch, can hold values 0-127
#a1 holds the time in durations in miliseconds 
#a2 holds the instrument, valuses 0-127
#a3 holds the volume, values 0-127
# http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html

.data

.text

main:
	jal victory #victory noise
	jal pause2

	jal invalid #invalid input noise

	jal pause2
	jal valid #valid input noise
	jal pause2
	jal lose #sound will play when you lose
	jal pause2
	jal song
	jal song
	j exit

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

pause3:
li $v0, 32
li $a0, 250
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
li $a3, 100 #volume
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
li $a3, 100 #volume
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
li $a3, 100 #volume
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
li $a3, 100 #volume
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
li $a3, 100 #volume
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
li $a3, 100 #volume
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
li $a3, 100 #volume
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
li $a3, 100 #volume
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
li $a3, 100 #volume
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
li $a3, 100 #volume
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
li $a3, 100 #volume
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
li $a3, 100 #volume
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
li $a3, 100 #volume
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
li $a3, 100 #volume
move $t2,$a0
move $t3,$a1

syscall

jal pause3

lw $ra,8($sp) # restore $ra
addi $sp,$sp,12  # restore stack pointer
jr $ra
exit:
