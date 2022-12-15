data segment
<<<<<<< HEAD

   msg2 db 0ah,0dh, 'name is $'
   len1 equ $-msg2

   msg3 db 0ah,0dh, 'number is $' 
   len2 equ $-msg3


data ends

code segment

=======
    len equ $-msg
data ends
code segment
>>>>>>> main
    assume cs:code, ds:data
    main proc far
        mov ax, data
        mov ds, ax
<<<<<<< HEAD

        mov cx, len1
        mov ah, 2
        mov bx, offset msg2

=======
        mov cx, len
        mov ah, 2
        mov bx, offset msg
>>>>>>> main
        a:
            mov dl, [bx]
            int 21h
            inc bx
        loop a
<<<<<<< HEAD

         mov cx, len2
         mov ah, 2
         mov bx, offset msg3 
       
       b:
            mov dl, [bx]
            int 21h
            inc bx
        loop b 

        
=======
>>>>>>> main
        mov ah, 4ch
        int 21h
    main endp
code ends
end main