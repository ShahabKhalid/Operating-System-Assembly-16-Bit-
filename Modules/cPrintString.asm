;-------------------PrintColor Module------------------
 cPrintString:
    ;pusha
    mov bh,0   ;page
    mov cx,1
    lodsb
    cmp al,0h
    je cDone
    
    inc dl
    mov ah,0x02
    int 10h

    mov ah,0x09
    int 10h
    jmp cPrintString
    
cDone:
    ;popa
    ret
;-----------------End PirntColor Module------------------
