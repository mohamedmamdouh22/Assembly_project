data segment
    msg2 db 'yasmen'
    len1 equ $-msg2
    msg3 db '112000'
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
        a:
           mov dl,[bx]
           int 21h
           inc bx
        loop a 
       
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