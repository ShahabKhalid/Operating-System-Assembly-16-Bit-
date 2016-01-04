CountDigits:
	;dx hav int
	;cx will have count

	xor cx,cx
	push ax
	mov ax,dx
	mov dl,10
	CountDigits.lop:
		mov bx,ax
		div dl

		cmp bx,10
		jbe noIncrement

		inc cx

		noIncrement:

		cmp al,10
		jb CountDigits.End

		xor ah,ah
		jmp CountDigits.lop


	CountDigits.End:
		inc cx
		pop ax
		ret