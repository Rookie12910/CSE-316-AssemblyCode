.MODEL SMALL
.STACK 100H 

.DATA

prompt DB 'Enter the value of n & k (space separated) : $'
output_msg DB 'Number of chocolate Sahil can have in total : $'
n dw 0
k dw 0 
tc dw 0
cw dw 0 
counter dw 0

.CODE
MAIN PROC 
    
    MOV AX,@DATA
    MOV DS,AX
    
    MOV AH,09H
    LEA DX,prompt
    INT 21H
    
    
INPUT1: 
    
    MOV AH,01H
    INT 21H   
    CMP AL,' '
    JE INPUT2 
    MOV BL,AL 
    SUB BL,'0'
    MOV BH,0
    MOV AX,n 
    MOV CX,10
    MUL CX
    ADD AX,BX
    MOV n,AX 
    JMP INPUT1
    
INPUT2:
    
    MOV AH,01H
    INT 21H   
    CMP AL,0DH
    JE CALCULATE
    MOV BL,AL 
    SUB BL,'0'
    MOV BH,0
    MOV AX,K 
    MOV CX,10
    MUL CX
    ADD AX,BX
    MOV K,AX 
    JMP INPUT2
     
CALCULATE:
    MOV AX,n
    MOV tc,AX
    
WHILE: 
    MOV AX,n 
    CMP AX,K
    JB STORE_TO_STACK
    SUB AX,k
    MOV n,AX
    MOV BX,cw
    ADD BX,k
    MOV cw,BX
    MOV CX,k
    CMP CX,cw
    JE INCREASE_COUNT 
    JMP WHILE
    
INCREASE_COUNT:

    MOV AX,n
    INC AX
    MOV n,AX
    MOV BX,0
    MOV cw,BX
    MOV AX,tc
    INC AX
    MOV tc,AX
    JMP WHILE


 
       
STORE_TO_STACK:
 
    MOV DX,0
    MOV AX,tc
    MOV CX,10
    DIV CX 
    ADD DX,'0'
    PUSH DX 
    MOV BX,counter
    INC BX
    MOV counter,BX
    MOV tc,AX
    CMP AX,0
    JE OUTPUT
    JMP STORE_TO_STACK  
    
OUTPUT:

    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H 
    MOV AH,09H
    LEA DX,output_msg
    INT 21H
    
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
    
END MAIN
     

