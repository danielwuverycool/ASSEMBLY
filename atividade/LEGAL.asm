.MODEL SMALL

.DATA 
    MSG DB '?$'

.CODE
    MAIN PROC

    MOV AX,@DATA
    MOV DS,AX

    MOV AH,9
    LEA DX,MSG
    INT 21H

    MOV AH,1

    INT 21H
    MOV BL,AL

    INT 21H
    MOV CL,AL

    MOV AH,2

    MOV DL,10
    INT 21H

    MOV DL,13
    INT 21H

    CMP BL,CL
    JBE MAIOR

    MOV AH,2

    MOV DL,CL
    INT 21H

    MOV DL,BL
    INT 21H

    JMP FIM

    MAIOR:
        MOV AH,2

        MOV DL,BL
        INT 21H

        MOV DL,CL
        INT 21H

        JMP FIM

    FIM:
        MOV AH,4CH
        INT 21H

    MAIN ENDP
END MAIN