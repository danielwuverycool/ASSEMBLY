.MODEL SMALL

.STACK 100H

.DATA
    
    VETOR DB 1,2,3,4,5,6,7              ;Vetor qualquer de 7 elementos

.CODE

    ;Procedimento para imprimir o vetor
    IMPRIME PROC
            MOV AH,2                    ;Prepara a função 2 do int 21h antes de entrar no loop
            XOR SI,SI                   ;Zera o SI
            MOV CX,7                    ;O Contador é setado em 7

        IMPRIME_VETOR:
            MOV DL,VETOR[SI]            ;Move para o registrador DL o dado do vetor do índice SI
            ADD DL,30H                  ;Converter o valor em caracter ASCII
            INT 21H                     ;Imprime o caracter nesse exato momento

            INC SI                      ;Incrementa o SI
            LOOP IMPRIME_VETOR                ;Faz o loop do rótulo IMPRIME

        RET
    IMPRIME ENDP

    ;description
    TRANSFORMA PROC
        MOV CX,3                        ;O contador é setado em 3
        
        VIRA:
            MOV AH,VETOR[SI]            ;Salva o vetor da posição do SI no Registrador AH
            MOV AL,VETOR[DI]            ;Salva o vetor da posição do DI no Registrador AL
            MOV AL,VETOR[DI]            ;Salva o vetor da posição do DI no Registrador AL
            MOV VETOR[DI],AH            ;Move o valor do vetor da posição do DI no Registrador AH
            MOV VETOR[SI],AL            ;Move o valor do vetor da posição do SI no Registrador AL
            INC SI                      ;Incrementa SI
            DEC DI                      ;Decrementa DI
            LOOP VIRA                   ;Faz um loop no Rótulo VIRA

        RET
    TRANSFORMA ENDP

    
    MAIN PROC
        MOV AX,@DATA                    ;Permite com que o .CODE acesse o .DATA
        MOV DS,AX

        XOR SI,SI                       ;Zera o registrador SI e o DI é atribuido o valor de 6
        MOV DI,6

        CALL TRANSFORMA



        CALL IMPRIME

    MAIN ENDP
END MAIN 