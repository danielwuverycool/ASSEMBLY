.MODEL SMALL

.STACK 100H

.CODE
    MAIN PROC

        MOV CX,4                    ;É atribuido o valor 4 para o contador 
        MOV BX,26
        MOV AH,2                    ;Aloca a função 2 para o AH
        MOV BL,'a'                  ;Atribuido a BL o caractere a

        PULALINHA:                  ;PULALINHA - Rótulo responsável por pular linha
            MOV CX,4                ;Reinicia o contador
            MOV DL,10               
            INT 21H
                                    ;Imprime a próxima linha
            MOV DL,13
            INT 21H
            
            IMPRIME:                ;IMPRIME - Rótulo responsável por imprimir o alfabeto
            
                MOV DL,BL           ;Imprime o caractere alocado em BL
                INT 21H            
                INC BL              ;Incrementa BL

                CMP BL,'z'          ;Compara BL com z e irá pular se for maior que o mesmo
                JA FIM
                LOOP IMPRIME        ;Reinicia o Rótulo IMPRIME

            LOOP PULALINHA          ;Reinicia o Rótulo PULALINHA

        FIM:
            MOV AH,4CH              ;Finaliza o Programa
            INT 21H

    MAIN ENDP
END MAIN
