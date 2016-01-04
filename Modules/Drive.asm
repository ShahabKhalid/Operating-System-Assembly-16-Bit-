
;--------------------Reading Sector MOdule-----------------
ReadSector: 
    mov ah,0x02
    mov cx,0x05
    ReadSector.L:
        push cx
        mov al,[_SectorsToRead]
        mov ch,0x00
        mov dh,0x00
        mov cl,[_Sectors]
        int 0x13
        jnc ReadSector.ReadSectorDone
        pop cx
        loop ReadSector.L

    jmp ReadSector.Error

    ReadSector.ReadSectorDone:
        pop cx
        cmp dh,al
        mov si,_SRS
        mov bl,0x0f
        ;call cPrintString            
        jmp ReadSector.EndRad

    ReadSector.Error:
        mov bl,0x0f
        mov si,_SecReadError
        call cPrintString
        mov al,ah
        cmp al,0x09
        je yes
        jmp no
        yes:
            mov ah,0x09
            int 10h
        no:

    ReadSector.EndRad:
        ret
;----------------End Reading Sector MOdule--------------------

;--------------------Variables--------------------------------
_SRS             db  "[SRM] Sector Read Done!",0
_SecReadError    db "[SRM] Error While Reading Sector!",0
_Sectors         db  0x00
_SectorsToRead   db  0x00
;-------------------------------------------------------------