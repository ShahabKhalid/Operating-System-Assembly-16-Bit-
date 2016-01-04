;------------------------------------------------------
[BITS 16]
[ORG 0x5000]
;------------------------------------------------------


mov al,0x00
call ClearScreen

mov dh,0
mov dl,1
mov bl,0xf0
mov si,_Title
call cPrintString

mov dh,24
mov dl,1
mov bl,0xf0
mov si,_cmdMSg
call cPrintString

mov dh,2
mov dl,1
mov ah,0x02
int 10h

mov bl,0x0f
mov ah,0x09
int 10h


KeyEvent:
	xor ah,ah
	int 16h

	cmp ah,1 	;Escape
	je Back

	cmp ah,14	;BackSpace
	je BackSpace

	cmp ah,28	;Enter
	je NewLine

	mov ah,0x09
	int 10h

	inc dl
	mov ah,0x02
	int 10h

	jmp KeyEvent


BackSpace:
	dec dl
	mov ah,0x02
	int 10h

	mov al,' '
	mov ah,0x09
	int 10h
	jmp KeyEvent


NewLine:
	inc dh
	mov dl,1
	mov ah,0x02
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
%include       "Modules/ClearScreen.asm"
;-------------------------------------------------------



;----------------------Declaring Vars----------------
_Title		db 		"Text Editor",0
_cmdMSg	    db 		"Esc - Exit | Clt + S - Save | Clt + N - New File",0
;----------------------------------------------------


times 512 - ($ - $$) db 0