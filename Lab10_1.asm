.MODEL SMALL 

.STACK 100H

.DATA

    MATRIZ4X4 DB 1,2,3,4
              DB 4,3,2,1
              DB 5,6,7,8
              DB 8,7,6,5

.CODE

    PULA_LINHA MACRO 
        PUSH AX 
        PUSH DX

        MOV AH,2
        MOV DL,10
        INT 21H

        MOV AH,2
        MOV DL,13
        INT 21H

        POP DX
        POP AX

    ENDM

    ;description
    IMPRIMIR_MATRIZ PROC

        XOR BX,BX
        PUSH AX


        MOV AH,2
        

        RESET:
            MOV CX,4
            XOR SI,SI
        IMPRIME:
            MOV DL,MATRIZ4X4[BX][SI]
            ADD DL,'0'
            INT 21H
            INC SI
            LOOP IMPRIME

            ADD BX,4
            PULA_LINHA
            CMP BX,12
            JBE RESET
        
        RET

    IMPRIMIR_MATRIZ ENDP

    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        CALL IMPRIMIR_MATRIZ

        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN