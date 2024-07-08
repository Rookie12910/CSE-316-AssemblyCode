
.MODEL SMALL
.STACK 100H

.DATA
PROMPT DB "ENTER A SINGLE PRINTABLE ASCII CHARACTER : $"
UPP DB "Uppercase letter $"
LOW DB "Lowercase letter $"  
NUM DB "Number $"
OTHER DB "Not an alphanumeric value $"
USER_INPUT DB ?

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX 
    
    ; Show prompt to take input
    MOV AH,9
    LEA DX,PROMPT
    INT 21H
    
    ; Take input from user
    MOV AH,1
    INT 21H
    MOV USER_INPUT,AL   
    
    ; Move to new line and carriage return
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    
    ; Check conditions
    CMP USER_INPUT,'0'
    JB  NOT_ALPHA_NUMERIC
    
    CMP USER_INPUT,'9'
    JBE NUMBER
    
    CMP USER_INPUT,'A'
    JB NOT_ALPHA_NUMERIC  
    
    CMP USER_INPUT,'Z'
    JBE UPPER_CASE
    
    CMP USER_INPUT,'a'
    JB NOT_ALPHA_NUMERIC
    
    CMP USER_INPUT,'z'
    JBE LOWER_CASE  
    
    JMP NOT_ALPHA_NUMERIC
    
    
; Show result   
NUMBER: 
    MOV AH,9
    LEA DX,NUM
    INT 21H
    JMP EXIT
    
UPPER_CASE: 
    MOV AH,9
    LEA DX,UPP
    INT 21H
    JMP EXIT
            
LOWER_CASE: 
    MOV AH,9
    LEA DX,LOW
    INT 21H
    JMP EXIT 
    
NOT_ALPHA_NUMERIC:
    MOV AH,9
    LEA DX,OTHER
    INT 21H 
    JMP EXIT
    
    EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
END MAIN
