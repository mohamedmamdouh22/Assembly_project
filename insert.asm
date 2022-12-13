     
data segment 
    
arr dd 7dup('')

msg db 'enter the number $',0ah,0dh  
 
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
         
         
      
        
       loop1:
             mov ah,1
             int 21h
             mov ah,0h
             shl bx,8 
             cmp al,65h
             mov bl,al
             ;add bx,ax
             JNZ loop1 
                       
         
             
           
                 
         
        
        
        
        
        mov ah,4ch
        int 21h
    main endp
code ends       

end main        



           
