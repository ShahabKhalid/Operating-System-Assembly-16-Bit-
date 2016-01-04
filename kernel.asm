;-----------------------------------------------------

;                   WaaS Kernel    v1.0

;                   ====Written By=====
;                   #  Shahab Khalid  #
;                   #   Abdul Wakeel  #
;                   ===================

;-----------------------------------------------------


;------------------------------------------------------
[bits	16]
[org	0x1000]
;------------------------------------------------------

mov [BOOT_DRIVE],dl ;Saving Boot Drive



mov si,scrMsg
call PrintString

mov cx,5000
mov ax,4000
delay:
	push cx
	mov cx,ax
	delay1:
		dec ax
		loop delay1
		pop cx
	loop delay

mov al,0xbb 	;BGcolor
call ClearScreen

mov dl,20
mov dh,8
mov cx,35
mov bh,10
mov bl,0x33
call OS_DBox



mov dh,8
mov dl,20
mov bl,0x03
mov si,_Welcome
call cPrintString


mov dh,10
mov dl,20
mov bl,0x3f
mov si,_wcMsg1
call cPrintString

mov dh,11
mov dl,20
mov bl,0x3f
mov si,_wcMsg2
call cPrintString

mov dh,13
mov dl,24
mov bl,0x30
mov si,_wcMsg3
call cPrintString

mov dh,14
mov dl,28
mov bl,0x34
mov si,_wcMsg4
call cPrintString

mov dh,15
mov dl,28
mov si,_wcMsg5
call cPrintString

jmp Part2



;-----------------------INCLUDES------------------------
%include       "Modules/Drive.asm"
%include       "Modules/cPrintString.asm"
%include       "Modules/PrintString.asm"
%include       "Modules/OS_DBox.asm"
%include       "Modules/ClearScreen.asm"
;-------------------------------------------------------




;----------------------Declaring Vars----------------
_Welcome 		db "Welcome to WaaS-OS vI!",0
_wcMsg1			db "Thank you User for Switching to",0
_wcMsg2			db "WaaS-OS vI!",0
_wcMsg3			db "Writters:",0
_wcMsg4			db "Shahab Khalid",0
_wcMsg5			db "Abdul Wakeel",0
scrMsg db " x              x                         ,XXX,  ",0x0d,0x0a
	   db "XXX	          XXX                       XX   XX ",0x0d,0x0a
       db "XXX	   XXX    XXX       X        X      XXX     ",0x0d,0x0a
	   db "XXX   XX  XX   XXX    X   X    X   X       XXX   ",0x0d,0x0a
	   db "XXX  XX    XX  XXX   XX   XX  XX   XX        XX  ",0x0d,0x0a
	   db "XXX X        X XXX   XXXXXXX  XXXXXXX   XX   XX  ",0x0d,0x0a
	   db "XXX            XXX   XX   XX  XX   XX    'XXX'   ",0x0d,0x0a
	   db " ",0
BOOT_DRIVE 		db 0
;----------------------------------------------------




Part2:
mov dh,17
mov dl,32
mov bl,0x0f
mov si,_b_Cont
call cPrintString



;Wait For Enter To Continue
PressEnter:
	mov ah,00h
	int 16h
	cmp ah,28
	jne PressEnter

times 1024 - ($ - $$) db 0

mov al,0xbb 	;BGcolor
call ClearScreen


mov dl,20
mov dh,2
mov cx,35
mov bh,20
mov bl,0x33
call OS_DBox


mov dh,2
mov dl,20
mov bl,0x03
mov si,_Menu
call cPrintString


mov ah,0ch
int 10h

;%ifdef	COMMENT
call WriteMenu

KeyEvent:
	mov ah,00h
	int 16h

	cmp ah,50h
	je dRWM

	cmp ah,48h
	je uRWM

	cmp ah,0x1c
	je InitLoadApp

	jmp None

	dRWM:
		mov al,[_mSelected]
		cmp al,4
		jb movD
		jmp None
		movD:
			inc al
			mov [_mSelected],al
		call WriteMenu
		jmp None

	uRWM:
		mov al,[_mSelected]
		cmp al,1
		ja movU
		jmp None
		movU:
			dec al
			mov [_mSelected],al
		call WriteMenu

	None:
		jmp KeyEvent


InitLoadApp:
	mov al,[_mSelected]
	cmp al,0x01			;TextEditor
	je InitTE

	cmp al,0x02			;BAC
	je InitBAC

	cmp al,0x03			;TS
	je InitTS


	cmp al,0x04			;HM
	je InitHM

	jmp KeyEvent

	InitTE:		
		mov dh,[_TextEditor_TotSecs]
		mov [_SectorsToRead],dh     ;Sectors To Read
		mov dh,[_TextEditor_Sec]
		mov [_Sectors],dh     		;Sector
		jmp LoadApp


	InitBAC:		
		mov dh,[_Calculator_TotSecs]
		mov [_SectorsToRead],dh     ;Sectors To Read
		mov dh,[_Calculator_Sec]
		mov [_Sectors],dh     		;Sector
		jmp LoadApp

	InitTS:		
		mov dh,[_TS_TotSecs]
		mov [_SectorsToRead],dh     ;Sectors To Read
		mov dh,[_TS_Sec]
		mov [_Sectors],dh     		;Sector
		jmp LoadApp

	InitHM:		
		mov dh,[_HM_TotSecs]
		mov [_SectorsToRead],dh     ;Sectors To Read
		mov dh,[_HM_Sec]
		mov [_Sectors],dh     		;Sector

LoadApp:
	mov dl,[BOOT_DRIVE]
	mov bx,0x5000				;Memory Addr to Tmp load App Sector	
	call   ReadSector


	jmp 0x5000

;%endif

cli
hlt

WriteMenu:
	pusha
	mov bl,0x3f

	mov al,[_mSelected]
	cmp al,0x01
	je s1
	jmp _s1
	s1:
		mov bl,0x0f

	_s1:
		mov dh,4
		mov dl,30
		mov si,_TextEditor
		call cPrintString

	mov bl,0x3f

	mov al,[_mSelected]
	cmp al,0x02
	je s2
	jmp _s2
	s2:
		mov bl,0x0f

	_s2:
		mov dh,5
		mov dl,30
		mov si,_Calculator
		call cPrintString

	mov bl,0x3f

	mov al,[_mSelected]
	cmp al,0x03
	je s3
	jmp _s3
	s3:
		mov bl,0x0f

	_s3:
		mov dh,6
		mov dl,30
		mov si,_TS
		call cPrintString


	mov bl,0x3f

	mov al,[_mSelected]
	cmp al,0x04
	je s4
	jmp _s4
	s4:
		mov bl,0x0f

	_s4:
		mov dh,7
		mov dl,30
		mov si,_HM
		call cPrintString
	popa
	ret





;----------------------------------------------------
_b_Cont				db "Continue",0
_Menu				db "Desktop",0
_mSelected			db 0x01

_TextEditor			db " Text Editor ",0
_TextEditor_Sec   	db 0x06
_TextEditor_TotSecs db 0x01

_Calculator			db " BAC ",0
_Calculator_Sec		db 0x07
_Calculator_TotSecs	db 0x02

_TS 				db " Typing Game ",0
_TS_Sec				db 0x09
_TS_TotSecs			db 0x02

_HM 				db " Hangman ",0
_HM_Sec				db 0x0b
_HM_TotSecs			db 0x03
;----------------------------------------------------

times 1536 - ($ - $$) db 0