data segment                                                
    ;0ah to new line
    ;0dh return to  the beginning of the line 
    ;========================================================
    msg db   0ah,0dh'Enter the name you want to looking for: $'   
    names DD 0  times 100
    numbers DD 0  times 100
    key db 100 dup(?)            
    counter DW 30h                       ; counter = 0 
    msg2 db 0ah,0dh,'the number is : $'
    msg3 db 0ah,0dh,'This name not found!$'
    ;=======================================================
data ends


code segment 
    assume cs:code  , ds:data
    main proc far
        
        ;==================================
        mov ax ,data
        mov ds , ax 
        ;==================================
        
        
                 
        ;===========================================================
        mov ah,9      ;to print the msg we use int 21h with 9 in ah
        lea dx , msg
        int 21h
        ; end of printing msg 
        ;===========================================================  
          
          
             
        ;==========================================================   
        lea si, names ; hold base pointer for names array
        lea di, numbers ; hold base pointer for numbers array      
        ;==========================================================
       
       
       
        ; take the input from the user 
        ;=============================================================
        get_input:         
             mov ah,1    ; to take a value from the user  ah = 1
             int 21h     ; and the value will be stored in al 
             mov [cx],al 
             inc cx
             cmp al,0dh       ;al = Enter 
             JNZ get_input
             mov [cx-1],'$'   ;put $ at the end of the name
        
        lea cx , key    ;cx holds the input address
        ;==============================================================
        
        
        
        ;looking for the name
       ;============================================================ 
        looking_for: 
                  ; if the name is found go to found 
                  ; else go to not found
                          
       ;=============================================================       
       
       
       
       ;=============================================================
        found:
           ;print the name and the number
       
       ;=============================================================
        
       
       ;=============================================
         not_found:
           ; print not found;
       ;=============================================
        
        
        
        
                      
                      
        ;=================================================================         
        ;at the end of the program we should release the cpu and let the os take control over the cpu
        mov ah ,4ch
        int 21h     
        ;cpu released     
        
        main endp    
    
code ends 
end main 
