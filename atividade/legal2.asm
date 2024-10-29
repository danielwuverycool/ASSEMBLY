.MODEL SMALL 

.DATA
        MSG DB 'Digite um digito em Hexadecimal:$'
        MSG2 DB 'Deseja continuar?$'
        A DB ?


.CODE
        MAIN PROC
                MOV AX,@DATA
                MOV DS,AX

                MOV AH,9
                LEA DX,MSG
                INT 21H

                MOV A,'A'

                MOV CX,9

                MOV AH,1
                INT 21H

                CMP AL,'A'
                JAE DOISDIGITOS

                IMPRIME:
                        


                        LOOP IMPRIME
                        JMP FIM

                DOISDIGITOS:


                        LOOP IM


        MAIN ENDP
END MAIN
        