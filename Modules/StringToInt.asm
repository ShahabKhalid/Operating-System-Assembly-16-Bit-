StringToInt:
	;si have string
	;dx return number
	xor dx,dx

	StringToInt.lop:
		lodsb
		cmp al,0
		je StringToInt.End

		sub al,'0'
		imul dx,10
		xor ah,ah
		cbw
		add dx,ax

		jmp StringToInt.lop



	StringToInt.End:
	ret