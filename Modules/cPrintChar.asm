;-------------------PrintColor Char Module---------------
cPrintChar:
    pusha
    mov bh,0
    mov cx,1
    mov ah,0x02
    int 10h

    mov ah,0x09
    int 10h
    popa
    ret

;--------------------------------------------------------