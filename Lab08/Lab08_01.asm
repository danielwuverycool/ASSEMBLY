.MODEL SMALL

.DATA
    MSG1 DB 'DIGITE O NUMERO EM BINARIO:$'
    MSG2 DB 10,13,'O NUMERO EM BINARIO EH:$'

.CODE 
    MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    MOV AH,1
    MOV CX,15

    XOR BX,BX

    MOV AH,9
    LEA DX,MSG1
    INT 21H

    MOV AH,1

    DIGITE:
        INT 21H
        CMP AL,13
        JE CONTINUA
        AND AL,0FH

        SHL BX,1
        OR BL,AL
        

        LOOP DIGITE
    
    CONTINUA:
        MOV CX,16

        MOV AH,9
        LEA DX,MSG2
        INT 21H

        MOV AH,2

    ROTATE:
        ROL BX,1
        JNC ZERO

    UM:
        MOV DL,'1'
        INT 21H
        JMP LUPE

    ZERO:
        MOV DL,'0'
        INT 21H
    
    LUPE:
        LOOP ROTATE
    
    MAIN ENDP
END MAIN