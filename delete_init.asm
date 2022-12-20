data segment 
    msg db 'enter the name you want to delete: $'   
    names DD 0  times 100
    numbers DD 0  times 100
             
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
        
        
        ;================================================================
        ; take input
        mov dx, offset buffer
		mov ah, 0ah
		int 21h
		
		xor bx, bx
		mov bl, buffer[1]
		mov buffer[bx+2], 0h
		mov si, offset buffer+2    ; si holds the start address of buffer
        ;input taken
        
                 
        
        
        mov bx,offset names ; hold base pointer for names array
        mov di,offset numbers ; hold base pointer for numbers array      
        mov cx , 14h  ; cx holds 20
        xor bp,bp ;bp=0 
        
         ; cx= 20
         ; si=base of buffer 
         ; bx = base of names 
         ; di= base of numbers
         ; bp =0
         ; ax hold char    
         
         
        
        
       ;find name 
          
        find:          ;need modification --> name not found
        
            ;cmp bp,counter
            ;jz  not_found
            
            mov ax ,[si]   ;ax holds the char of buffer
            cmp ax ,[bx]  
            jnz next  
           
    		inc si
    		inc bx
    		loop find 
    		          
    		          
    	cmp cx,30h      ;if cx = 0 it means we found the element
    	jz found
    	   	 
    	   	 
        next:    
            mov cx,14h                  ;set cx to 20
            mov si, offset buffer+2     ;set si to buffer base
            add bx ,cx+1            
            jmp find
               
               
               
        found:  
          sub bx , 14h  ; bx = bx-20
          ;continue
          
      
        
        
                      
        ;=================================================================         
        ;at the end of the program we should release the cpu and let the os take control over the cpu
        mov ah ,4ch
        int 21h     
        ;cpu released     
        
        main endp    
    
code ends 
end main