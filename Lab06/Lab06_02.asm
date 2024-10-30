.MODEL SMALL

.DATA
    MSG DB 'DIGITE AQUI:$'

.CODE
    MAIN PROC
        MOV AX,@DATA            ;Permite com que o código acesse os valores definidos em .DATA
        MOV DS,AX

        MOV CX,-1               ;Aloca ao registrador CX o valor -1 (o contador conta o caractere CR)

        MOV AH,9
        LEA DX,MSG              ;Imprime a mensagem localizada no .DATA
        INT 21H

        MOV AH,1                ;Prepara o Registrador AH com a função 1 do Int 21h

        REPEAT:
            INC CX              ;Incrementa o contador
            INT 21H
            
            CMP AL,13           ;Compara o caractere digitado com o caracter CR
        
            JE IMPRIME          ;Enquanto não seja verdadeiro, retorna ao label WHILE e repete até que seja verdadeiro
            JMP REPEAT       
        
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

;EM RESUMO:

;Esse programa é diferente do primeiro já que a sua forma de repetir o programa é diferente. Enquanto o primeiro é de retornar ao rótulo 
;quando a declaração for verdadeira, o segundo repete até que a declaração esteja verdadeira.