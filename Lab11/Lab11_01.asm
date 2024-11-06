.MODEL SMALL

.STACK 100H

.DATA

    ENTRADA DB 'ESCOLHA A ENTRADA:$' 
    SAIDA DB 'ESCOLHA A SAIDA:$' 
    BINARIO DB 10,13, '1.BINARIO$'
    HEXADECIMAL DB 10,13, '2.HEXADECIMAL$'
    DECIMAL DB 10,13,'3.DECIMAL$'
    DIGITE DB 10,13, 'DIGITE: $'
    SAVE DW 0

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

    IMPRIME_STRING MACRO STRING

    PUSH AX

    MOV AH,9

    LEA DX,STRING
    INT 21H

    POP AX
    ENDM

    IMPRIME_TABELA MACRO STRING1,STRING2,STRING3,STRING4

        IMPRIME_STRING STRING1
        IMPRIME_STRING STRING2
        IMPRIME_STRING STRING3
        IMPRIME_STRING STRING4

        
    ENDM

    ;description
    COMPARA_ENTRADA PROC
        KOMPARA:
            MOV AH,1
            INT 21H
            SUB AL,31H
            CMP AL,3
            JAE KOMPARA
            CMP AL,0
            JE DIGITAR_BINARIO
            CMP AL,1
            JE DIGITAR_HEXADECIMAL
            CALL INPUT_DECIMAL
            RET
            DIGITAR_BINARIO:
                CALL INPUT_BINARIO
                RET

            DIGITAR_HEXADECIMAL:
                CALL INPUT_HEXADECIMAL
                RET

    COMPARA_ENTRADA ENDP

    ;description
    INPUT_HEXADECIMAL PROC
        MOV AH,9
        LEA DX,HEXADECIMAL
        INT 21H
        LEA DX,DIGITE
        INT 21H

        MOV AH,1
        
        DIGITE_H:
            SHL BX,4
            INT 21H
            CMP AL,13
            JE FINAL_H
            CMP AL,'A'
            JAE CARACTERE_H
            CMP AL,'0'
            JAE NUMERO_H
            OR BL,AL
            
        
        NUMERO_H:
            SUB AL,'0'
            JMP CONVERTE_H
        
        CARACTERE_H:
            SUB AL,'A'
            ADD AL,10
        
        CONVERTE_H:
            OR BL,AL
            

            LOOP DIGITE_H

            MOV SAVE,BX

        FINAL_H:
            RET
        
    INPUT_HEXADECIMAL ENDP

    ;description
    INPUT_BINARIO PROC
        MOV AH,9
        LEA DX,BINARIO
        INT 21H
        LEA DX,DIGITE
        INT 21H

        MOV AH,1
        DIGITAR_B:
            INT 21H
            CMP AL,13
            JE FINAL_B
            AND AL,0FH

            SHL BX,1
            OR BL,AL

            LOOP DIGITAR_B
            MOV SAVE,BX

        FINAL_B:
            RET
    INPUT_BINARIO ENDP

    INPUT_DECIMAL PROC
        MOV AH,9
        LEA DX,DECIMAL
        INT 21H
        LEA DX,DIGITE
        INT 21H
        
        XOR AL,AL
        XOR DL,DL
        XOR CL,CL

        MOV BL,10

        DIGITAR:
            MOV DL,AL

            MOV AH,1
            INT 21H
            CMP AL,13
            JE FIM
            SUB AL,30h
            ADD AL,DL
            MOV CL,AL
            MUL BL
           
            JMP DIGITAR
            
        FIM:
            MOV SAVE,CX
            RET
        
    INPUT_DECIMAL ENDP

    COMPARA_SAIDA PROC
        COMP:
            MOV AH,1
            INT 21H
            SUB AL,31H
            CMP AL,3
            JAE COMP
            CMP AL,0
            JE TRADUZ_BINARIO
            CMP AL,1
            JE TRADUZ_HEXADECIMAL
            CALL TRANSLATE_DECIMAL
            RET
            TRADUZ_BINARIO:
                CALL TRANSLATE_BINARIO
                RET

            TRADUZ_HEXADECIMAL:
                CALL TRANSLATE_HEXADECIMAL
                RET

    COMPARA_SAIDA ENDP

    ;description
    TRANSLATE_BINARIO PROC

        PULALINHA

        MOV CX,16

        MOV AH,2

        MOV BX,SAVE

        ROTATE_B:
            ROL BX,1
            JNC ZERO

        UM:
            MOV DL,'1'
            INT 21H
            JMP LUPE_B

        ZERO:
            MOV DL,'0'
            INT 21H
        
        LUPE_B:
            LOOP ROTATE_B

        RET
    TRANSLATE_BINARIO ENDP

    ;description
    TRANSLATE_HEXADECIMAL PROC

        PULALINHA
        
        MOV BX,SAVE
        MOV AH,2
        MOV CX,4

        IMPRIME_HEX:
            MOV DL,BH
            SHR DL,4    
            CMP DL,10
            JAE LETRA_HEX
            
            ADD DL,'0'
            INT 21H
            JMP FINAL_HEX

        LETRA_HEX:
            ADD DL,'A'
            SUB DL,10
            INT 21H

        FINAL_HEX:
            ROL BX,4
            LOOP IMPRIME_HEX
        
        RET

    TRANSLATE_HEXADECIMAL ENDP

    ;description
    TRANSLATE_DECIMAL PROC
        
        
        MOV CL,10
        XOR BH,BH
        MOV AX,SAVE
        DIV CL

        MOV DX,AX

        PUSH DX

        PULALINHA


        POP DX

        


        MOV AH,2
        ADD DL,'0'
        INT 21H

        ROR DX,8

        ADD DL,'0'
        INT 21H
        RET

    TRANSLATE_DECIMAL ENDP

    ;description
    MAIN PROC
      MOV AX,@DATA
      MOV DS,AX

    IMPRIME_STRING ENTRADA
    IMPRIME_TABELA BINARIO,HEXADECIMAL,DECIMAL,DIGITE
    
    CALL COMPARA_ENTRADA

    IMPRIME_STRING SAIDA
    IMPRIME_TABELA BINARIO,HEXADECIMAL,DECIMAL,DIGITE

    CALL COMPARA_SAIDA

    MOV AH,4CH
    INT 21H

    MAIN ENDP
END MAIN