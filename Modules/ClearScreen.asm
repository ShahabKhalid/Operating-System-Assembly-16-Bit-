;---------------------Clear Screen----------------------------
ClearScreen:
    ;Top White Line
    ;Setting Cursor At Top
    push ax
    mov bh,0   ;page
    mov dh,0   ;row
    mov dl,0   ;coloum
    mov ah,0x02
    int 10h

    ;Drawing Top Border
    mov al,' '  ;char
    mov bl,0xff ;color
    mov cx,80   ;times to print
    mov ah,0x09
    int 10h


    ;Changing Rows
    pop ax
    mov dh,1
    Loop:
        mov ah,0x02
        int 10h

        ;Drawing BG
        mov ah,0x09
        mov bl,al
        int 10h
        inc dh
        cmp dh,25
        jne Loop

        push ax


    ;Drawing Bottom Border
    mov al,' '  ;char
    mov bl,0xff ;color
    mov ah,0x09
    int 10h

    mov dh,24
    mov dl,68
    mov bl,0xf0
    mov si,_WaaS_OS
    call cPrintString

    pop ax

    ret
;------------------END Clear Screen---------------------------


;--------------------Variables--------------------------------
_WaaS_OS         db "WaaS-OS vI",0
;-------------------------------------------------------------