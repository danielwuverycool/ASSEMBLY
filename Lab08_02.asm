.MODEL SMALL

.DATA
    MSG1 DB 'DIGITE O NUMERO EM BINARIO:$'
    MSG2 DB 10,13,'O NUMERO EM BINARIO EH:$'

.CODE 
    MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    MOV BX,0032H
    MOV CX,15

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

    ZERO:
        MOV DL,'0'
        INT 21H
    
    LUPE:
        LOOP ROTATE

    MAIN ENDP
END MAIN
