.MODEL SMALL

.DATA
    MSG DB 10,13,'DIGITE UM NUMERO:$'
    RESULTADO DB 10,13,'RESULTADO=$'

.CODE
    MAIN PROC
        MOV AX,@DATA            ;Permite com que o programa possa acessar as variáveis contidas em .DATA
        MOV DS,AX
        
        MOV CX,5                ;É configurado no contador o valor de 5
        MOV BL,30h              ;Aloca o caractere 0 para o registrador BL

        RECEBA:                 ;RECEBA - Rótulo responsável por receber o valor digitado pelo usuário
            MOV AH,9            ;Imprime a String MSG
            LEA DX,MSG
            INT 21H

            MOV AH,1            ;Pede para que você insira um número
            INT 21H

            ADD BL,AL           ;Adiciona o valor inserido com o BL
            SUB BL,30h          ;Subtrai o BL para conseguir o novo valor

            LOOP RECEBA         ;Repete o Rótulo

        MOV AH,9                ;Imprime a String RESULTADO
        LEA DX,RESULTADO
        INT 21H
        MOV AH,2                ;Imprime o valor final depois das somas
        MOV DL,BL
        INT 21H
        
        FIM:

            MOV AH,4CH          ;Finaliza o Programa
            INT 21H

    MAIN ENDP
END MAIN