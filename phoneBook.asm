.MODEL SMALL
.DATA
MAIN_MENU DB ,0DH,0AH,"Phone Book",0DH,0AH            ;the starting screen for the program
          DB "Press 'I' For INSERT",0DH,0AH
          DB "Press 'D' For DELETE",0DH,0AH
          DB "Press 'Q' For QUERY",0DH,0AH
          DB "Press 'A' For DISPLAY ALL",0DH,0AH
          DB "Press 'E' For EXIT",0DH,0AH
          DB "Press 'R' For RETURN to Main Menu",0DH,0AH
          DB "*******************************",0DH,0AH
          DB "Enter Your CHOICE",0DH,0AH,'$'     

INS DB ,0DH,0AH,"FOR INSERTIN",0DH,0AH,'$'
DEL DB ,0DH,0AH,"FOR DELETING",0DH,0AH,'$'
QUE DB ,0DH,0AH,"FOR QUERYING",0DH,0AH,'$' 
DIS DB ,0DH,0AH,"FOR DISPLAYING",0DH,0AH,'$'
EX DB ,0DH,0AH,"GOOD BYE AND HAVE A NICE TIME :)",0DH,0AH,'$'   
       CONTINUE DB ,0DH,0AH,"DO YOU WANT TO CONTINUE",0DH,0AH,'$'       
.CODE
.STARTUP


START:          ;MAIN function
MOV AH,09H
MOV DX, OFFSET MAIN_MENU    ;DISPLAY GUI 
INT 21H
MOV AH,01H                  ; TAKE INPUT FROM USER
INT 21H

CMP AL,'I'  ;if choice is I jump to insert function
JE INSERT
CMP AL,'D'   ; if choice is D jump to delete function
JE DELETE   
CMP AL,'Q'   ; if choice is Q jump to query function
JE QUERY
CMP AL,'A'    ; if choice is A jump to display function
JE DISPLAY
CMP AL,'R'    ; if choice is R jump to main function
JE START
CMP AL,'E'    ; if choice is E jump to exit function
JE EXIT

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

