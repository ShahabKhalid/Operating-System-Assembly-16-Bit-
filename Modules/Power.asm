Power:
	push ax
	mov al,1

	Power.Lop:
		mul bl
		dec cx
		cmp cx,0
		je Power.End
		jmp Power.Lop

	Power.End:
		mov bl,al
		pop ax
		ret
