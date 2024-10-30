.MODEL SMALL

.STACK 100H

.DATA
    VETOR DB 20 DUP(?)
    MSG1 DB 'DIGITE: $'
    MSG2 DB 10,13,'QTD DE VOGAIS: $'

.CODE
    ;description
    DETECTAR_VOGAL PROC
        CMP AL,'A'
        JE INCREMENTAR
        CMP AL,'E'
        JE INCREMENTAR
        CMP AL,'I'
        JE INCREMENTAR
        CMP AL,'O'
        JE INCREMENTAR
        CMP AL,'U'
        JE INCREMENTAR
        CMP AL,'a'
        JE INCREMENTAR
        CMP AL,'e'
        JE INCREMENTAR
        CMP AL,'i'
        JE INCREMENTAR
        CMP AL,'o'
        JE INCREMENTAR
        CMP AL,'u'
        JE INCREMENTAR

        RET
        INCREMENTAR:
            INC BL

        RET
    DETECTAR_VOGAL ENDP

    ;description
    DIGITAR PROC
        MOV AH,1
        XOR SI,SI
        MOV CX,20

        DIGITE:
            INT 21H

            CALL DETECTAR_VOGAL

            CMP AL,13
            JE FIM

            MOV AL,VETOR[SI]
            INC SI
            LOOP DIGITE

        FIM:
            RET
    DIGITAR ENDP

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

        XOR BL,BL
        MOV AH,9
        LEA DX,MSG1
        INT 21H

        CALL DIGITAR

        CALL IMPRIMIR_QTD

        MOV AH,4CH
        INT 21H
    MAIN ENDP
END MAIN

