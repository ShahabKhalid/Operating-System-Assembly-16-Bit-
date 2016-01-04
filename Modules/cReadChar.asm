cReadChar:
	
	push bx

	mov bh,0x00
	mov ah,0x02
	int 10h

	mov ah,0x08
	int 10h

	pop bx
	ret