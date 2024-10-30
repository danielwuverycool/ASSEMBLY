.MODEL SMALL

.DATA 

    Y DB ?                      ;Variável Y (não declarado)

.CODE

    MAIN PROC
        MOV AX,@DATA            ;Permite com que o programa possa acessar as variáveis contidas em .DATA
        MOV DS,AX 
        MOV CX,26               ;É atribuido o valor 26 para o contador 
        MOV Y,'a'               ;Atribui o caractere a na variável Y
        MOV AH,2                ;Aloca a função 2 para o AH

        IMPRIME1:               ;IMPRIME1 - Responsável por imprimir o alfabeto em minúsculo
            MOV DL,Y            ;Imprime o caractere Y
            INT 21H    

            INC Y               ;Incrementa Y e reinicia o Rótulo até que o contador chegue em zero
            LOOP IMPRIME1

        MOV CX,26
        MOV Y,'A'               ;Atribui o caractere A na variável Y

        MOV DL,13
        INT 21H
                                ;Imprime valores que representa a quebra da linha
        MOV DL,10
        INT 21H

        IMPRIME2:               ;IMPRIME2 - Responsável por imprimir o alfabeto em maiúsculo
            MOV DL,Y            ;Imprime o caractere Y
            INT 21H      
                  
            INC Y               ;Incrementa Y e reinicia o Rótulo até que o contador chegue em zero
            LOOP IMPRIME2

        FIM: 
            MOV AH,4CH          ;Finaliza o Programa
            INT 21H

    MAIN ENDP
END MAIN
