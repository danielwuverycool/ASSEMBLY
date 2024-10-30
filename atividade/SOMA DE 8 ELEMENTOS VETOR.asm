.MODEL SMALL

.STACK 100H

.DATA

    VETOR DB 8 DUP(?)
    MSG1 DB 10,13,'VETOR: $'
    MSG2 DB 10,13,'SOMA: $'

.CODE

    LER_VALOR MACRO 
        MOV AH,1
        INT 21H
    ENDM

    ;description
    LER_VETOR PROC
        XOR SI,SI
        MOV CX,8

        LER:
            MOV AH,9
            LEA DX,MSG1
            INT 21H
            LER_VALOR
            CMP AL,13
            JE FIM
            SUB AL,30H
            MOV VETOR[SI],AL            
            INC SI
            LOOP LER

        FIM:
            RET
    LER_VETOR ENDP

    ;description
    SOMAR PROC
        XOR SI,SI
        XOR BX,BX
        MOV CX,8
        SUM:
            ADD BL,VETOR[SI]
            INC SI
            LOOP SUM
        RET
    SOMAR ENDP
    
    ;description
    IMPRIMIR_QTD PROC
        MOV CL,10
        XOR BH,BH
        MOV AX,BX
        DIV CL

        MOV DX,AX

        PUSH DX

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

    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        CALL LER_VETOR

        CALL SOMAR

        CALL IMPRIMIR_QTD

        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN
    