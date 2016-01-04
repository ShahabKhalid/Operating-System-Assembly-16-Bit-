;---------------------OS  Box---------------------------



OS_Box:
    pusha

    OS_Box.Loop:
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
        jne OS_Box.Loop


    popa
    ret
;-------------------------------------------------------------