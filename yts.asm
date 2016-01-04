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


mov dl,0
mov dh,14
mov cx,80
mov bh,1
mov bl,0xff
call OS_Box


mov dl,0
mov dh,15
mov cx,80
mov bh,9
mov bl,0x88
call OS_Box

mov dh,17
mov dl,32
mov bl,0x8f
mov si,_Scores
call cPrintString



GameLoop:
	call MovingChars
	jmp GameLoop

MovingChars:
		call KeyEvent
		mov cx,6h
		lop:
			mov di,cx
			dec di
			call MoveSChar
			Loop lop
		
		;Wait 1/2 sec
		pusha
		mov cx,00005
		mov dx,00000
		mov ah,86h
		int 15h
		popa

	ret


MoveSChar:
	lea si,[_posY + di]
	;add si,di
	mov dh,[si]
	lea si,[_posX + di]
	;add si,di
	mov dl,[si]
	mov bl,0x00 ;Black

	cmp dh,1
	jae Draw
	jmp NODraw
	Draw:
		cmp dh,13
		ja NODraw
		mov al,' '
		call cPrintChar

	NODraw:


	inc dh
	cmp dh,30 ;my negative val , hehe
	je doZero
	jmp noInc
	doZero:
		mov dh,0
	noInc:

		cmp dh,1
		jae Display
		jmp NODisplay
		Display:
			cmp dh,13
			ja NODisplay
			;Working Here
			push si
			push bx
			push cx
			lea si,[_Chars]
			mov bx,si
			lea si,[_Char + di]
			mov cl,[si]
			mov bl,[bx]
			add bl,cl
			mov al,bl
			pop cx
			pop bx
			pop si

			cmp al,[_readChar]
			je reSet_
			jmp noreSet_

			reSet_:
				mov BYTE [_readChar],0
				add BYTE [_Score],1

				pusha
				mov dh,17
				mov dl,42
				mov bl,0x8f
				mov al,[_Score]
				call cPrintChar
				popa

				jmp reSet

			noreSet_:
			mov bl,0x0f
			call cPrintChar

			

	NODisplay:
		cmp dh,14
		je GameOver
		jmp noreSet
		reSet:
			lea si,[_cposY + di]
			mov dh,[si]
			lea si,[_Char + di]
			add BYTE [si],1
			cmp BYTE [si],26
			jb NoreSetChar


			mov BYTE [si],0

			NoreSetChar:

		noreSet:
		lea si,[_posY + di]
		;add si,di
		mov [si],dh
		lea si,[_posX + di]
		;add si,di
		mov [si],dl

	ret


KeyEvent:
	mov ah,01h
	int 16h
	jz noKey

	xor ah,ah
	int 16h

	cmp ah,1 	;Escape
	je Back

	mov [_readChar],al

	noKey:

	ret



GameOver:
	mov dl,30
	mov dh,7
	mov cx,20
	mov bh,5
	mov bl,0x77
	call OS_Box


	mov dh,8
	mov dl,34
	mov bl,0x74
	mov si,_Over
	call cPrintString

	mov dh,10
	mov dl,32
	mov bl,0x70
	mov si,_Quit
	call cPrintString


	GO_Key:
	xor ah,ah
	int 16h

	cmp ah,1 	;Escape
	je Back
	jmp GO_Key

Back:
	mov esi,0x1000
	add esi,512
	jmp esi


;-----------------------INCLUDES------------------------
%include       "Modules/cPrintString.asm"
%include       "Modules/cPrintChar.asm"
%include       "Modules/OS_Box.asm"
%include       "Modules/ClearScreen.asm"
;-------------------------------------------------------



;----------------------Declaring Vars----------------
_Title		db 		"Typing Game",0
_Scores		db		"Scores : 0",0
_Over		db		"Game Over!",0
_Quit		db		"Escape to Quit!",0

_Chars		db		'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
__Char      db      0,1,2,3,4,5
_Char       db      0,1,2,3,4,5
_cposY		db		28,25,22,20,18,16
_posY		db		28,25,22,20,18,16
_posX		db		12,50,35,02,60,15
_readChar   db      0
_Score      db      0

;----------------------------------------------------

times 1024 - ($-$$)	db 0