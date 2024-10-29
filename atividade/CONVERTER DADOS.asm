.MODEL SMALL

.STACK 100H

.DATA
    STRING1 DB 'DIGITE: $'


.CODE

    ;description
    INPUT PROC


        MOV AH,9
        LEA DX,STRING1
        INT 21H
        
        XOR AL,AL
        XOR DL,DL
        XOR CL,CL

        MOV BL,10
        DIGITE:
            MOV DL,AL
            MOV AL,CL

            MOV AH,1
            INT 21H
            CMP AL,13
            JE FIM
            SUB AL,30h
            ADD AL,DL
            MOV CL,AL
            MUL BL
           
            JMP DIGITE

            
            
        FIM:
            MOV BX,CX
            RET
        
    INPUT ENDP

    ;description
    HEX PROC
        MOV AH,2
        MOV CX,4
        IMPRIME:

            MOV DL,BH

            SHR DL,4    
            CMP DL,10
            JAE LETRA
            
            ADD DL,'0'
            INT 21H
            JMP FINAL

        LETRA:
        
            ADD DL,'A'
            SUB DL,10
            INT 21H

        FINAL:
            ROL BX,4
            LOOP IMPRIME

        RET

    HEX ENDP

    ;description
    OCTO PROC
        MOV CX,5
        SHL BX,3
    OCTO ENDP

    ;description
    BINARY PROC
        MOV AH,2
        MOV CX,16
        IMPRIMIR:
            SHL BX,1
            JNC ZERO

            MOV DL,'1'
            INT 21H

            DEC CX

            CMP CX,0
            JNZ IMPRIMIR

        ZERO:
            MOV DL,'0'
            INT 21H

            DEC CX

            CMP CX,0
            JNZ IMPRIMIR
        RET

    BINARY ENDP

    ;description
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        CALL INPUT
        CALL HEX

        MOV AH,4CH
        INT 21H

    MAIN ENDP

END MAIN