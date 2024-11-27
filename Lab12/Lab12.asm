.MODEL SMALL

.STACK 100H

.DATA

    STRING1 DB 10 DUP(?)
    STRING2 DB 10 DUP(?)
    SIZE DW ?

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
    ;description
    LER_STRING PROC
        XOR BX,BX
        MOV CX,10
        MOV AH,1
        LEITURA:
            INT 21H
            CMP AL,13
            JE FIM_LE
            STOSB
            INC BX
            LOOP LEITURA
        FIM_LE:
            MOV SIZE,BX
            LEA SI,STRING1
            CALL PRINT_STRING
            RET
    LER_STRING ENDP

    ;description
    PRINT_STRING PROC
        PUSH AX    
        PUSH DX    
        MOV AH,2
        MOV CX,SIZE
        CLD
        PRINT_STR:
            LODSB
            MOV DL,AL
            INT 21H
            LOOP PRINT_STR
        
        POP AX
        POP DX 
        RET      
    PRINT_STRING ENDP

    ;description
    COPY_STRING PROC
        PUSH AX
        CLD
        REP MOVSB
        POP AX
        RET
    COPY_STRING ENDP

    ;description
    COMPARE_STRING PROC
        PUSH AX
        CLD
        REPE CMPSB
        JNZ NAO
        MOV AH,2
        MOV DL,'S'
        INT 21H
        POP AX
        RET
        NAO:
            MOV AH,2
            MOV DL,'N'
            INT 21H
            POP AX
            RET
    COMPARE_STRING ENDP

    ;description
    FIND_A PROC
        CLD
        XOR BX,BX
        MOV AL,'a'

        SCAN_A:
            SCASB
            JNZ CONTINUA
            INC BX
            CONTINUA:
            LOOP SCAN_A


        PULALINHA
        PULALINHA

        ADD BL,'0'

        MOV AH,2
        MOV DL,BL
        INT 21H
    	
        RET

    FIND_A ENDP

    ;description
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX

        CLD
        LEA DI,STRING1
        CALL LER_STRING
        LEA DI,STRING2
        LEA SI,STRING1
        MOV CX,SIZE
        CALL COPY_STRING
        LEA DI,STRING2
        LEA SI,STRING1
        MOV CX,SIZE
        CALL COMPARE_STRING
        LEA DI,STRING2
        LEA SI,STRING1
        MOV CX,SIZE
        CALL FIND_A
        

    MAIN ENDP
END MAIN
