     
data segment 
    
names DD 0  times 100
numbers DD 0  times 100

msg db 'enter the name and press enter to terminate: $',0ah,0dh
msg1 db 'enter the 11-digit  number and  press enter to terminate: $',0ah,0dh  
 
msg2 db 0ah,0dh, 'name is $'
msg3 db 0ah,0dh, 'number is $' 
msg4 db 0ah,0dh, 'the number is added $'
msg5 db 0ah,0dh, 'would you want to add another one: $'
n_line DB 0AH,0DH,"$"   ;for new line
data ends

code segment
    assume cs:code,ds:data
    main proc far 
        mov ax ,data
        mov ds,ax 
         mov  si,offset names     ;CX will point to the current element to insert in  
         mov si,offset numbers
             top:  call insert
                   mov ah,9
                   lea dx,msg4
                   int 21h  
                   mov ah,9
                   lea dx,n_line
                   int 21h
              
                    mov ah,9
                    lea dx,msg5
                    int 21h 
                    mov ah,1
                    int 21h 
                    cmp al,'y' 
                    mov ah,9
                    lea dx,n_line
                    int 21h
                    jz top
        mov ah,4ch
        int 21h
    main endp   
    
    insert proc near   
        
        
         ;to print the msg
         mov ah,9
         lea dx,msg
         int 21h     
       ;mov  si,offset names     ;CX will point to the current element to insert in  
      
       ; inser name
       loop1:
             mov ah,1
             int 21h
             mov [si],al
             inc si
             cmp al,0dh
             ;cmp al,30h
             JNZ loop1 
             inc si
                         
                         
             
          mov [si],'h'    
          mov ah,9
          lea dx,n_line
          int 21h
         ;to print the msg
         mov ah,9
         lea dx,msg1
         int 21h
         ;mov si,offset numbers
         inc si
       
        ; insert number  
       loop2:
             mov ah,1
             int 21h
             mov [si],al
             inc si 
             ;cmp al,65h 
             cmp al,0dh
             JNZ loop2 
             inc si
               
             
       mov cx,5
       mov si,offset names
       mov ah,9
       lea dx,msg2
       int 21h
      
       ; print name
       loop3:
             mov dl,[si]
             mov ah,2
             int 21h
             inc si
             loop loop3 
             
       mov cx,11
       mov si,offset numbers
       inc si
       mov ah,9
       lea dx,msg3
       int 21h
       
       ;print number
       loop4:
             mov dl,[si]
             mov ah,2
             int 21h
             inc si
             loop loop4          
          
                       
           
             
           
                 
         
        
      ret  
    insert endp
    
code ends       

end main        



           