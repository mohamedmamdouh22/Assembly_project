     
data segment 

msg db 'enter the name and press enter to terminate: $',0ah,0dh
msg1 db 'enter the 11-digit  number and  press enter to terminate: $',0ah,0dh  

msg2 db 0ah,0dh, 'name is $'
msg3 db 0ah,0dh, 'number is $'
names DD 0  times 100               

msg4 db 0ah,0dh, 'the number is added $'    




msg5 db 0ah,0dh, 'would you want to add another one: $'
n_line DB 0AH,0DH,"$"   ;for new line  
numbers DD 0  times 100
data ends

code segment
    assume cs:code,ds:data
    main proc far 
        mov ax ,data
        mov ds,ax 
         mov  si,offset names       ;CX will point to the current element to insert in
         
         
         
               
         mov di,offset numbers
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
             mov [si-1],'$'  
             
                

          mov ah,9
          lea dx,n_line
          int 21h
         ;to print the msg
         mov ah,9
         lea dx,msg1
         int 21h
         
       
        ; insert number  
      
            
             loop2:
             mov ah,1
             int 21h
             mov [di],al
             inc di 
             ;cmp al,65h 
             cmp al,0dh
             JNZ loop2 
              mov [di-1],'$'

               
             
      
                       
           
             
      
         
        
      ret  
    insert endp
    
code ends       

end main        



                              
                              
                              
                              
           
         
         
         
         
         
         
         
         
        