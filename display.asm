data segment
    msg2 db 0ah,0dh, 'name is $'
    len1 equ $-msg2
    msg3 db 0ah,0dh, 'number is $'
    len2 equ $-msg3
data ends
code segment
    assume cs:code,ds:data
    main proc far
        mov ax,data
        mov ds,ax
        mov cx,len1
        mov ah,2
        mov bx,offset msg2
        ;TO PRINT THE NAME
        a:
           mov dl,[bx]
           int 21h
           inc bx
        loop a
        mov cx,len2
        mov ah,2
        mov bx,offset msg3 
       
       ;TO PRINT THE NUMBER
        b:
           mov dl,[bx]
           int 21h
           inc bx
        loop b
        mov ah ,4ch
        int 21h
    main endp
code ends
end main