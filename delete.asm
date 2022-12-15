data segment 
    msg db 'enter the name you want to delete: $'   
    names DD 0  times 100
    numbers DD 0  times 100
    
data ends


code segment 
    assume cs:code  , ds:data
    main proc far
        mov ax ,data
        mov ds , ax                 
        
        ;to priint the msg we use int 21h with 9 in ah
        mov ah,9
        ;mov dx, offset msg   or...
        lea dx , msg
        int 21h
        ; end of printing msg   
        
        
        
        find:
        
            
            JNZ find
        
        
        
        
        
                      
                      
                      
        ;at the end of the program we should release the cpu and let the os take control over the cpu
        mov ah ,4ch
        int 21h     
        ;cpu released     
        
        main endp
    
    
    
        ;func proc near 
            
         ; ret
        ;func endp
        
        
    
code ends 
end main

