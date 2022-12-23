data segment                                                
    ;========================================================
    msg db 'Enter the name you want to looking for: $'   
    names db 100  dup(?)
    numbers db 100 dup (?)
    key db  20 dup(?)        ;key = input string (sizeof(20))           
    answer db 20 dup (?) 
    find_name dw ?
    find_number dw ?
    nameOfUser db 'Your name is : $'
    numberOfUser db 'Your number is : $' 
    no_name db 'This name does not exist!$'
    ;=======================================================
data ends


code segment 
    assume cs:code  , ds:data
    main proc far
         mov find_name , 0
         mov find_number , 0
        ;==================================
        mov ax ,data
        mov ds , ax 
        ;==================================
         mov names[0] , 'o'
         mov names[1] , 'm'
         mov names[2] , 'a'
         mov names[3] , 'r'
         mov names[4] , 's'
         mov names[5] , 'h'
         mov names[6] , 'a'
         mov names[7] , 'a'
         mov names[8] , 'b'
         mov names[9] , 'a'
         mov names[10] , 'n'
        ;=================================
        ;===========================================================
        mov ah,9      ;to print the msg we use int 21h with 9 in ah
        mov dx ,offset msg
        int 21h
        ; end of printing msg 
        ;=========================================================== 
           
        
        print_new_line macro
            mov dl, 13
            mov ah, 2
            int 21h   
            mov dl, 10
            mov ah, 2
            int 21h      
        endm
        ;=================================
           
          
         
          
        ; take the input from the user 
        ;=============================================================
         mov si , 0
         input:
              mov ah,1
              int 21h
              cmp al , 13
              je capital_key
              
              mov key[si] , al
              inc si 
               
              
              cmp si , 20
              je capital_key
              
              jmp input
              
        ;=========================================================  
         
         
         
         ;make the name capital
        ;==========================================
         capital_key:
            lea bx , key
            call  change
        ;========================================== 
         
         
          
        ;tranfer names in an array answer
        ;===============================================
          fill:
            inc find_number
            mov ax , 100       ;d = 100
            cmp ax , find_name   ; if true zf = 1
            je not_found       
           
           
            mov si , find_name
            mov bx , 0
            mov di , answer[offset answer + find_name]
            transfer:
                mov cl , names[si]
                mov [di] , cl
                inc di
                inc si
                inc find_name
                inc bx 
                cmp bx , 20 ; if true zf = 1
                jnz transfer           
        ;==============================================
         lea bx , answer 
         call change
         ;compare two strings  
         ;cmp >> if distination == source zf = 1
        ;=============================================
         lea si , key
         lea di , answer 
         mov cx , 20
         compare: 
              mov al , [si] 
              cmp al , [di]
              jnz fill
              inc si 
              inc di
              loop compare
         ;============================================
        
         
       ;=============================================================  
             ;output the name if it is exist 
             ;=======================================
             ; get actual string size:
             print_new_line
             mov ah , 9
             lea dx , nameOfUser
             int 21h
             dec find_number
             
             xor cx, cx
             mov cl, 20
             print_new_line          
             mov bx, offset names [offset names + find_number * 20]
             print_name:
                 mov dl, [bx]
                 mov ah, 2
                 int 21h         
                 inc bx
                 loop print_name
             ; wait for any key...
             mov ax, 0 
             int 16h 
             ;============================================
             
             
             
              ;print tne number  
             ;============================================= 
             print_new_line
             mov ah , 9
             lea dx , numberOfUser
             int 21h
             
             xor cx, cx
             mov cl, 20
             print_new_line          
             mov bx, offset numbers [offset numbers + find_number * 20]
             print_number:
                 mov dl, [bx]
                 mov ah, 2
                 int 21h         
                 inc bx
                 loop print_number
             ; wait for any key...
             mov ax, 0 
             int 16h 
             jmp Exit
       ;=============================================================
        
       
       ;=============================================
         not_found:
                 print_new_line
                 mov ah , 9
                 mov dx , offset no_name 
                 int 21h
       ;=============================================
        
                     
        ;=================================================================         
        ;at the end of the program we should release the cpu and let the os take control over the cpu
        Exit:
         mov ah ,4ch
         int 21h     
        ;cpu released     
        
        main endp 

       
    ;change all characters to capital case 
    ;================================================
      change proc near
             mov ch, 0
             mov cl, 20 ; get string size.
            ; jcxz null ; is string is empty?
            ; add bx, 2 ; skip control chars.
             upper_case:
    
             ; check if it's a lower case letter:
                  cmp byte ptr [bx], 'a'
                  jb ok
                  cmp byte ptr [bx], 'z'
                  ja ok
    
              ; convert to uppercase:
    
             ; upper case letter do not have third bit set
             ; 'a'    : 01100001b
             ; 'A':     01000001b
             ; upper case mask : 11011111b
    
             ; clear third bit:
             and byte ptr [bx], 11011111b
    
             ok:
                inc bx ; next char.
                loop upper_case
      ret 
      change endp 
    ;================================================
        
        
        
           
    
code ends 
end main 
