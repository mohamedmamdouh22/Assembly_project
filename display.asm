data segment

   msg2 db 0ah,0dh, 'name is $'
   len1 equ $-msg2

   msg3 db 0ah,0dh, 'number is $' 
   len2 equ $-msg3


data ends

code segment


    main proc far
        mov ax, data
        mov ds, ax

        

        mov ah, 2
        mov bx, offset msg2

<<<<<<<<< Temporary merge branch 1
=======
        mov cx, len
        mov ah, 2
        mov bx, offset msg
>>>>>>> main
=========

       

>>>>>>>>> Temporary merge branch 2
        a:
        a:   
            mov dl, [bx]
            int 21h
            inc bx
        loop a


         mov ah, 2
         mov bx, offset msg3 
       
       b:
            mov dl, [bx]
            int 21h
            inc bx
        loop b 


        int 21h
    main endp
code ends
end main