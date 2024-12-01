.MODEL SMALL

.STACK 100H

.DATA

    VETOR DB 9 DUP(15),5 DUP(13),2 DUP(2)
    MSG1 DB 'A QUANTIDADE DE 15 NO VETOR EH: $'

.CODE
    FIND_15 PROC
        CLD
        XOR BX,BX
        MOV CX,10
        LEA SI,VETOR
        MOV AL,15
        FIND:
            LODSB
            CMP AL,15
            JB CONTINUA
            INC BX
        CONTINUA:
            LOOP FIND
        RET
    FIND_15 ENDP

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

        CALL FIND_15
        IMPRIME_STRING MSG1

        MOV DL,BL
        ADD DL,'0'
        MOV AH,2
        INT 21H

        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
