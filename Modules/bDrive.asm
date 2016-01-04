
;--------------------Reading Sector MOdule-----------------
ReadSector: 
    mov ah,0x02
    push dx
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
        pop dx
        cmp dh,al
        mov si,_SRS
        call PrintString            
        jmp ReadSector.EndRad

    ReadSector.Error:
        mov si,_SecReadError
        call PrintString

    ReadSector.EndRad:
        ret
;----------------End Reading Sector MOdule--------------------







;--------------------Variables--------------------------------
_SRS             db  "[SRM] Sector Read Done!",0x0d,0x0a,0
_SecReadError   db   "[SRM] Error While Reading Sector!",0x0d,0x0a,0
;-------------------------------------------------------------