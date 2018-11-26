
.data
words:		.asciiz	"alum","apex","axed","blip","bins","bine","bosh","bowl","dewy","diel","dims","dime","duce","dump","cure","foxy","evil","frat","fowl","gale","gaes",
"gamy","geds","hams","hail","hays","helm","idol","iron","jabs","jade","jean","jerk","join","kale","keys","knot","lace","lack","lark","lock","lube","mach","mash","meat","mile","mold","nods","norm","nose","oath","oily","oink",
"orca","owls","pelt","peas","pets","plan","ping","pong","rail","rain","read","rune","rush","scar","sank","sans","shot","ship","tick","tofu","toed","turf","ugly","unit","undo","verb","veil","vent","vain","wane","want","whoa",
"wife","worm","wrap","yelp","yolk","yogi","your","yoga","zero","zest","zinc","zing","zoos","zoom","worn"
guessWord:	.asciiz ""

.text
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