.MODEL SMALL

.DATA
    MSG1 DB 'DIGITE O VALOR EM HEXADECIMAL:$'

.CODE
    MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    MOV CX,4

    XOR BX,BX 

    MOV AH,9
    LEA DX,MSG1
    INT 21H

    MOV AH,1

    DIGITE:
        SHL BX,4
        INT 21H
        CMP AL,13
        JE CONTINUA
        CMP AL,'A'
        JAE CARACTERE
        CMP AL,'0'
        JAE NUMERO
        OR BL,AL
        
    
    NUMERO:
        SUB AL,'0'
        JMP CONVERTE
    
    CARACTERE:
        SUB AL,'A'
        ADD AL,10
    
    CONVERTE:
        OR BL,AL
        

        LOOP DIGITE



    CONTINUA:
        MOV AH,2
        MOV CX,4

    
    IMPRIME:
        MOV DL,BH
        SHR DL,4    
        CMP DL,10
        JAE LETRA
        
        ADD DL,'0'
        INT 21H
        JMP FIM

    LETRA:
        
        ADD DL,'A'
        SUB DL,10
        INT 21H
    FIM:
        ROL BX,4
        LOOP IMPRIME


        MOV AH,4CH
        INT 21H


    


    MAIN ENDP
END MAIN