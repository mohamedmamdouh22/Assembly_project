data segment                                                
    ;========================================================
    msg db   'Enter the name you want to looking for: $'   
    names Db 100  dup('a')
    numbers Db 100 dup ('a')
    key db 20,?, 20 dup(?)        ;key = input string (sizeof(20))           
    answer db 20 dup (?)
    msg2 db 'the number is : $'
    msg3 db 'This name not found!$'
    ;=======================================================
data ends


code segment 
    assume cs:code  , ds:data
    main proc far
        
        ;==================================
        mov ax ,data
        mov ds , ax 
        ;==================================
        
        ;=================================
        print_new_line macro
            mov dl, 13
            mov ah, 2
            int 21h   
            mov dl, 10
            mov ah, 2
            int 21h      
        endm
        ;=================================
        
                 
        ;===========================================================
        mov ah,9      ;to print the msg we use int 21h with 9 in ah
        lea dx , msg
        int 21h
        ; end of printing msg 
        ;===========================================================  
          
        ; take the input from the user 
        ;=============================================================
         mov dx, offset key
         mov ah, 0ah
         int 21h   
        ;=========================================================  
        
        
        ;change all characters to capital case 
        ;================================================
         lea bx, key
         mov ch, 0
         mov cl, [bx+1] ; get string size.
        ; jcxz null ; is string is empty?
         add bx, 2 ; skip control chars.
         upper_case:

         ; check if it's a lower case letter:
              cmp byte ptr [bx], 'a'
              jb ok
              cmp byte ptr [bx], 'z'
              ja ok

          ; convert to uppercase:

         ; upper case letter do not have third bit set, for example:
         ; 'a'    : 01100001b
         ; 'A':     01000001b
         ; upper case mask : 11011111b

         ; clear third bit:
         and byte ptr [bx], 11011111b

         ok:
            inc bx ; next char.
            loop upper_case
        ;================================================
         
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
