.MODEL SMALL

.STACK 100H

.DATA

    MATRIZ DB  1, 2, 3, 4
           DB  5, 6, 7, 8
           DB  9, 0, 1, 2
           DB  3, 4, 5, 6

    MSG_LINHA DB 'A SOMA DA LINHA $'
    MSG_COLUNA DB 'A SOMA DA COLUNA $'
    MSG2 DB ' EH: $'

    N_LINHA DB 1
    N_COLUNA DB 1


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

    ;description
    SOMA_LINHA PROC
        CLD
        XOR BX,BX
        
        LEA SI,MATRIZ
        PROXIMALINHA:
            XOR DX,DX
            MOV CX,4
        SOMA:
            LODSB
            ADD DL,AL
            
            LOOP SOMA
            PUSH DX
            PULALINHA
            IMPRIME_STRING MSG_LINHA
            IMPRIME_CARACTER N_LINHA
            IMPRIME_STRING MSG2
            POP DX
            IMPRIME_NUMERO DX
            ADD BX,4
            CMP BX,12
            JBE PROXIMALINHA
        RET
    SOMA_LINHA ENDP

    SOMA_COLUNA PROC
        CLD
        LEA SI,MATRIZ
        PROXIMACOLUNA:
            XOR BX,BX
            XOR DX,DX
            MOV CX,4
        SOMACOLUNA:
            ADD DL,[BX][SI]
            ADD BX,4
            LOOP SOMACOLUNA
            PUSH DX
            PULALINHA
            IMPRIME_STRING MSG_COLUNA
            IMPRIME_CARACTER N_COLUNA
            IMPRIME_STRING MSG2
            POP DX
            IMPRIME_NUMERO DX
            INC SI
            CMP SI,3
            JBE PROXIMACOLUNA
        RET
    SOMA_COLUNA ENDP

    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX

        CALL PRINT_MATRIX

        CALL SOMA_LINHA
        CALL SOMA_COLUNA
        
        

        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
