     
data segment 
    
arr DW 0  times 100

msg db 'enter the 8-digit number $',0ah,0dh  
 
msg2 db 0ah,0dh, 'your number is $' 
data ends

code segment
    assume cs:code,ds:data
    main proc far 
        mov ax ,data
        mov ds,ax 
         ;to print the msg
         mov ah,9
         lea dx,msg
         int 21h     
         
         
      
       mov  si,offset arr     ;CX will point to the current element to insert in
       loop1:
             mov ah,1
             int 21h
             mov [si],al
             inc si
             cmp al,65h
             JNZ loop1 
             mov cx,8
             mov si,offset arr
             
             mov ah,9
             lea dx,msg2
             int 21h
             
             
             loop2:
             mov dl,[si]
             mov ah,2
             int 21h
             inc si
             loop loop2          
         
             
           
                 
         
        
        
        
        
        mov ah,4ch
        int 21h
    main endp
code ends       

end main        



           