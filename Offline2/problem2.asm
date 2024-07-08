.MODEL SMALL
.STACK 100H

.DATA
prompt DB 'Enter the value of n :$' 
output_msg DB 'Sum of digits : $'
n DW 0
sum DW 0
counter DW 0


.CODE

MAIN PROC 
    
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,09H
    LEA DX,prompt
    INT 21H
    
INPUT: 
    
    MOV AH,01H
    INT 21H   
    CMP AL,0DH
    JE CALL_PROC 
    MOV BL,AL 
    SUB BL,'0'
    MOV BH,0
    MOV AX,n 
    MOV CX,10
    MUL CX
    ADD AX,BX
    MOV n,AX 
    JMP INPUT

CALL_PROC:
         
    MOV AX,n 
    MOV CX,10
    CALL CALCULATE  
    MOV SUM,AX

    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    MOV AH,09H
    LEA DX,output_msg
    INT 21H
    
STORE_TO_STACK:
 
    MOV DX,0
    MOV AX,sum
    MOV CX,10
    DIV CX 
    ADD DX,'0'
    PUSH DX 
    MOV BX,counter
    INC BX
    MOV counter,BX
    MOV sum,AX
    CMP AX,0
    JE DISPLAY
    JMP STORE_TO_STACK   
    
DISPLAY:

    POP DX
    MOV BX,counter
    CMP BX,0
    JE EXIT
    DEC BX
    MOV counter,BX
    MOV AH,02H
    INT 21H 
    JMP DISPLAY   
    
EXIT:
    MOV AH,4CH
    INT 21H
    MAIN ENDP   
    
    
CALCULATE PROC
    
     CMP AX,0
     JE GO_BACK 
     MOV DX,0
     DIV CX
     PUSH DX
     CALL CALCULATE
     POP BX
     ADD AX,BX
     GO_BACK: RET     
       
        
 END MAIN       

