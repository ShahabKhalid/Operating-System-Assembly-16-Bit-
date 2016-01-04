;------------------------------------------------------
[BITS 16]
[ORG 0x5000]
;------------------------------------------------------
section .bss
_cWord		resb	20
;------------------------------------------------------
section .text



mov al,0xbb
call ClearScreen

mov dh,0
mov dl,1
mov bl,0xf0
mov si,_Title
call cPrintString

NextLevel:

mov dl,10
mov dh,3
mov cx,35
mov bh,18
mov bl,0x33
call OS_Box

mov dl,12
mov dh,4
mov bl,0x30
mov si,_Ques
call cPrintString

mov dl,12
mov dh,5
mov si,_Ques1
call cPrintString



mov dl,22
mov dh,10
lea si,[_C1]
push dx
mov dl,[_wordCount]
call getWorld
pop dx
mov [_cWord],si
mov si,[_cWord]
;call cPrintString
call CountLength
mov [_wLength],cl
mov BYTE [_gwLength],0
mov al,'_'
lop:
	cmp cl,0
	je __End
	call cPrintChar
	dec cl
	inc dl
	jmp lop

__End:

mov dl,12
mov dh,15
mov bl,0x34
mov si,_Note
call cPrintString


mov dl,16
mov dh,16
mov bl,0x30
mov si,_NoteMsg
call cPrintString


mov dl,16
mov dh,17
mov bl,0x30
mov si,_NoteMsg1
call cPrintString


mov dl,35
mov dh,22
mov bl,0xb0
mov si,_Scores
call cPrintString


mov dl,45
mov dh,22
mov bl,0xb0
mov si,_Score
call cPrintString



mov dl,50
mov dh,3
mov cx,20
mov bh,18
mov bl,0x33
call OS_Box




;---------------Drawing HangMan-------------------------

mov dl,55
mov dh,19
mov bl,0x30
mov al,'_'
call cPrintChar
inc dl
call cPrintChar
inc dl
call cPrintChar
inc dl
call cPrintChar
inc dl
call cPrintChar
inc dl
call cPrintChar
inc dl
call cPrintChar
inc dl
call cPrintChar
inc dl
call cPrintChar
inc dl
call cPrintChar

inc dl
mov al,'|'
call cPrintChar
dec dh
call cPrintChar
dec dh
call cPrintChar
dec dh
call cPrintChar
dec dh
call cPrintChar
dec dh
call cPrintChar
dec dh
call cPrintChar
dec dh
call cPrintChar
dec dh
call cPrintChar
dec dh
call cPrintChar
dec dh
call cPrintChar
dec dh
call cPrintChar
dec dh
call cPrintChar
dec dh
call cPrintChar
dec dh
call cPrintChar

dec dh
dec dl
mov al,'_'
call cPrintChar
dec dl
call cPrintChar
dec dl
call cPrintChar
dec dl
call cPrintChar
dec dl
call cPrintChar

mov [_manPosRow],dh
mov [_manPosCol],dl

;-------------------------------------------------------




KeyEvent:
	xor ah,ah
	int 16h

	cmp ah,1 	;Escape
	je Back

	mov si,[_cWord]
	mov bl,al
	call getCharPos

	cmp cl,1
	je KeyEvent.Current

	jmp KeyEvent.Wrong

	KeyEvent.Current:

		mov dl,22
		add dl,ch
		mov dh,10

		push ax
		call cReadChar
		pop bx
		cmp al,bl
		je dontCount

		push ax
		mov ax,[_gwLength]
		inc ax
		mov [_gwLength],ax
		pop ax

		dontCount:
		mov ax,bx
		mov bl,0x30
		call cPrintChar

		push ax 
		mov al,[_wLength]
		mov ah,[_gwLength]
		cmp al,ah
		je KeyEvent.Comp

		jmp KeyEvent.None

		KeyEvent.Comp:
		mov ax,[_wordCount]
		inc ax
		mov [_wordCount],ax


		mov dx,[_Score]
		inc dx
		mov [_Score],dx

		pop ax
		jmp NextLevel

	KeyEvent.Wrong:
		add BYTE [_mistakes],1
		call HangMan

	KeyEvent.None:
		pop ax

	jmp KeyEvent



Back:
	mov esi,0x1000
	add esi,512
	jmp esi


EndGame:

mov dl,25
mov dh,8
mov cx,30
mov bh,5
mov bl,0x77
call OS_Box


mov dl,35
mov dh,9
mov bl,0x74
mov si,_GameEnd
call cPrintString


cli 
hlt


;-------------------Inner Modules-----------------------

getCharPos:
	;bl have char
	;si have string
	;cl return true/false
	;ch return position[index] in string
	push ax
	xor cx,cx
	getCharPos.lop:
		lodsb
		cmp al,bl		
		je getCharPos.Found
		inc ch
		cmp al,0
		jne getCharPos.lop

	jmp getCharPos.NotFound

getCharPos.Found:
	mov cl,1
	jmp getCharPos.End

getCharPos.NotFound:
	mov cl,0

getCharPos.End:
	pop ax
	ret



getWorld:
	;dl have word's index
	;si have word
	push dx
	xor dh,dh



	getWorld.lop:
		cmp dl,dh
		je getWorld.End

		lodsb
		cmp al,0x00
		jne getWorld.NoNewWorld

		inc dh

		getWorld.NoNewWorld:
			jmp getWorld.lop


	getWorld.End:
		pop dx
		ret


HangMan:
	pusha
	mov bl,0x30

	mov dh,[_manPosRow]
	mov dl,[_manPosCol]


	cmp BYTE [_mistakes],1
	je HangMan.Step1

	cmp BYTE [_mistakes],2
	je HangMan.Step2

	cmp BYTE [_mistakes],3
	je HangMan.Step3

	cmp BYTE [_mistakes],4
	je HangMan.Step4

	cmp BYTE [_mistakes],4
	je HangMan.Step4

	cmp BYTE [_mistakes],5
	je HangMan.Step5

	cmp BYTE [_mistakes],6
	je HangMan.Step6

	cmp BYTE [_mistakes],7
	je HangMan.Step7

	cmp BYTE [_mistakes],8
	je HangMan.Step8

	jmp HangMan.EndGame

	HangMan.Step1:
		mov al,'|'
		inc dh
		dec dl
		call cPrintChar
		jmp HangMan.End


	HangMan.Step2:
		inc dh
		mov al,'O'
		call cPrintChar
		jmp HangMan.End

	HangMan.Step3:
		inc dh
		dec dl
		mov al,'/'
		call cPrintChar
		jmp HangMan.End

	HangMan.Step4:
		inc dl
		mov al,'|'
		call cPrintChar
		jmp HangMan.End

	HangMan.Step5:
		inc dl
		mov al,'\'
		call cPrintChar
		jmp HangMan.End

	HangMan.Step6:
		dec dl
		inc dh
		mov al,'|'
		call cPrintChar
		jmp HangMan.End

	HangMan.Step7:
		inc dh
		dec dl
		mov al,'/'
		call cPrintChar
		jmp HangMan.End

	HangMan.Step8:
		inc dl
		inc dl
		mov al,'\'
		call cPrintChar
		jmp HangMan.End

	HangMan.EndGame:
		popa
		jmp EndGame

	HangMan.End:

	mov [_manPosRow],dh
	mov [_manPosCol],dl

	popa
	ret

;-------------------------------------------------------


;-----------------------INCLUDES------------------------
%include       "Modules/cPrintString.asm"
%include       "Modules/ClearScreen.asm"
%include       "Modules/OS_Box.asm"
%include       "Modules/cPrintChar.asm"
%include       "Modules/cReadChar.asm"
%include       "Modules/CountLength.asm"
%include       "Modules/StringToInt.asm"
%include       "Modules/IntToString.asm"
;-------------------------------------------------------



;----------------------Declaring Vars----------------
_Title					db 				"HangMan",0
_Ques					db 				"Guess the Word name according",0
_Ques1					db 				"to the blanks given!",0
_Note					db      		"Note:",0
_NoteMsg				db				"All aplhabets must be small",0
_NoteMsg1				db				"i.e Caps Lock Off!",0
_GameEnd				db				"Game Over!",0
_Scores					db				"Scores : ",0
_Score 					db				12
_wLength				db				0
_gwLength				db				0
_wordCount				db				0
_mistakes				db				0
_manPosCol				db				0
_manPosRow				db				0
_C1						db				"oxygen",0
						db	    		"car",0
						db	    		"plane",0
						db	    		"flat",0
						db	    		"nepal",0
						db	    		"water",0
						db	    		"gas",0
						db	    		"mobile",0
						db	    		"pine",0
						db	    		"regular",0
						db	    		"new",0
						db	    		"safe",0
						db	    		"hour",0
;----------------------------------------------------


times 1536 - ($ - $$) db 0