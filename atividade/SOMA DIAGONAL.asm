.MODEL SMALL

.STACK 100H

.DATA

    MATRIZ3X3   DB 1,2,3
                DB 1,2,3
                DB 4,5,6

    MSG1 DB 'SOMA: $'

.CODE
    ;description
    SOMA_DIAGONAL PROC
        XOR DL,DL
        MOV CX,3
        XOR BX,BX
        XOR SI,SI
        SOMAR:
            ADD DL,MATRIZ3X3[BX][SI]
            ADD BX,3
            INC SI
            LOOP SOMAR
        RET
    SOMA_DIAGONAL ENDP

    IMPRIMIR MACRO 
        PUSH AX

        ADD DL,'0'

        MOV AH,2
        INT 21H    

        POP AX
    ENDM

    PULA_LINHA MACRO 
        PUSH AX
        PUSH DX

        MOV AH,2
        MOV DL,10
        INT 21H    

        MOV AH,2
        MOV DL,13
        INT 21H    

        POP AX
        POP DX
    ENDM


    ;description
    IMPRIME PROC
        
        XOR BX,BX

        REINICIAR:
            XOR SI,SI
            MOV CX,3
        PRINT:
            MOV DL,MATRIZ3X3[BX][SI]
            INC SI
            IMPRIMIR
            LOOP PRINT
            PULA_LINHA
            ADD BX,3
            CMP BX,6
            JBE REINICIAR

            RET
    IMPRIME ENDP

    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        CALL IMPRIME

        PULA_LINHA

        CALL SOMA_DIAGONAL

        MOV AH,9
        LEA DX,MSG1
        INT 21H

        IMPRIMIR


    MAIN ENDP
END MAIN
