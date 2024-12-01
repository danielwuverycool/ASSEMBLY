.MODEL SMALL

.STACK 100H

.DATA

    MATRIZ DB  1, 2
           DB  3, 4


.CODE
    PULALINHA MACRO 
        PUSH AX
        PUSH DX
        MOV AH,2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        POP DX
        POP AX
    ENDM
 
    PRINT_MATRIX PROC
        CLD
        LEA SI,MATRIZ
        XOR BX,BX
        MOV AH,2
        OUTRALINHA:
            MOV CX,2
        PRINT:
            LODSB
            MOV DL,AL
            ADD DL,'0'
            INT 21H
            LOOP PRINT
            ADD BX,2
            PULALINHA
            CMP BX,2
            JBE OUTRALINHA
        RET
    PRINT_MATRIX ENDP


    TRANSPOR_MATRIZ PROC
        LEA SI,MATRIZ
        MOV AL,BYTE PTR [2][SI]
        INC SI
        XCHG BYTE PTR [0][SI],AL
        DEC SI
        MOV BYTE PTR [2][SI],AL
        RET
    TRANSPOR_MATRIZ ENDP

    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX

        CALL PRINT_MATRIX
        CALL TRANSPOR_MATRIZ
        CALL PRINT_MATRIX

        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
