TITLE PROGRAMA EXEMPLO PARA MANIPULAÇÃO DE VETORES USANDO BX

.MODEL SMALL

.DATA

    VETOR DB 1, 1, 1, 2, 2, 2
    
.CODE

    ;Procedimento para imprimir a funcao
    VOLTA_PROC PROC
        MOV CX,6                ;Configura o contador para 6
        MOV AH, 02          ;Imprime o número do vetor

        VOLTA:
            MOV DL, VETOR[DI]        ;Passa o Conteúdo do endereço de SI para DL
            INC DI              ;Incrementa o SI

            ADD DL, 30H         ;Converte o DL em número do caractere ASCII

            INT 21H
            LOOP VOLTA
        
    RET    
    VOLTA_PROC ENDP

    MAIN PROC
        MOV AX, @DATA           ;Permite com que o .CODE acesse o .DATA
        MOV DS,AX

        XOR DL, DL              ;Zera o registrador DL
        XOR DI,DI               ;Zera o DI

        CALL VOLTA_PROC

        MOV AH,4CH          ;Finaliza o programa
        INT 21H 
    MAIN ENDP
END MAIN
