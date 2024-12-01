.MODEL SMALL

.STACK 100H

.DATA

    MATRIZ DB  1, 2, 3, 1
           DB  5, 6, 7, 1
           DB  9, 0, 1, 1
           DB  3, 4, 5, 1


.CODE
    IMPRIME_STRING MACRO MSG1
        PUSH AX
        MOV AH,9
        LEA DX,MSG1
        INT 21H
        POP AX
    ENDM

    IMPRIME_CARACTER MACRO REGIS
        PUSH AX
        PUSH DX
        MOV AH,2
        MOV DL,REGIS
        ADD DL,'0'
        INC REGIS
        INT 21H
        POP DX
        POP AX
    ENDM

    IMPRIME_NUMERO MACRO REGIS
        PUSH AX
        MOV AX,DX
        MOV DL,10
        XOR DH,DH
        DIV DL
        XCHG DX,AX
        MOV AH,2
        ADD DL,'0'
        INT 21H
        ROR DX,8
        ADD DL,'0'
        INT 21H
        POP AX
    ENDM

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
            MOV CX,4
        PRINT:
            LODSB
            MOV DL,AL
            ADD DL,'0'
            INT 21H
            LOOP PRINT
            ADD BX,4
            PULALINHA
            CMP BX,12
            JBE OUTRALINHA
        RET
    PRINT_MATRIX ENDP

    EXCHANGE PROC
        LEA SI,MATRIZ
        MOV CX,4
        XOR BX,BX
        TROCAR:
            MOV AL, BYTE PTR[0][SI]
            XCHG AL, BYTE PTR[BX][3]
            MOV [0][SI],AL
            ADD BX,4
            INC SI
            LOOP TROCAR
        RET
    EXCHANGE ENDP

    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX

        CALL PRINT_MATRIX
        
        CALL EXCHANGE

        PULALINHA
        CALL PRINT_MATRIX

        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
