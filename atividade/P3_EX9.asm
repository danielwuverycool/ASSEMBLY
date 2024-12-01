.MODEL SMALL

.STACK 100H

.DATA
    MSG1 DB 'DIGITE QUANTOS NUMEROS QUER QUE APARECA NO FIBONACCI: $'
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

    IMPRIME_NUMERO PROC
        PUSH AX
        MOV AX,DX
        MOV DL,10
        XOR DH,DH
        DIV DL
        XCHG DX,AX
        MOV AH,2
        ADD DL,'0'
        INT 21H
        SUB DL,'0'
        ROR DX,8
        ADD DL,'0'
        INT 21H
        SUB DL,'0' ;DX 0301

        CMP DL,0
        JNZ FIM

        MOV AL,10
        MUL DL
        ADD AL,DH
        MOV DX,AX

        FIM:

        POP AX

        RET
    IMPRIME_NUMERO ENDP
 
    ;description
    FIBONACCI PROC
        XOR DX,DX
        MOV BX,1
        IMPRIME_STRING MSG1

        MOV AH,1
        INT 21H
        AND AX,000FH
        MOV CL,AL

        XOR AX,AX

        FIBONACCI_SUM:
            PULALINHA
            CALL IMPRIME_NUMERO
            MOV AX,DX
            ADD DX,BX
            MOV BX,AX
            LOOP FIBONACCI_SUM

            RET

    FIBONACCI ENDP

    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        CALL FIBONACCI

        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
