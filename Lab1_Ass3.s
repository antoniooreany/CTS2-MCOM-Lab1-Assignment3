	.data

	.global _start
	.text
START:
	call read_KEY0		# subroutine read_KEY0 is called
	call read_KEY3		# subroutine read_KEY3 is called
	br START		# check for the key pressed again
	
endloop:
	br endloop		# that's it
	.end

read_KEY0:
	movia r2, 0x840		# r2 <- 0x840
	ldw r3, (r2)		# r3 <- (0x840)
	andi r9, r3, 0x1	# r9 <- masked value of (0x840)
	bne r9, r0, read_KEY0	# if r9!=0 => foto read_KEY0
	ret			# return
	
read_KEY3:
	movia r2, 0x840		# r2 <- 0x840
	ldw r3, (r2)		# r3 <- (0x840)
	andi r9, r3, 0x8	# r9 <- masked value of (0x840)
	bne r9, r0, read_KEY3	# if r9!=0 => foto read_KEY3
	ret			# return


	