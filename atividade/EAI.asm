.MODEL SMALL

.STACK 100H

.DATA
    MATRIZ DB '1','0','0','0'
           DB '0','6','0','0'
           DB '0','0','3','0'
           DB '0','0','0','4'
           
.CODE
    ;description
    LER_MATRIZ PROC
        XOR BX,BX
        XOR SI,SI   

        MOV CX,4
        MOV AH,1

        LER:
            INT 21H
            MOV MATRIZ[BX][SI],AL
            INC SI
            ADD BX,4
            LOOP LER

        RET
    LER_MATRIZ ENDP

    ;description
    IMPRIMIR PROC
        MOV CX,4
        XOR BX,BX
        XOR SI,SI
        MOV AH,2
        MOV DL,10
        INT 21H
        MOV DL,13
        INT 21H
        JMP IMPRIME

        PULALINHA:
            ADD BX,4
            XOR SI,SI
            MOV CX,4
            MOV DL,10
            INT 21H
            MOV DL,13
            INT 21H

        IMPRIME:
            MOV DL,MATRIZ[BX][SI]
            INT 21H
            INC SI
            LOOP IMPRIME
            CMP BX,12
            JB PULALINHA

            RET
    IMPRIMIR ENDP

    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        CALL IMPRIMIR

        CALL LER_MATRIZ

        CALL IMPRIMIR

        MOV AH,4CH
        INT 21H

    MAIN ENDP
END MAIN