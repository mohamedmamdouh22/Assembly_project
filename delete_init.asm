DATA SEGMENT 
    MSG DB 'ENTER THE NAME YOU WANT TO DELETE: $'


DATA ENDS


CODE SEGMENT 
    ASSUME CS:CODE  , DS:DATA
    MAIN PROC FAR
        MOV AX ,DATA
        MOV DS , AX                 
        
        ;TO PRIINT THE MSG WE USE INT 21H WITH 9 IN AH
        MOV AH,9
        ;MOV DX, OFFSET MSG or...
        LEA DX , MSG
        INT 21H
        ; END OF PRINTING MSG 
        
        
        ;at the end of the program we should release the cpu and let the os take control over the cpu
        MOV AH ,4CH
        INT 21H     
        ;cpu released
    MAIN ENDP
CODE ENDS 
END MAIN








