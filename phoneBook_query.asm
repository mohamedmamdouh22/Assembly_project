
data segment 
    query_msg db 'searc for a name$' 
data ends 

code segment 
    assume cs:code , ds:data 
    main proc far
      mov ax , data 
      mov ds , ax
        
      call query
      
      mov ah , 4ch 
      int 21h 
    main endp  
    
    query proc near 
      mov ah , 9                   ; for a message   
      mov dx , offset query_msg    ; the beginning of the adress   
      int 21h                     
      
      ret   
    query endp 



code ends
end main 
