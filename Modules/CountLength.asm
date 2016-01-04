CountLength:
	xor cl,cl	;cl = 0
	CountLength.lop:
		lodsb
		cmp al,0
		je CountLength.End

		inc cl

	jmp CountLength.lop

CountLength.End:
ret