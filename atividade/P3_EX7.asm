.MODEL SMALL

.STACK 100H

.DATA

    VETOR DB 1,2,3,4,5,6
    MSG1 DB 10,13,'DIGITE O ELEMENTO NA QUAL QUER REMOVER: $'
    QTD DW 6

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

    IMPRIME_STRING MACRO STRING
        PUSH AX
        MOV AH,9
        LEA DX,STRING
        INT 21H
        POP AX
    ENDM
 
    PRINT_VECTOR PROC
        PULALINHA
        CLD
        MOV AH,2
        MOV CX,QTD

        PRINT:
            LODSB
            MOV DL,AL
            ADD DL,'0'
            INT 21H
            LOOP PRINT
        RET
    PRINT_VECTOR ENDP

    ;description
    REMOVE_ELEMENT PROC
        CLD
        IMPRIME_STRING MSG1
        
        MOV AH,1
        INT 21H
        SUB AL,'0'
        XOR BX,BX
        MOV CX,QTD
        LEA DI,VETOR
        SCAN:
            SCASB
            JNZ CONTINUA
                DEC CX
                MOV SI,DI
                DEC DI
                DEC WORD PTR QTD
            SUBSTITUIR:
                MOVSB
                LOOP SUBSTITUIR
                
            CONTINUA:
            CMP CX,0
            JNZ SCAN 
            RET
    REMOVE_ELEMENT ENDP

    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX

        LEA SI,VETOR
        CALL PRINT_VECTOR

        CALL REMOVE_ELEMENT

        LEA SI,VETOR
        CALL PRINT_VECTOR

        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
