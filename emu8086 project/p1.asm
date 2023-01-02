
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


num db 0Ah
temp db ?
prompt1 db 'enter 9 numbers of 3x3 matrix:$'
prompt2 db 'given 3x3 matrix$'
prompt3 db 'enter 9 numbers for 2nd 3*3 matrix:$'
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




