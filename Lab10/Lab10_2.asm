.MODEL SMALL 

.STACK 100H

.DATA

    MATRIZ DB 4 DUP(?)
           DB 4 DUP(?)            
           DB 4 DUP(?)
           DB 4 DUP(?)

    MSG2 DB 'SOMA: $'

.CODE

    PULALINHA MACRO params ;MACRO PRA PULAR LINHA
        PUSH AX
        PUSH DX
        MOV AH,2
        MOV DL,10
        INT 21H        
        MOV DL,13
        INT 21H
        
        POP DX       
        POP AX 
    ENDM

    ;ENTRADA:VOID SAÍDA:VOID
    LER PROC    ;PROCEDIMENTO PARA LER MATRIZ
        MOV AH,1
        XOR BX,BX;ZERA BX E DX
        XOR DX,DX


        RESET:
            XOR SI,SI ;ZERA SI
            MOV CX,4;CX VIRA 4

        DIGITE:
            
            INT 21H
            AND AL,0FH;CONVERTE AL EM NUMERO
            ADD DL,AL;ADICIONA DL COM AL
            MOV MATRIZ [BX][SI],AL ;ALOCA AL PARA A MATRIZ
            
            INC SI
            LOOP DIGITE
            ADD BX,4
            CMP BX,12
            JBE RESET

            MOV BX,DX

            CALL IMPRIMIR_QTD
            RET

    LER ENDP

    ;description
    IMPRIMIR_MATRIZ PROC
        XOR DH,DH
        MOV AH,2
        XOR BX,BX

        REINICIAR:
            PULALINHA
            XOR SI,SI
            MOV CX,4

        DIGITAR:
            MOV DL,MATRIZ [BX][SI]
            ADD DL,'0'
            INT 21H
            
            INC SI
            LOOP DIGITAR
            ADD BX,4
            CMP BX,12
            JBE REINICIAR
            RET
    IMPRIMIR_MATRIZ ENDP

    IMPRIMIR_QTD PROC
        MOV CL,10
        XOR BH,BH
        MOV AX,BX
        DIV CL

        MOV DX,AX

        PUSH DX

        PULALINHA

        MOV AH,9
        LEA DX,MSG2
        INT 21H

        POP DX

        


        MOV AH,2
        ADD DL,'0'
        INT 21H

        ROR DX,8

        ADD DL,'0'
        INT 21H
        RET
    IMPRIMIR_QTD ENDP

    ;description
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        CALL LER

        PULALINHA

        CALL IMPRIMIR_MATRIZ

        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN