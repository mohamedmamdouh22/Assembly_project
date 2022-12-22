.MODEL SMALL
.DATA
MAIN_MENU DB ,0DH,0AH,"Phone Book",0DH,0AH            ;the starting screen for the program
          DB "Press '1' For INSERT",0DH,0AH
          DB "Press '2' For DELETE",0DH,0AH 
          DB "Press '3' For SAVE a new file",0DH,0AH
          DB "Press '4' For append to the file",0DH,0AH
          DB "Press '5' For QUERY",0DH,0AH
          DB "Press '6' For DISPLAY ALL",0DH,0AH
          DB "Press '7' For REMOVE ALL",0DH,0AH
          DB "Press '8' For EXIT",0DH,0AH
          DB "*******************************",0DH,0AH
          DB "Enter Your CHOICE",0DH,0AH,'$'     

INS DB ,0DH,0AH,"FOR INSERTIN",0DH,0AH            ;the starting screen for the program
    DB "enter the name: ",0DH,0AH,'$'
names db 100 dup (0) 
numbers db 100 dup (0)        
DEL DB ,0DH,0AH,"FOR DELETING",0DH,0AH,'$'
QUE DB ,0DH,0AH,"FOR QUERYING",0DH,0AH,'$' 
DIS DB ,0DH,0AH,"FOR DISPLAYING",0DH,0AH,'$' 
WRG DB ,0DH,0AH,"WRONG CHOICE",0DH,0AH,'$'
EX DB ,0DH,0AH,"GOOD BYE AND HAVE A NICE TIME :)",0DH,0AH,'$'   
       CONTINUE DB ,0DH,0AH,"DO YOU WANT TO CONTINUE Y/E",0DH,0AH,'$' 

buffer db 20,?, 20 dup(0)
buffer2 db 20,?, 20 dup(0)
nameP db 'name is: ',0ah,0dh,'$'
msg db 'enter the name: $',0ah,0dh
msg1 db 'enter the 11-digit  number: ',0ah,0dh,'$'  

counter Db 0h 
counter2 Dw 0h 
msg_del db 'enter the name you want to delete: $' 
msg_del2 db 'The phonebook is empty!$'
msg_del3 db 'name not found!$' 

fname db 'first.txt',0
fhandle dw ?

empty db ,' Empty note book ',0ah,0dh,'$'

n_line DB 0AH,0DH,"$"   ;for new line
 
;numbers DD 0  times 100     
.CODE
.STARTUP

;mov bx,offset names ; hold base pointer for names array
mov di,offset numbers ; hold base pointer for numbers array 
START:          ;MAIN function
MOV AH,09H
MOV DX, OFFSET MAIN_MENU    ;DISPLAY GUI 
INT 21H
    TRY:
    MOV AH,01H                  ; TAKE INPUT FROM USER
    INT 21H
    CMP AL,31H
    JB WRONG
    CMP AL,38H
    JB COMARE 
    WRONG:
    MOV AH,09H
    MOV DX, OFFSET WRG    ;DISPLAY WRONG CHOICE 
    INT 21H
    JMP TRY
    
    
COMARE:
CMP AL,31H  ;if choice is 1 jump to insert function
JE INSERT
CMP AL,32H   ; if choice is 2 jump to delete function
JE DELETE 
CMP AL,33H   ; if choice is  3jump to add  function
JE SAVE   
CMP AL,34H   ; if choice is 4 jump to append function
JE APPEND
CMP AL,35H    ; if choice is 5 jump to search function
JE QUERY
CMP AL,36H    ; if choice is 6 jump to display function
JE DISPLAY
CMP AL,37H    ; if choice is 7 jump to exit function
JE CLEAR
cmp al,38h     ; exit if choice is 8
je EXIT

     INSERT: ; TO BE IMPLEMENTED
      mov di,offset names
      mov bp,offset numbers 
      mov ax,20
      mul counter
      add di,ax
      add bp,ax     
     inc counter
     inc counter2
     mov ah,9h
     mov dx,offset INS
     int 21h
       ;inser name 
		mov dx, offset buffer
		mov ah, 0ah
		int 21h

		xor bx, bx
		mov bl, buffer[1]
		mov buffer[bx+2], 0h
		mov si, offset buffer+2
		loop1:
    		mov cx,[si]
    		mov [di],cx
    		inc si
    		inc di
    		cmp [si],0h
    		jnz loop1

	     	 
          mov ah,9
          lea dx,n_line
          int 21h
         ;to print the msg
         mov ah,9
         lea dx,msg1
         int 21h
         ;mov di,offset numbers
        ; insert number  
      	mov dx, offset buffer
		mov ah, 0ah
		int 21h

		xor bx, bx
		mov bl, buffer[1]
		mov buffer[bx+2], 0h
		mov si, offset buffer+2
		loop2:
    		mov dx,[si]
    		mov [bp],dx
    		inc si
    		inc bp
    		cmp [si],0h
    		jnz loop2
                 
             ;FOR CONTINUE
            MOV AH,09H
            MOV DX,OFFSET CONTINUE
            INT 21H
            MOV AH,01H
            INT 21H
            CMP AL,'Y'
            JE START
            cmp al,'y'
            je start
            ;CMP AL,'E'
            jmp EXIT
                         
             
             
     DELETE:    
        ;to priint the msg we use int 21h with 9 in ah
        mov ah,9
        ;mov dx, offset msg   or...
        lea dx , msg_del
        int 21h
        ; end of printing msg   
        
        
        ;================================================================
        ; take input
        mov dx, offset buffer2
		mov ah, 0ah
		int 21h
		
		xor bx, bx
		mov bl, buffer2[1]
		mov buffer2[bx+2], 0h
		mov si, offset buffer2+2    ; si holds the start address of buffer
        ;input taken
        
                 
        
        
        mov bx,offset names ; hold base pointer for names array
        mov di,offset numbers ; hold base pointer for numbers array      
        mov cx , 14h  ; cx holds 20
        xor dl ,dl    ;dl =0
        
         ; cx= 20
         ; si=base of buffer 
         ; bx = base of names 
         ; di= base of numbers
         ; bp =0
         ; ax hold char   
        
       ;find name 
          
        find:          
        
            cmp dl,counter
            jz  not_found
            
            mov al ,[si]   ;al holds the char of buffer
            cmp al ,[bx]  
            jnz next  
           
    		inc si
    		inc bx
    		loop find 
    		          
    		          
    	cmp cx, 0h      ;if cx = 0 it means we found the element
    	jz found    	   	 
    	   	 
        next:                
            mov si, offset buffer2+2     ;set si to buffer base
            mov bx,offset names ; hold base pointer for names array  
            inc dl 
            mov al , 15h        ;ax= dl * 21 
            mul dl
            add bx ,ax
             
               
            mov cx,14h           ;set cx to 20
                                 ;dl++
            jmp find
               
        found:
          mov si,offset names   ; hold base pointer for names array
          mov di,offset numbers ; hold base pointer for numbers array      
          mov cx , 14h          ; cx holds 20 
           
          mov al ,dl
          mov dl, 15h
          mul dl                  
          mov bx ,ax                ;bx holds the offset of element we want to delete
          
          dec counter           
          mov al ,counter
          mul dl                    ;ax holds the offset of last element 
          mov bp , ax               ;need modification
          
          del_n:
            mov dl , [si+bp]
            mov [si+bx],dl
            
            mov dl ,[di+bp]
            mov [di+bx],dl  
            
            inc bp
            inc bx
            loop del_n   
          
            
            ;FOR CONTINUE
            MOV AH,09H
            MOV DX,OFFSET CONTINUE
            INT 21H
            MOV AH,01H
            INT 21H
            CMP AL,'Y'
            JE START
            CMP AL,'E'
            JE EXIT
            
              
        not_found:     
            mov ah,9h
            mov dx,offset n_line
            int 21h
            ;to priint the msg we use int 21h with 9 in ah
            mov ah,9
            ;mov dx, offset msg   or...
            lea dx , msg_del3
            int 21h
            ; end of printing msg   
            
            ;FOR CONTINUE
            MOV AH,09H
            MOV DX,OFFSET CONTINUE
            INT 21H
            MOV AH,01H
            INT 21H
            CMP AL,'Y'
            JE START
            CMP AL,'E'
            JE EXIT  
        
                 

      
    SAVE:  
    
          ;create new file
    
            mov ah ,3ch
            lea dx,fname
            mov cx,0
            int 21h
            mov fhandle,ax  
        
           ;open file
            mov ah,3dh
            mov al,2 ; open file for read and  write   
            lea dx,fname
            int 21h
            mov fhandle, ax  
                             
                  
  
            
           ;to write in file
           cmp counter2,0
           jz CONT 
           mov si,counter2 
           mov di,0h
           loop5:
            mov ax,20
            mul di
            mov bx,fhandle
            mov cx, 20    ;size of number of bytes to write 
            mov dx,offset names
            add dx,ax
            mov ah,40h  
            int 21h 
            
            
            
      
            mov ax,20
            mul di
            mov bx,fhandle
       
            lea dx, numbers

            add dx,ax
            mov ah,40h
            int 21h
                      
           
            mov ah,40h
            mov bx,fhandle
            mov cx, 1    ;size of number of bytes to write 
            mov dx,offset n_line  
            int 21h

            dec si
            inc di
            cmp si,0h
            jnz loop5
             ;FOR CONTINUE
            CONT:
            mov ah,9h
            lea dx,n_line
            int 21h
            mov ah,9h
            lea dx,empty
            int 21h
            MOV AH,09H
            MOV DX,OFFSET CONTINUE
            INT 21H
            MOV AH,01H
            INT 21H
            CMP AL,'Y'
            JE START
            cmp al,'y'
            je START
            ;CMP AL,'E'
            Jmp EXIT          
            
            
             APPEND:
             ;open file
            mov ah,3dh
            mov al,2 ; open file for read and  write   
            lea dx,fname
            int 21h
            mov fhandle, ax  
            
            
             
            mov al, 2
        	mov bx, fhandle
        	mov cx, 0
        	mov dx, 1
        	mov ah, 42h
        	int 21h 
            
  
            cmp counter2,0h
            jz CONT
           ;to write in file
           mov si,counter2 
           mov di,0h
           loop6:
            mov ax,20
            mul di
            mov bx,fhandle
            mov cx, 20    ;size of number of bytes to write 
            mov dx,offset names
            add dx,ax
            mov ah,40h  
            int 21h 
            
            
            
      
            mov ax,20
            mul di
            mov bx,fhandle
       
            lea dx, numbers

            add dx,ax
            mov ah,40h
            int 21h
                      
           
            mov ah,40h
            mov bx,fhandle
            mov cx, 1    ;size of number of bytes to write 
            mov dx,offset n_line  
            int 21h

            dec si
            inc di
            cmp si,0h
            jnz loop6
         
           

            ;FOR CONTINUE
            
            MOV AH,09H
            MOV DX,OFFSET CONTINUE
            INT 21H
            MOV AH,01H
            INT 21H
            CMP AL,'Y'
            JE START
            cmp al,'y'
            je START
            ;CMP AL,'E'
            Jmp EXIT          
       QUERY:

     DISPLAY:
     
        mov bx,0
        mov cl,counter
        mov al , 1h
        mul cl
        mov cx ,ax
        outerLoop:
            mov ah,9h
            mov dx,offset nameP
            int 21h
              mov si,offset names
              mov ax,20
              mul bx
              add si,ax
            loop7:
                mov ah,2
                mov dx,[si]
                int 21h
                inc si
                cmp [si],0h
                jnz loop7
                inc si
            mov ah,9h
            mov dx,offset n_line
            int 21h
            inc bx
            loop outerLoop
            ;FOR CONTINUE
            MOV AH,09H
            MOV DX,OFFSET CONTINUE
            INT 21H
            MOV AH,01H
            INT 21H
            CMP AL,'Y'
            JE START
            CMP AL,'E'
            JE EXIT                
         
    CLEAR:
    EXIT:  ; SAY GOOD BYE AND THEN EXIT
    MOV AH,09H
    MOV DX,OFFSET EX
    INT 21H
.EXIT
END