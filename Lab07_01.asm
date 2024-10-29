.MODEL SMALL

.DATA   
    MSG1 DB 'Digite o Dividendo: $'
    MSG2 DB 10,13,'Digite o Divisor: $'
    MSG3 DB 10,13,'Quociente: $'
    MSG4 DB 10,13,'Resto: $'

.CODE
    MAIN PROC
        MOV AX,@DATA            ;Permite com que possa acessar o .DATA
        MOV DS,AX

        XOR CL,CL               ;Zera o contador CL

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
        MOV BH,AL
        SUB BH,'0'              ;Subtrai o caractere digitado pelo caractere 0

        DIVIDE:
            SUB BL,BH           ;Subtrai o dividendo pelo divisor até que o dividendo seja mendor que o divisor e contando cada processo
            INC CL
            CMP BL,BH
            JAE DIVIDE

            ADD CL,'0'          ;Converte os dados dos registradores em caracteres ASCII
            ADD BL,'0'

            MOV AH,9
            LEA DX,MSG3         ;Imprime a terceira string
            INT 21H

            MOV AH,2
            MOV DL,CL           ;Imprime o Quociente
            INT 21H

            MOV AH,9
            LEA DX,MSG4         ;Imprime a quarta string
            INT 21H

            MOV AH,2
            MOV DL,BL           ;Imprime o Resto
            INT 21H

            MOV AH,4CH          ;Fim do programa
            INT 21H            

    MAIN ENDP
END MAIN
