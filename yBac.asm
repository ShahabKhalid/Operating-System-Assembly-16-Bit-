;------------------------------------------------------
[BITS 16]
[ORG 0x5000]
;------------------------------------------------------
section .bss
_result     resb    10
;------------------------------------------------------
section .text
mov al,0xbb
call ClearScreen


mov dl,20
mov dh,4
mov cx,35
mov bh,18
mov bl,0x44
call OS_DBox


;Input Field
mov dl,22
mov dh,6
mov cx,31
mov bh,2
mov bl,0xff
call OS_Box

mov dh,4
mov dl,21
mov bl,0x0f
mov si,_Title
call cPrintString

;7 Num
mov dl,22
mov dh,10
mov cx,5
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
mov si,_7
mov bl,0x0f
call cPrintString

;8 Num
mov dl,28
mov dh,10
mov cx,5
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
mov si,_8
mov bl,0x0f
call cPrintString


mov dl,34
mov dh,10
mov cx,5
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
mov si,_9
mov bl,0x0f
call cPrintString


mov dl,22
mov dh,13
mov cx,5
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
mov si,_4
mov bl,0x0f
call cPrintString



mov dl,28
mov dh,13
mov cx,5
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
mov si,_5
mov bl,0x0f
call cPrintString


mov dl,34
mov dh,13
mov cx,5
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
mov si,_6
mov bl,0x0f
call cPrintString




mov dl,22
mov dh,16
mov cx,5
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
mov si,_1
mov bl,0x0f
call cPrintString



mov dl,28
mov dh,16
mov cx,5
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
mov si,_2
mov bl,0x0f
call cPrintString


mov dl,34
mov dh,16
mov cx,5
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
mov si,_3
mov bl,0x0f
call cPrintString



mov dl,22
mov dh,19
mov cx,5
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
mov si,_.
mov bl,0x0f
call cPrintString



mov dl,28
mov dh,19
mov cx,5
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
mov si,_0
mov bl,0x0f
call cPrintString


mov dl,34
mov dh,19
mov cx,5
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
mov si,_fac
mov bl,0x0f
call cPrintString



;Clear Button
mov dl,40
mov dh,10
mov cx,13
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
add dl,3
mov si,_clr
mov bl,0x0f
call cPrintString


;Multiply Btn
mov dl,40
mov dh,13
mov cx,6
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
inc dl
mov si,_mul
mov bl,0x0f
call cPrintString

;Divide Btn
mov dl,47
mov dh,13
mov cx,6
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
inc dl
mov si,_div
mov bl,0x0f
call cPrintString

;Plus Btn
mov dl,40
mov dh,16
mov cx,6
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
inc dl
mov si,_add
mov bl,0x0f
call cPrintString

;Sub Btn
mov dl,47
mov dh,16
mov cx,6
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
inc dl
mov si,_sub
mov bl,0x0f
call cPrintString

;Equal Button
mov dl,40
mov dh,19
mov cx,13
mov bh,2
mov bl,0x00
push dx
call OS_Box
pop dx
inc dh
add dl,4
mov si,_equ
mov bl,0x0f
call cPrintString


mov dl,23
mov dh,6


KeyEvent:
	
	mov ah,0x02
	int 13h
	push dx

	xor ah,ah
	int 16h

	cmp ah,1 	;Escape
	je Back

	mov bl,0xf0
	call cPrintChar
	

	pop dx
	inc dl
	jmp KeyEvent


BackSpace:
	dec dl
	mov ah,0x02
	int 10h

	mov al,' '
	mov ah,0x09
	int 10h
	jmp KeyEvent




Back:
	mov esi,0x1000
	add esi,512
	jmp esi




cli 
hlt


;-----------------------INCLUDES------------------------
%include       "Modules/cPrintString.asm"
%include       "Modules/cPrintChar.asm"
%include       "Modules/OS_DBox.asm"
%include       "Modules/OS_Box.asm"
%include       "Modules/ClearScreen.asm"
;-------------------------------------------------------


;----------------------Declaring Vars----------------
_Title		db 		"BAC",0
_9			db 		" 9 ",0
_8			db 		" 8 ",0
_7			db 		" 7 ",0
_6			db 		" 6 ",0
_5			db 		" 5 ",0
_4			db 		" 4 ",0
_3			db 		" 3 ",0
_2			db 		" 2 ",0
_1			db 		" 1 ",0
_0			db 		" 0 ",0
_.			db 		" . ",0
_fac		db 		" ! ",0
_clr		db 		" Clr ",0
_mul		db 		"x ",0
_div		db 		" / ",0
_add		db 		"+ ",0
_sub		db 		" - ",0
_equ		db 		" = ",0
_test 		db 		"123E"
_testi		db      9
;----------------------------------------------------


times 1024 - ($ - $$) db 0