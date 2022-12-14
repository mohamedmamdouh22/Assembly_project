data segment
    len equ $-msg
data ends
code segment
    assume cs:code, ds:data
    main proc far
        mov ax, data
        mov ds, ax
        mov cx, len
        mov ah, 2
        mov bx, offset msg
        a:
            mov dl, [bx]
            int 21h
            inc bx
        loop a
        mov ah, 4ch
        int 21h
    main endp
code ends
end main