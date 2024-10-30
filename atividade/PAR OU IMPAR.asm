.MODEL SMALL

.STACK 100H

.DATA

    VETOR DB 10 DUP(?)
    MSG DB 10,13,'VETOR: $'
    PAR DB 10,13,'PAR: $'
    IMPAR DB 10,13,'IMPAR: $'

.CODE 

    ;description
    PARIDADE PROC
        MOV CH,10
        MOV CL,2
        XOR BX,BX   
        XOR SI,SI
        LER:
            MOV AL,VETOR[SI]
            INC SI

            DIV CL
            CMP AH,0
            JNE ODD

            INC BH
            JMP CONTINUA

            ODD:
            INC BL

            CONTINUA:
                DEC CH
                CMP CH,0
                JNZ LER
            RET
    PARIDADE ENDP

    LEITURA MACRO 
        MOV AH,1
        INT 21H
    ENDM

    ;description
    LER_VETOR PROC
        XOR SI,SI
        MOV CX,10
        READ:
            MOV AH,9
            LEA DX,MSG
            INT 21H
            LEITURA
            SUB AL,30H
            MOV VETOR[SI],AL
            INC SI
            LOOP READ

            RET
    LER_VETOR ENDP

    IMPRIMIR MACRO 
        MOV AH,2
        ADD DL,'0'
        INT 21H
    ENDM

    ;description
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        CALL LER_VETOR
        CALL PARIDADE


        MOV AH,9
        LEA DX,PAR
        INT 21H

        MOV DL,BH

        IMPRIMIR


        ROL DX,8

        MOV AH,9
        LEA DX,IMPAR
        INT 21H

        MOV DL,BL

        IMPRIMIR
        
    MAIN ENDP
END MAIN