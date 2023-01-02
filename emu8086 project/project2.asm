; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

; You may customize this and other start-up templates;
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.data
matrix  db 3 dup(?)
        db 3 dup(?)
        db 3 dup(?)


matrix1   db 3 dup(?)
        db 3 dup(?)
        db 3 dup(?)
       
       
matrix3 db 9 DUP(0)  


transpose db 3 dup(?)
          db 3 dup(?)
          db 3 dup(?)   
          
          
transpose1 db 3 dup(?)
          db 3 dup(?)
          db 3 dup(?)
n_line DB 0AH,0DH,"$"
NO_ROWS     EQU 3
NO_COLUMNS  EQU 3
num db 0Ah
temp db ?
prompt1 db 'enter 9 numbers of 3x3 matrix:$'
prompt2 db 'given 3x3 matrix$'
prompt3 db 'enter 9 numbers for 2nd 3*3 matrix:$'
prompt4 db 'addition of two matrix is:$'
prompt5 db 'substraction of two matrix:$'
prompt6 db 'multiplication of two matrix:$'
prompt7 db 'transpose of matrix1:$'
prompt8 db 'trsnspose of matrix2:$'



.code
main proc
       mov dx,offset prompt1
       mov ah,09h
       int 21h
       mov si,offset matrix
       mov cx,9
       enternum:
              call getnum
              mov bl,temp
              mov [si],bl
              inc si
              mov ah,2
              mov dl,0Ah
              int 21h
              loop enternum
        mov dx,offset prompt2
        mov ah,09h
        int 21h
        mov dx,0Ah
        mov ah,2
        int 21h
        mov dx,0Dh
        int 21h
        mov si,offset matrix
        call printmat
       
       mov dx,offset prompt3
       mov ah,09h
       int 21h
       mov si,offset matrix1
       mov cx,9    
       enternum2:
              call getnum
              mov bl,temp
              mov [si],bl
              inc si
              mov ah,2
              mov dl,0Ah
              int 21h
              loop enternum2  
             
             
       mov dx,offset prompt2
        mov ah,09h
        int 21h
        mov dx,0Ah
        mov ah,2
        int 21h
        mov dx,0Dh
        int 21h
        mov si,offset matrix1
        call printmat
       
        MOV DX,OFFSET prompt4
        MOV AH,09H
        INT 21H
        MOV CL,0   
        LEA DX,n_line ;lea means least effective address

        MOV AH,9

        INT 21H
        ;addition 
P1:
XOR BX,BX
MOV BL,CL
MOV AL,matrix[BX]
MOV DL,matrix1[BX]
ADD AL,DL
MOV matrix3[BX],AL
INC CL
CMP CL,9
JNZ P1
MOV DX,0AH
MOV AH,02H
INT 21H
MOV CL,0
MOV CH,0
PP:XOR BX,BX
MOV BL,CL
MOV AL,matrix3[BX]
MOV DL,AL
ROL DL,4
AND DL,0FH
ADD DL,30H
CMP DL,'9'
JBE F1
ADD DL,7H
F1:
MOV AH,02H
INT 21H
MOV AL,matrix3[BX]
AND AL,0FH
MOV DL,AL
ADD DL,30H
CMP DL,'9'
JBE F2
ADD DL,7

F2:
MOV AH,02H
INT 21H
;MOV DX,OFFSET M4
;MOV AH,09H
;INT 21H
;INC CH
;CMP CH,3
;JNZ L1
;MOV DX,0AH
;MOV AH,02H
;INT 21H
;MOV CH,0

L1:
INC CL
CMP CL,9
JNZ PP
MOV AH,4CH
INT 21H



        mov si,1501h
        call printmatadd 
         
        ;substraction 
        mov dx,offset prompt5
       mov ah,09h
       int 21h    
       
       LEA DX,n_line ;lea means least effective address

        MOV AH,9

        INT 21H
        mov bx,0103h
        mov bp,010ch 
        mov si,0001h
        mov di,1601h
        mov cl,09h
        
        repeat1:
              mov al,[bx+si]
              sub al,[bp+si]
              mov [di],al
              inc si
              inc di
              
              loop repeat1
     
         mov si,1601h
        call printmatsub
     ;multiplication    
     mov dx,offset prompt6
       mov ah,09h
       int 21h   
       
       LEA DX,n_line ;lea means least effective address

        MOV AH,9

        INT 21H
     mov si,0103h
     mov di,010ch
     mov bp,1701h
     mov cl,03h
     mov ch,03h
     mov dh,ch
     repeat3:
     mov bl,dh
     repeat2:
     mov dl,00h
     mov ch,dh
     repeatmul1:
     mov al,[si]
     mul [di]
     add dl,al
     inc si
     add di,03
     dec ch
     jnz repeatmul1
     mov [bp],dl
     inc bp
     sub si,03h
     sub di,09h
     inc di
     dec bl
     jnz repeat2
     add si,03h
     mov di,010ch
     dec cl
     jnz repeat3
     
     mov si,1701h
     call printmatmul
     
     
    ;transpose
       mov dx,offset prompt7
       mov ah,09h
       int 21h     
       LEA DX,n_line ;lea means least effective address

        MOV AH,9

        INT 21H
    mov si,offset matrix
        mov di,offset transpose
        call swap
        mov si,offset matrix
        mov di,offset transpose
        add si,1
        add di,3
        call swap
        mov si,offset matrix
        mov di,offset transpose
        add si,2
        add di,6
        call swap 
    mov si,offset transpose
        call printmat
      ;transpose1
       mov dx,offset prompt8
       mov ah,09h
       int 21h     
       LEA DX,n_line ;lea means least effective address

        MOV AH,9

        INT 21H
    mov si,offset matrix1
        mov di,offset transpose1
        call swap
        mov si,offset matrix1
        mov di,offset transpose1
        add si,1
        add di,3
        call swap
        mov si,offset matrix1
        mov di,offset transpose1
        add si,2
        add di,6
        call swap 
    mov si,offset transpose1
        call printmat
  
        mov AX, offset matrix
        mov BX, offset matrix1
 ret  
    main endp
   
   
    getnum proc
    mov bl,0
    a:
    mov ah,1
    int 21h
    cmp al,0Dh
    jz ext
    sub al,030h
    mov dl,al
    mov al,bl
    mul num
    add al,dl
    mov bl,al
    jmp a
    ext:
    mov temp,bl
    ret
   
    getnum endp
   



printmat proc;3x3
        mov cx,3
        lop:
        call putnum
        mov dx,02Ch
        int 21h
        inc si
        call putnum
        mov dx,02Ch
        int 21h
        inc si
        call putnum
        inc si
        mov ah,2
        mov dl,0Ah
        int 21h
        mov dx,0Dh
        int 21h
loop lop
ret       


printmat endp

  printmatadd proc;3x3
        mov cx,3
        lop1:
        call putnum
        mov dx,02Ch
        int 21h
        inc si
        call putnum
        mov dx,02Ch
        int 21h
        inc si
        call putnum
        inc si
        mov ah,2
        mov dl,0Ah
        int 21h
        mov dx,0Dh
        int 21h
loop lop1       
    
   ret
   printmatadd endp 
    
   printmatsub proc;3x3
        mov cx,3
        lop2:
        call putnum
        mov dx,02Ch
        int 21h
        inc si
        call putnum
        mov dx,02Ch
        int 21h
        inc si
        call putnum
        inc si
        mov ah,2
        mov dl,0Ah
        int 21h
        mov dx,0Dh
        int 21h
loop lop2       
    
   ret
   printmatsub endp 
                        
 printmatmul proc;3x3
        mov cx,3
        lop3:
        call putnum
        mov dx,02Ch
        int 21h
        inc si
        call putnum
        mov dx,02Ch
        int 21h
        inc si
        call putnum
        inc si
        mov ah,2
        mov dl,0Ah
        int 21h
        mov dx,0Dh
        int 21h
loop lop3       
    
   ret
   printmatmul endp
   
   
    putnum proc
        mov al,[si]
        mov temp,0h
        b:
        mov ah,0h
        inc temp
        mov bl,0Ah
        div bl
        mov dl,ah
        push dx
        cmp al,00h
        jne b
        c:
        mov ah,2h
        pop dx
        add dx,030h
        int 21h
        dec temp
        cmp temp,0h
        jne c
        ret
        putnum endp      
       
         
    
ret
    swap proc
        mov cx,3
        loop1:
        mov ax,[si]
        mov [di],ax
        add si,3
        add di,1
        loop loop1
        ret
    swap endp
    
ret