;-------------------Print Module------------------
 PrintString:
    lodsb
    cmp al,0h
    je Done
    
    mov ah,0x0e
    int 10h
    
    jmp PrintString
    
Done:
    ret
;-----------------End Pirnt Module------------------