     
data segment 
    
names DD 0  times 100
numbers DD 0  times 100

msg db 'enter the name and enter {dollar sign} to terminate: $',0ah,0dh
msg1 db 'enter the 11-digit  number and enter {dollar sign} to terminate: $',0ah,0dh  
 
msg2 db 0ah,0dh, 'name is $'
msg3 db 0ah,0dh, 'number is $' 
n_line DB 0AH,0DH,"$"   ;for new line
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
       mov  si,offset names     ;CX will point to the current element to insert in  
       ; inser name
       loop1:
             mov ah,1
             int 21h
             mov [si],al
             inc si
             cmp al,24h
             JNZ loop1
 COMMENT @    
          mov ah,9
          lea dx,n_line
          int 21h
         ;to print the msg
         mov ah,9
         lea dx,msg1
         int 21h
         mov si,offset numbers
         inc si
        ; insert number  
       loop2:
             mov ah,1
             int 21h
             mov [si],al
             inc si
             cmp al,24h
             JNZ loop2
       ;mov cx,5
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
      ; mov cx,11
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
         @
         jp loop1        
         
        
        
        
        
        mov ah,4ch
        int 21h
    main endp
code ends       

end main        



           