;---------------------------------------------------------
section .bss
_intstr	resb	10
;---------------------------------------------------------


section .text


_tot db	"Hi",0x0a,0x0d,0

IntToString:
	;dx have int
	;si will have str
	;bx counting string index

	push dx
	call CountDigits
	pop dx
	xor bx,bx
	mov ax,dx

	mov bl,10
	dec cx
	call Power

	xor cx,cx
	lea si,[_intstr]

	IntToString.lop:

		div bl


		add si,cx
		add al,'0'
		mov BYTE [si],al

		cmp ah,10
		jb IntToString.End

		mov al,ah
		xor ah,ah
		inc cx
		jmp IntToString.lop



	IntToString.End:
		inc cx
		add si,cx
		add ah,'0'
		mov BYTE [si],ah
		lea si,[_intstr]
		ret

;--------------------------------------------------------
%include 		"Modules/CountDigits.asm"
%include 		"Modules/Power.asm"
;--------------------------------------------------------

