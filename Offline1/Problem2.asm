.MODEL SMALL
.STACK 100H
.DATA 
prompt db 'Enter three lowercase letters: $'
output_msg db 'The second-highest letter is: $'
all_equal_msg db 'All letters are equal$'
invalid_input_msg db 'Invalid Input!$' 
letter1 db ?
letter2 db ?
letter3 db ?
ans db ?
   

.CODE
MAIN PROC 
    
    ; Data initialization
    MOV AX,@DATA
    MOV DS,AX
    
    ; Show prompt to enter three lowercase letters
    MOV AH,9
    LEA DX,prompt
    INT 21H
    
    ; Take input for the first letter
    MOV AH, 1
    INT 21H
    MOV letter1, AL
    
    ; Take input for the second letter
    MOV AH, 1
    INT 21H
    MOV letter2, AL
    
    ; Take input for the third letter
    MOV AH, 1
    INT 21H 
    MOV letter3, AL
    
    ; Move to a new line and carriage return
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H 
    
    ;Check if inputs are valid
    CMP letter1,'a'
    JB invalid_input
    CMP letter2,'a'
    JB invalid_input 
    CMP letter3,'a'
    JB invalid_input
    CMP letter1,'z'
    JG invalid_input
    CMP letter2,'z'
    JG invalid_input
    CMP letter3,'z'
    JG invalid_input
       
    
    ;Move memory values to registers
    MOV AL,letter1
    MOV BL,letter2
    MOV CL,letter3 
    
    ; Compare letter1 and letter2
    CMP AL,BL
    JG  comparison1
    JE  equality_found1
    XCHG AL,BL
    JMP comparison1
    
    ; If letter1 and letter2 are equal, check for equality with letter3
    equality_found1:
    CMP AL,CL
    JE  all_letters_equal
    JL  output_result
    XCHG AL,CL
    JL output_result
    
    ; Compare highest of letter1 & letter2, with letter 3
    comparison1:
    CMP AL,CL
    JL  output_result
    JE  equality_found2
    XCHG AL,CL
    
    ; If CL contains the highest letter, 2nd highest is either in AL or BL 
    comparison2:
    CMP AL,BL
    JGE  output_result
    XCHG AL,BL 
    CMP AL,BL
    JG  output_result
    
    ;Compare highest of letter1 & letter2 is equal with letter 3, then BL contains the 2nd highest letter
    equality_found2:
    XCHG AL,BL
    
    ;Show result when 2nd highest letter exists
    output_result: 
    MOV ans,AL
    MOV AH,9
    LEA DX,output_msg
    INT 21H 
    MOV AL,ans 
    MOV AH,2
    MOV DL,AL
    INT 21H
    JMP EXIT
   
    ; Show result when all letters are equal 
    all_letters_equal:
    MOV AH,9
    LEA DX,all_equal_msg
    INT 21H
    JMP Exit 
    
    ;Show if inputs are invalid
    invalid_input:
    MOV AH,9
    LEA DX,invalid_input_msg
    INT 21H 
    JMP Exit
    
    EXIT:
    MOV AH,4CH
    INT 21H    
    MAIN ENDP
END MAIN