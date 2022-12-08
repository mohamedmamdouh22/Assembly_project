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

INS DB ,0DH,0AH,"FOR INSERTIN",0DH,0AH,'$'
DEL DB ,0DH,0AH,"FOR DELETING",0DH,0AH,'$'
QUE DB ,0DH,0AH,"FOR QUERYING",0DH,0AH,'$' 
DIS DB ,0DH,0AH,"FOR DISPLAYING",0DH,0AH,'$' 
WRG DB ,0DH,0AH,"WRONG CHOICE",0DH,0AH,'$'
EX DB ,0DH,0AH,"GOOD BYE AND HAVE A NICE TIME :)",0DH,0AH,'$'   
       CONTINUE DB ,0DH,0AH,"DO YOU WANT TO CONTINUE",0DH,0AH,'$'       
.CODE
.STARTUP


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
     MOV AH,9H
     MOV DX,OFFSET INS
     INT 21H
     DELETE:
     QUERY:
     DISPLAY:
     
     
     
      

    EXIT:  ; SAY GOOD BYE AND THEN EXIT
    MOV AH,09H
    MOV DX,OFFSET EX
    INT 21H
.EXIT
END

