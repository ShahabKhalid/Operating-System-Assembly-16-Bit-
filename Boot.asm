;-----------------------------------------------------

;                   WaaS Boot Loader v1.0

;                   ====Written By=====
;                   #  Shahab Khalid  #
;                   #   Abdul Wakeel  #
;                   ===================

;-----------------------------------------------------


;------------------------------------------------------
[BITS 16]           ;Code is 16 Bits
[ORG 0x7c00]        ;Code will be saved at 0x7x00 in memory by bios
;------------------------------------------------------
mov [BOOT_DRIVE],dl ;Saving Boot Drive
mov bp,0xf000       ;Base/Start For Stack 
mov sp,bp           ;Stack Current Pointing to Base/Start




;Printing Boot Load Message
mov si,_BootLoad    
call PrintString    

mov cx,1000
mov ax,500
d:
	push cx
	mov cx,ax
	d1:
		dec ax
		loop d1
		pop cx
	loop d


;Printing Disk Sector Read Message
mov si,_LoadKernel
call PrintString  



mov cx,1000
mov ax,500
delay:
	push cx
	mov cx,ax
	delay1:
		dec ax
		loop delay1
		pop cx
	loop delay




mov bx,0x1000   ;Address [es:bx] to write sector in memory
mov dh,0x05
mov [_SectorsToRead],dh     ;Sectors To Read
mov dh,0x02
mov [_Sectors],dh     ;Sector
call   ReadSector


mov dl,[BOOT_DRIVE]
jmp 0x1000      ;Load Kernel


cli 
hlt


;-----------------------INCLUDES------------------------
%include       "Modules/bDrive.asm"
%include       "Modules/PrintString.asm"
%include       "Modules/StringToInt.asm"
%include       "Modules/IntToString.asm"
;-------------------------------------------------------




;----------------------Declaring Vars----------------
_BootLoad   		db  "[Boot] WaaS Boot Loader v1.0 Started!",0x0d,0x0a,0
_LoadKernel 		db  "[Boot] Reading Disk Sector for Kernel!",0x0d,0x0a,0
_Sectors            db  0x00
_SectorsToRead      db  0x00
BOOT_DRIVE 			db 	0
;----------------------------------------------------


times 510-($-$$) db 0   ;Filling Free Space 
dw 0xAA55               ;Last Part to Sector, That make in Bootable