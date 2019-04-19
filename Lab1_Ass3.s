	.data

	.global _start
	.text
START:
	call read_KEY0		# subroutine read_KEY0 is called
	br START		# check for the key pressed again
	
endloop:
	br endloop		# that's it
	.end

read_KEY0:
	movia r2, 0x840		# r2 <- 0x840
	ldw r3, (r2)		# r3 <- (0x840)
	andi r9, r3, 0x1	# r9 <- masked value of (0x840)
	ret
	

