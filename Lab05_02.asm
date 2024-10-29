.MODEL SMALL

.CODE

    MAIN PROC
        MOV BL,'*'              ;Aloca o caractere * em BL
        MOV CX,50               ;Atribui o valor 50 no registrador CX
        MOV AH,2                ;Aloca a instrução 2 em AH

        IMPRIME1:               ;IMPRIME1 - Rótulo responsável por imprimir os caracteres * no formato de coluna
            MOV DL,10           ;Imprime o caractere 10 da tabela ASCII
            INT 21H

            MOV DL,13           ;Imprime o caractere 13 da tabela ASCII
            INT 21H

            MOV DL,BL           ;Imprime o caractere * da tabela ASCII
            INT 21H
            LOOP IMPRIME1       ;Reinicia a compilação do Rótulo até que o reiniciador chegue a zero
        
        MOV CX,50               ;Reinicia o contador. Atribuindo o valor 50

        MOV DL,10               ;Imprime o caractere 10 da tabela ASCII
        INT 21H
    
        MOV DL,13               ;Imprime o caractere 13 da tabela ASCII
        INT 21H

        IMPRIME2:               ;IMPRIME2 - Rótulo responsável por imprimir os caracteres * no formato de linha
            MOV DL,BL           ;Imprime o *
            INT 21H
            LOOP IMPRIME2       ;Reinicia o Rótulo até que o contador chege a zero

        FIM: 
            MOV AH,4CH          ;Finaliza o Programa
            INT 21H

    MAIN ENDP
END MAIN
