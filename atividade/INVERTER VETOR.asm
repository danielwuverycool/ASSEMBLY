.MODEL SMALL

.STACK 100H

.DATA

    VETOR DB 1,2,3,4,5,6,7

.CODE

    ;description
    INVERTER PROC
        MOV CX,3
        XOR SI,SI
        MOV BX,6

        INVERT:
            MOV AL,VETOR[SI]
            MOV AH,VETOR[BX]
            MOV VETOR[BX],AL
            MOV VETOR[SI],AH
            INC SI
            DEC BX
            LOOP INVERT
        RET
    INVERTER ENDP

    PRINT MACRO 
        MOV AH,2
        ADD DL,'0'
        INT 21H
    ENDM

    ;description
    IMPRIMIR_VETOR PROC
        XOR SI,SI
        MOV CX,7
        IMPRIME:
            MOV DL,VETOR[SI]
            PRINT
            INC SI
            LOOP IMPRIME
        RET

    IMPRIMIR_VETOR ENDP

    ;description
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        CALL INVERTER

        CALL IMPRIMIR_VETOR
        
    MAIN ENDP
END MAIN