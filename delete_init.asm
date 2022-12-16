data segment 
    msg db 'enter the name you want to delete: $'   
    names DD 0  times 100
    numbers DD 0  times 100
    input DB           
    counter DW 30h 
    msg2 db 'The phonebook is empty!$'
data ends


code segment 
    assume cs:code  , ds:data
    main proc far
        mov ax ,data
        mov ds , ax 
        
        
        ; to be put in main
        ;cmp counter ,30h  
        ;jz  start   
        
       
                        
        
        ;to priint the msg we use int 21h with 9 in ah
        mov ah,9
        ;mov dx, offset msg   or...
        lea dx , msg
        int 21h
        ; end of printing msg   
        
        mov bx,offset names ; hold base pointer for names array
        mov di,offset numbers ; hold base pointer for numbers array      
        lea cx , input
        ;================================================================
        loop1:         ; this loop is to take the input name
             mov ah,1
             int 21h
             mov [cx],al 
             inc cx
             cmp al,0Dh
             JNZ loop1
             mov [cx-1],'$' 
        
        lea cx , input    ;cx holds the input address
        
        loop2:            ;this loop is to campare input with names elements
            lea si, str1
        	lea di, str2
                		;use string instructions
                		;to comapre the two strings
        	cld         ;clear direction flags
        	repe cmpsb  ;repeat compare string byte
        	je s_same
        	jmp s_not
            
            
        s_same:
        s_not:
        
        
        
        
        
                      
                      
        ;=================================================================         
        ;at the end of the program we should release the cpu and let the os take control over the cpu
        mov ah ,4ch
        int 21h     
        ;cpu released     
        
        main endp    
    
code ends 
end main