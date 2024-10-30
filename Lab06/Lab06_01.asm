.MODEL SMALL

.DATA
    MSG DB 'DIGITE AQUI:$'

.CODE
    MAIN PROC
        MOV AX,@DATA            ;Permite com que o código acesse os valores definidos em .DATA
        MOV DS,AX

        XOR CX,CX               ;Zera o registrador CX

        MOV AH,9
        LEA DX,MSG              ;Imprime a mensagem localizada no .DATA
        INT 21H

        MOV AH,1                ;Prepara o Registrador AH com a função 1 do Int 21h

        WHILE:
            INC CX              ;Incrementa o contador
            INT 21H
            
            CMP AL,13           ;Compara o caractere digitado com o caracter CR
        
            JNE WHILE           ;Enquanto está verdadeiro a declaração, é retornado ao label WHILE
            SUB CX,1            ;Subtrai o contador por 1 pois ele conta o caractere CR
        
        IMPRIME:
            MOV AH,2            ;Prepara o AH com a função 2 do Int 21h
            MOV DL,'*'          ;A partir disso, imprime o caractere *
            INT 21H
            LOOP IMPRIME        ;Repete o rótulo IMPRIME até que o registrador zere
        
        FIM:
            MOV AH,4CH          ;Finaliza o programa
            INT 21H

    MAIN ENDP
END MAIN