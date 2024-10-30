.MODEL SMALL

.STACK 100H

.DATA
    MSG1 DB 'DIGITE AQUI (MAX 20):$'
    MSG2 DB 10,13,'A QUANTIDADE DE VOGAIS A EH:$'

.CODE
    ;DIGITAR STRING
    DIGITE PROC
        XOR BL,BL
        MOV CX,20
        MOV AH,1


        DIGITAR: 
            INT 21H

            CMP AL,'A'
            JE INCREMENTAR

            CMP AL,'a'
            JE INCREMENTAR

            CMP AL,13
            JE FINAL

            LOOP DIGITAR

            RET

            INCREMENTAR:
            INC BL
            LOOP DIGITAR
        FINAL:
            RET
    DIGITE ENDP

    ;IMPRIME 
    IMPRIME PROC
        ADD BL,30H
        MOV AH,9
        LEA DX,MSG2
        INT 21H

        MOV AH,2
        MOV DL,BL
        INT 21H

        RET
    IMPRIME ENDP

    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        MOV AH,9
        LEA DX,MSG1
        INT 21H

        CALL DIGITE

        CALL IMPRIME

        MOV AH,4CH
        INT 21H

    MAIN ENDP
END MAIN