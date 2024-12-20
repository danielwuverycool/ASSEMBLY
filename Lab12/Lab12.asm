.MODEL SMALL

.STACK 100H

.DATA

    STRING1 DB 10 DUP(?)
    STRING2 DB 10 DUP(?)
    SIZE DW ?

.CODE
    PULALINHA MACRO ;MACRO PARA PULAR LINHA
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
    LER_STRING PROC ;PROCEDIMENTO PARA LER A STRING
        XOR BX,BX
        MOV CX,10   ;CONTADOR=10
        MOV AH,1
        LEITURA:
            INT 21H ;USUARIO DIGITA
            CMP AL,13 ;COMPARA O QUE DIGITOU COM ENTER
            JE FIM_LE  ;PULA SE FOR IGUAL
            STOSB   ;ARMAZENA O QUE FOI DIGITADO EM DI
            INC BX  ;INCREMENTA BX
            LOOP LEITURA    
        FIM_LE:
            MOV SIZE,BX ;ARMAZENA BX EM TAMANHO
            LEA SI,STRING1 
            CALL PRINT_STRING ;IMPRIME STRING
            RET
    LER_STRING ENDP

    PRINT_STRING PROC;PROCEDIMENTO QUE IMPRIME STRING
        PUSH AX    ;AX E DX ARMAZENADO EM SP
        PUSH DX    
        MOV AH,2    ;AH É PREPARADO PARA IMPRIMIR O CARACTER
        MOV CX,SIZE ;CONTADOR=TAMANHO DA STRING
        CLD ;ORDENACAO CRESCENTE 
        PRINT_STR:
            LODSB;CARREGA A STRING EM AL
            MOV DL,AL
            INT 21H
            LOOP PRINT_STR
        
        POP AX ;SP RETORNA OS VALORES DE AX E DX
        POP DX 
        RET      
    PRINT_STRING ENDP

    COPY_STRING PROC ;PROCEDIMENTO PARA COPIAR A STRING
        PUSH AX ;SALVA AX EM SP
        CLD;DIRECAO CRESCENTE DA STRING
        REP MOVSB;REPETE MOVSB ATÉ O CONTADOR FICAR ZERO
        POP AX ;SP RETORNA AX ANTIGO
        RET
    COPY_STRING ENDP

    COMPARE_STRING PROC ;PROCEDIMENTO PARA COMPARAR STRING
        PUSH AX ;SALVA EM SP AX
        CLD ;DIRECAO CRESCENTE DA STRING
        REPE CMPSB;REPETE O CMPSB SE FOR IGUAL
        PULALINHA
        JNZ NAO;SE NAO FOR IGUAL IRA PARA A LABEL NAO
        MOV AH,2;SE SIM IMPRIME S
        MOV DL,'S'
        INT 21H
        POP AX;RETORNA DE SP O AX
        RET
        NAO:
            MOV AH,2
            MOV DL,'N';IMPRIME N
            INT 21H
            POP AX;RETORNA DE SP O AX
            RET
    COMPARE_STRING ENDP

    ;description
    FIND_A PROC ;PROCEDIMENTO PARA ACHAR a NA STRING
        CLD;SENTIDO CRESCENTE DA STRING
        XOR BL,BL;ZERA BX
        MOV AL,'a';AL É ALOCADO O a

        SCAN_A:
            SCASB;SCANEIA A STRING PROCURANDO a
            JNZ CONTINUA;SE FOR DIFERENTE CONTINUA
            INC BL;SE NAO INCREMENTA
            CONTINUA:
            LOOP SCAN_A;FAZ LOOP DO SCAN


        PULALINHA
        PULALINHA

        ADD BL,'0' ;CONVERTE O VALOR EM NUMERO

        MOV AH,2
        MOV DL,BL;IMPRIME O NUMERO
        INT 21H
    	
        RET

    FIND_A ENDP

    ;description
    MAIN PROC
        MOV AX,@DATA;AX É ALOCADO OS DADOS DECLARADOS EM .DATA
        MOV DS,AX;É PERMITIDO COM QUE O SEGMENTO DE DADOS ACESSE O .DATA
        MOV ES,AX;É PERMITIDO COM QUE O SEGMENTO EXTRA ACESSE O .DATA
        CLD
        LEA DI,STRING1 ;DI RECEBE O OFFSET DA STRING1
        CALL LER_STRING ;CHAMA O PROCEDIMENTO DE LER STRING
        LEA DI,STRING2 ;DI RECEBE O OFFSET DA STRING2
        LEA SI,STRING1 ;DI RECEBE O OFFSET DA STRING1
        MOV CX,SIZE ;CONTADOR É ALOCADO O TAMANHO
        CALL COPY_STRING ;CHAMA O PROCEDIMENTO DE COPIAR A STRING
        MOV CX,SIZE ;CONTADOR É ALOCADO O TAMANHO
        CALL COMPARE_STRING ;CHAMA O PROCEDIMENTO DE COMPARAR STRING
        LEA DI,STRING2 ;DI RECEBE O OFFSET DA STRING2
        MOV CX,SIZE ;CONTADOR É ALOCADO O TAMANHO
        CALL FIND_A
        MOV AH,4CH
        INT 21H

    MAIN ENDP
END MAIN
