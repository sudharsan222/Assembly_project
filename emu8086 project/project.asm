include 'emu8086.inc'

org 100h

.data
matrix  db 3 dup(?)   ;declaration of matrix1
        db 3 dup(?)
        db 3 dup(?)


matrix1   db 3 dup(?) ;declaration of matrix2
        db 3 dup(?)
        db 3 dup(?)
       
       
matrix3 db 9 DUP(0)   ;this matrix to store add and sub


transpose db 3 dup(?) ;to store the transpose mat1
          db 3 dup(?)
          db 3 dup(?)   
          
          
transpose1 db 3 dup(?) ;to store the transpose of mat2
           db 3 dup(?)
           db 3 dup(?)
n_line DB 0AH,0DH,"$"
NO_ROWS     EQU 3
NO_COLUMNS  EQU 3     ;variables we use in matrix operations
num db 0Ah
temp db ?                                   
prompt1 db 'enter 9 numbers of 3x3 matrix:$' 
prompt2 db 'given 3x3 matrix$'
prompt3 db 'enter 9 numbers for 2nd 3*3 matrix:$'
prompt4 db 'addition of two matrix is:$'
prompt5 db 'substraction of two matrix:$'
prompt6 db 'multiplication of two matrix:$'
prompt7 db 'transpose of matrix1:$'
prompt8 db 'transpose of matrix2:$'
prompt9 db 'trace of matrix:$'
prompt10 db 'trace of matrix2:$'
sum db 0
                                          ;all prompts like messages 


.code
main proc
       mov dx,offset prompt1
       mov ah,09h
       int 21h                 ;print prompt1
       mov si,offset matrix
       mov cx,9                ;loads si to matrix
       enternum:
              call getnum
              mov bl,temp
              mov [si],bl
              inc si
              mov ah,2
              mov dl,0Ah
              int 21h          
              loop enternum    ;get the number and stores it the matrix
        mov dx,offset prompt2
        mov ah,09h
        int 21h                ;print prompt2
        mov dx,0Ah
        mov ah,2
        int 21h
        mov dx,0Dh
        int 21h
        mov si,offset matrix
        call printmat           ;print the matrix
       
       mov dx,offset prompt3
       mov ah,09h
       int 21h                  ;print prompt3
       mov si,offset matrix1
       mov cx,9    
       enternum2:               ;get the number and store in a matrix
              call getnum
              mov bl,temp
              mov [si],bl
              inc si
              mov ah,2
              mov dl,0Ah
              int 21h
              loop enternum2  
             
             
       mov dx,offset prompt2 ;print the prompt2
        mov ah,09h
        int 21h
        mov dx,0Ah
        mov ah,2
        int 21h
        mov dx,0Dh
        int 21h
        mov si,offset matrix1
        call printmat                  ;print the matrix1
       
        MOV DX,OFFSET prompt4
        MOV AH,09H
        INT 21H
        MOV CL,0   
        
        LEA DX,n_line ;lea means load effective address

        MOV AH,9

        INT 21H      ;to print newline
        ;addition 
        mov bx,0103h    ;address of matrix1
        mov bp,010ch    ;address of mat2
        mov si,0000h
        mov di,1501h    ;address matrix of sum
        mov cl,09h
        
        repeat:
              mov al,[bx+si]
              add al,[bp+si]
              mov [di],al
              inc si
              inc di                ;process of addition
              
              loop repeat
        mov si,1501h
        call printmat      ;print the addition matrix
         
        ;substraction 
        mov dx,offset prompt5
       mov ah,09h
       int 21h    
       
       LEA DX,n_line ;lea means load effective address

        MOV AH,9

        INT 21H          ;print the newline
        
        mov bx,0103h ;address of first matrix
        mov bp,010ch ;address of 2nd matrix
        mov si,0000h
        mov di,1601h ;address of diff matrix
        mov cl,09h
        
        repeat1:
              mov al,[bx+si]
              sub al,[bp+si]
              mov [di],al
              inc si
              inc di
              
              loop repeat1     ;process of substraction
     
         mov si,1601h
         call printmatsub   ;print the matrixsub
     ;multiplication    
     mov dx,offset prompt6
     mov ah,09h
     int 21h                  ;print prompt6
       
     LEA DX,n_line ;lea means load effective address

     MOV AH,9

     INT 21H
     mov si,0103h   ;address of matrix1
     mov di,010ch   ;address of matrix2
     mov bp,1701h   ;address of multiplication matrix
     mov cl,03h   ;row count 
     mov ch,03h   ;col count
     mov dh,ch
     repeat3:
     mov bl,dh
     repeat2:
     mov dl,00h
     mov ch,dh
     repeatmul1:
     mov al,[si] ;mem location value
     mul [di]    ;mul mem location of al and di
     add dl,al
     inc si      ;increamenting si
     add di,03   ;increamentidi by 3
     dec ch      ;dec ch check zero flag
     jnz repeatmul1         ;jump not zero
     mov [bp],dl    ;store the element of matrix in the memory
     inc bp       ;increament the product  matrix
     sub si,03h   ;make si to point the first element
     sub di,09h
     inc di
     dec bl       ;decreament the col count
     jnz repeat2  ;multiplication of 1st row and 2nd col
     
     add si,03h   ;first element in the second row
     mov di,010ch ;make di to point the first element 2nd matrix
     dec cl       ;decreamnet the row count
     jnz repeat3                           ;repeat the process
     
     mov si,1701h
     call printmatmul;print the multiply matrix
     
     
    ;transpose
       mov dx,offset prompt7
       mov ah,09h
       int 21h                ;print the prompt7
       LEA DX,n_line ;lea means least effective address

        MOV AH,9

        INT 21H         ;print the new line
        mov si,offset matrix     ;si stores the matrix
        mov di,offset transpose  ;di stores the transpose
        call swap             ;call swap
        mov si,offset matrix
        mov di,offset transpose
        add si,1
        add di,3             ;swap 1 and 3
        call swap
        mov si,offset matrix
        mov di,offset transpose
        add si,2
        add di,6
        call swap         ;swap 2,6
    mov si,offset transpose
        call printmat         ;print the matrix which is the transpose
      ;transpose1
       mov dx,offset prompt8
       mov ah,09h
       int 21h                ;print the prompt8
       LEA DX,n_line ;lea means least effective address

        MOV AH,9
                                  ;print the newline
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
        call printmat              ;similar process of transpose
  
        mov AX, offset matrix
        mov BX, offset matrix1 
    
    mov dx,offset prompt9
    mov ah,09h
    int 21h
    ;trace    
    mov ax,0
    mov bx,0
    mov cx,3  
    mov si,0
    oper:
        add al,matrix[bx+si]
        add bx,3
        inc si
        loop oper
                           ;this is to find the trace of a matrix 
        
       
       
     mov ah,0    
    
     call print_num              ;print the num i.e trace
       
    
    LEA DX,n_line ;lea means load effective address

        MOV AH,9

        INT 21H          ;print the newline
            
        
    mov dx,offset prompt10
    mov ah,09h
    int 21h           ;print the prompt
    
    
        
    mov ax,0
    mov bx,0
    mov cx,3  
    mov si,0
    oper1:
        add al,matrix1[bx+si]
        add bx,3
        inc si
        loop oper1
        
        
       
       
      mov ah,0    
    
     call print_num   ;print the trace of 2nd matrix
        
        
        
        
        
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
   
    getnum endp                ;procedure of getnum and store 
   



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
loop lop                                ;procedure to print the matrix
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
        int 21h                           ;procedure to print the addition of two matrix
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
        int 21h                                      ;procedure to print the multiplication matrix
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
        putnum endp                                  ;put the elementin the matrix
    
   
       
         
    
ret
    swap proc
        mov cx,3
        loop1:
        mov ax,[si]
        mov [di],ax
        add si,3
        add di,1
        loop loop1                                    ;function to swap elements to find transpose
        ret
    swap endp
    
ret
  
define_print_num  
define_print_num_uns



   
