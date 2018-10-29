# sample file for sounds
#a0 holds pitch, can hold values 0-127
#a1 holds the time in durations in miliseconds 
#a2 holds the instrument, valuses 0-127
#a3 holds the volume, values 0-127
# http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html
.data
beep: .byte 127

.text
li $v0, 31

la $a0, beep
lw $a0 0($a0) #as far as I can tell, 0 and 4 have different sounds, 4+ all has same noise as 4
addi $t2,$a0,12
la $a1, 10000000

li $a2, 10
li $a3, 100 #volume
move $t2,$a0
move $t3,$a1
syscall
li $v0, 32
li $a0, 1000
syscall

li $v0, 31

la $a0, beep
lw $a0 0($a0) #as far as I can tell, 0 and 4 have different sounds, 4+ all has same noise as 4
addi $t2,$a0,12
la $a1, 10000

li $a2, 10
li $a3, 100 #volume
move $t2,$a0
move $t3,$a1

syscall
