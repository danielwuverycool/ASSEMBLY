.MODEL SMALL

.STACK 100H

.DATA

    MATRIZ DW  2, 2, 3, 1
           DW  5, 6, 7, 8
           DW  9,0,1,2
           DW  3,4,5,6
    MSG1 DB 'O MENOR VALOR EH: $'
    MSG2 DB 10,13,'O MAIOR VALOR EH: $'

.CODE
    IMPRIME_CARACTER MACRO REGIS
        PUSH AX
        PUSH DX
        MOV AH,2
        MOV DL,REGIS
        ADD DL,'0'
        INT 21H
        POP DX
        POP AX
    ENDM
    COMPARE_MENOR PROC
        CLD
        XOR BX,BX
        LEA SI,MATRIZ
        MOV DX,WORD PTR [0][SI]
        OUTRALINHA_MENOR:
            MOV CX,4
            ADD BX,8
            
        FIND_MENOR:
            LODSW
            CMP DX,AX;DX=MENOR
            JB CONTINUA_MENOR
            MOV DX,AX
        CONTINUA_MENOR:
            LOOP FIND_MENOR
            CMP BX,24
            JNE OUTRALINHA_MENOR
            RET
    COMPARE_MENOR ENDP

    COMPARE_MAIOR PROC
        CLD
        XOR BX,BX
        LEA SI,MATRIZ
        MOV DX,WORD PTR [0][SI]
        OUTRALINHA_MAIOR:
            MOV CX,4
            ADD BX,8
            
        FIND_MAIOR:
            LODSW
            CMP DX,AX;DX=MENOR
            JA CONTINUA_MAIOR
            MOV DX,AX
        CONTINUA_MAIOR:
            LOOP FIND_MAIOR
            CMP BX,24
            JNE OUTRALINHA_MAIOR
            RET
    COMPARE_MAIOR ENDP

    IMPRIME_STRING MACRO STRING
        PUSH AX
        PUSH DX
        MOV AH,9
        LEA DX,STRING
        INT 21H
        POP DX
        POP AX
    ENDM
    

    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX

        CALL COMPARE_MENOR

        IMPRIME_STRING MSG1
        IMPRIME_CARACTER DL

        CALL COMPARE_MAIOR
        
        IMPRIME_STRING MSG2
        IMPRIME_CARACTER DL


        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
