.MODEL SMALL

.STACK 100H

.DATA

    VETOR DB 1,2,3,4,5
    VETOR_COPY DB 5 DUP(?)
    K DW 3
    MSG1 DB 'DIGITE K: $'

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

    IMPRIME_STRING MACRO MSG1
        PUSH AX
        MOV AH,9
        LEA DX,MSG1
        INT 21H
        POP AX
    ENDM
 
    PRINT_VECTOR PROC
        PULALINHA
        CLD
        MOV AH,2
        MOV CX,5

        PRINT:
            LODSB
            MOV DL,AL
            ADD DL,'0'
            INT 21H
            LOOP PRINT
        RET
    PRINT_VECTOR ENDP

    ADQUIRE_K PROC
        PULALINHA
        IMPRIME_STRING MSG1
        MOV AH,1
        INT 21H
        AND AX,000FH
        MOV K,AX
        RET
    ADQUIRE_K ENDP

    STORE_VECTOR PROC
        CLD
        REP MOVSB
        
        RET
    STORE_VECTOR ENDP

    COPY_VECTOR PROC
        CLD

        LEA SI,VETOR
        LEA DI,VETOR_COPY
        
        MOV CX,5
        
        REP MOVSB
        
        RET
    COPY_VECTOR ENDP

    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX

        LEA SI,VETOR
        CALL PRINT_VECTOR

        CALL ADQUIRE_K

        LEA SI,VETOR
        LEA DI,VETOR_COPY
        CALL COPY_VECTOR

        LEA SI,VETOR
        LEA DI,VETOR_COPY
        MOV CX,5
        SUB CX,K
        ADD DI,K
        CALL STORE_VECTOR

        
        XOR CX,CX
        XCHG CX,K
        LEA DI,VETOR_COPY
        CALL STORE_VECTOR

        LEA SI,VETOR_COPY
        CALL PRINT_VECTOR

        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
