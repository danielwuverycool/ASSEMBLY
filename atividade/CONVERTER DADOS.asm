.MODEL SMALL

.STACK 100H

.DATA
    SAVE DW ?
    STRING1 DB 'DIGITE UM NUMERO (0-255): $'
    STRING2 DB 10,13,'HEXADECIMAL: $'
    STRING3 DB 10,13,'OCTAL: $'
    STRING4 DB 10,13,'BINARIO: $'


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
            MOV SAVE,CX
            RET
        
    INPUT ENDP

    ;description
    HEX PROC
        MOV AH,9
        LEA DX,STRING2
        INT 21H
        MOV BX,SAVE
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
        MOV AH,9
        LEA DX,STRING3
        INT 21H
        MOV BX,SAVE
        XOR BH,BH
        XOR DH,DH
        MOV DL,BH
        MOV AH,2
        MOV CX,5

        ARMAZENA:
            ROR BX,3
            MOV DL,BH
            SHR DL,5
            PUSH DX
            LOOP ARMAZENA

        MOV CX,5

        PRINT:
            POP DX
            ADD DL,'0'
            INT 21H
            LOOP PRINT

        RET


    OCTO ENDP

    ;description
    BINARY PROC
        MOV AH,9
        LEA DX,STRING4
        INT 21H
        MOV AH,2
        MOV CX,15

        IMPRIMIR:
            SHL BX,1
            JNC ZERO

            MOV DL,'1'
            INT 21H

            LOOP IMPRIMIR
            JMP ENDING

        ZERO:
            MOV DL,'0'
            INT 21H

            LOOP IMPRIMIR

        ENDING:
            RET

    BINARY ENDP

    PULALINHA MACRO 
        PUSH AX
        PUSH DX

        MOV AH,2
        MOV DL,10
        INT 21H

        MOV AH,2
        MOV DL,13
        INT 21H

        POP AX
        POP DX
    ENDM

    ;description
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX

        CALL INPUT

        CALL HEX
        PULALINHA
        CALL OCTO
        PULALINHA
        CALL BINARY

        MOV AH,4CH
        INT 21H

    MAIN ENDP

END MAIN