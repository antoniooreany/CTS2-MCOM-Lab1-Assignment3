###############################################
# MCOM-Labor: Vorlage fuer Assemblerprogramm
# Edition History:
# 28-04-2009: Getting Started - ms
# 12-03-2014: Stack organization changed - ms
###############################################

###############################################
# Definition von symbolen Konstanten
###############################################
	.equ STACK_SIZE, 0x400	# stack size
###############################################
# DATA SECTION
# assumption: 12 kByte data section (0 - 0x2fff)
# stack is located in data section and starts
# directly behind used data items at address
# STACK_END.
# Stack is growing downwards. Stack size
# is given by STACK_SIZE. A full descending
# stack is used, accordingly first stack item
# is stored at address STACK_END+(STACKSIZE).
###############################################	
	.data
TST_PAK1:
	.word 0x11112222	# test data

STACK_END:
	.skip STACK_SIZE	# stack area filled with 0

###############################################
# TEXT SECTION
# Executable code follows
###############################################
	.global _start
	.text
_start:
	#######################################
	# stack setup:
	# HAVE Care: By default JNiosEmu sets stack pointer sp = 0x40000.
	# That stack is not used here, because SoPC does not support
	# such an address range. I. e. you should ignore the STACK
	# section in JNiosEmu's memory window.
	
	movia	sp, STACK_END		# load data section's start address
	addi	sp, sp, STACK_SIZE	# stack start position should
					# begin at end of section
START:
	call read_KEY0		# subroutine read_KEY0 is called
	call read_KEY3		# subroutine read_KEY3 is called
	br START		# check for the key pressed again

read_KEY0:
	movia r9, 0x840		# r9 <- 0x840
	ldw r9, (r9)		# r9 <- (0x840)
	andi r9, r9, 0x1	# r9 <- masked value of (0x840)
	bne r9, r0, read_KEY0	# if r9!=0 => foto read_KEY0. Professor: in real app it's redundant
	ret			# return

read_KEY3:
	movia r9, 0x840		# r9 <- 0x840
	ldw r9, (r9)		# r9 <- (0x840)
	andi r9, r9, 0x8	# r9 <- masked value of (0x840)
	bne r9, r0, read_KEY3	# if r9!=0 => foto read_KEY3. Professor: in real app it's redundant
	ret			# return

endloop:
	br endloop		# that's it
###############################################
	.end
	
