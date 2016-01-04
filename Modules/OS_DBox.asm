;---------------------OS Dialod Box---------------------------
OS_DBox:
    pusha

    push bx
    mov bh,0
    mov ah,0x02
    int 10h

    mov al,' '
    mov bl,0x00
    mov ah,0x09
    int 10h
    inc dh


    pop bx

    OS_DBox.Loop:
        push bx
        mov bh,0
        mov ah,0x02
        int 10h

        mov al,' '        
        mov ah,0x09
        int 10h
    
        pop bx
        dec bh
        inc dh
        cmp bh,0
        jne OS_DBox.Loop


    popa
    ret
;-------------------------------------------------------------