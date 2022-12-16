
.MODEL SMALL
.DATA
MAIN_MENU DB ,0DH,0AH,"Phone Book",0DH,0AH            ;the starting screen for the program
          DB "Press '1' For INSERT",0DH,0AH
          DB "Press '2' For DELETE",0DH,0AH
          DB "Press '3' For QUERY",0DH,0AH
          DB "Press '4' For DISPLAY ALL",0DH,0AH
          DB "Press '5' For EXIT",0DH,0AH
          DB "Press '6' For RETURN to Main Menu",0DH,0AH
          DB "*******************************",0DH,0AH
          DB "Enter Your CHOICE",0DH,0AH,'$'     

INS DB ,0DH,0AH,"FOR INSERTIN",0DH,0AH            ;the starting screen for the program
    DB "enter the name and enter {dollar sign} to terminate: ",0DH,0AH,'$'
names db 100 dup (0) 
numbers db 100 dup (0)        
DEL DB ,0DH,0AH,"FOR DELETING",0DH,0AH,'$'
QUE DB ,0DH,0AH,"FOR QUERYING",0DH,0AH,'$' 
DIS DB ,0DH,0AH,"FOR DISPLAYING",0DH,0AH,'$' 
WRG DB ,0DH,0AH,"WRONG CHOICE",0DH,0AH,'$'
EX DB ,0DH,0AH,"GOOD BYE AND HAVE A NICE TIME :)",0DH,0AH,'$'   
       CONTINUE DB ,0DH,0AH,"DO YOU WANT TO CONTINUE Y/E",0DH,0AH,'$' 


nameP db 'name is: ',0ah,0dh,'$'
msg db 'enter the name and enter {dollar sign} to terminate: $',0ah,0dh
msg1 db 'enter the 11-digit  number and enter {dollar sign} to terminate: ',0ah,0dh,'$'  
 
counter DW 0h

n_line DB 0AH,0DH,"$"   ;for new line
 
;numbers DD 0  times 100     
.CODE
.STARTUP

mov bx,offset names ; hold base pointer for names array
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
    CMP AL,36H
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
CMP AL,33H   ; if choice is 3 jump to query function
JE QUERY
CMP AL,34H    ; if choice is 4 jump to display function
JE DISPLAY
CMP AL,35H    ; if choice is 5 jump to main function
JE EXIT
CMP AL,36H    ; if choice is 6 jump to exit function
JE START

     INSERT: ; TO BE IMPLEMENTED
     inc counter
     mov ah,9h
     mov dx,offset INS
     int 21h
       ;inser name 
       
       loop1:
             mov ah,1
             int 21h
             mov [bx],al
             inc bx
             cmp al,0Dh
             JNZ loop1
             mov [bx-1],'$'
           
          mov ah,9
          lea dx,n_line
          int 21h
         ;to print the msg
         mov ah,9
         lea dx,msg1
         int 21h
         ;mov di,offset numbers
        ; insert number  
       loop2:
             mov ah,1
             int 21h 
             mov [di],al
             inc di
             cmp al,0DH
             JNZ loop2
             mov [di-1],'$'
             
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
                         
             
             
     DELETE:
     QUERY:
     
     
     
     
     
     DISPLAY:
        mov si,offset names
        ;mov bx,offset numbers
        mov cx,counter
        outerLoop:
            mov ah,9h
            mov dx,offset nameP
            int 21h
            loop7:
                mov ah,2
                mov dx,[si]
                int 21h
                inc si
                cmp [si],'$'
                jnz loop7
                inc si
            mov ah,9h
            mov dx,offset n_line
            int 21h
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


    EXIT:  ; SAY GOOD BYE AND THEN EXIT
    MOV AH,09H
    MOV DX,OFFSET EX
    INT 21H
.EXIT
END

