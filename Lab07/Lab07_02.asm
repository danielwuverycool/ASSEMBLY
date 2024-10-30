.MODEL SMALL

.DATA   
    MSG1 DB 'Digite o Multiplicando: $'
    MSG2 DB 10,13,'Digite o Multiplicador: $'
    MSG3 DB 10,13,'Produto: $'

.CODE
    MAIN PROC
        MOV AX,@DATA            ;Permite com que possa acessar o .DATA
        MOV DS,AX


        MOV AH,9
        LEA DX,MSG1             ;Imprime a primeira string
        INT 21H

        MOV AH,1                ;Permite com que voce possa digitar um caractere
        INT 21H 
        MOV BL,AL 
        SUB BL,'0'              ;Subtrai o caractere digitado pelo caractere 0
        

        MOV AH,9
        LEA DX,MSG2             ;Imprime a segunda string
        INT 21H

        MOV AH,1                ;Permite com que voce possa digitar um caractere        
        INT 21H
        MOV CL,AL
        SUB CL,'0'              ;Subtrai o caractere digitado pelo caractere 0

        MOV AL,BL               ;Salva o multiplicador em AL

        MULTIPLICA:
            CMP CL,1            ;Compara se CL é 1 e pula o rótulo se for menor ou igual a ele
            JBE FIM

            ADD BL,AL           ;Adiciona AL a BL
            DEC CL
            JMP MULTIPLICA      ;Retorna ao MULTIPLICA

        FIM:       
            ADD CL,'0'          ;Converte os registradores em caracteres de número
            ADD BL,'0'

            MOV AH,9
            LEA DX,MSG3         ;Imprime a terceira string
            INT 21H

            MOV AH,2
            MOV DL,BL           ;Imprime o caractere
            INT 21H

            MOV AH,4CH          ;Fim do programa
            INT 21H

    MAIN ENDP
END MAIN
