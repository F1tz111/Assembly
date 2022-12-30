display macro string 
    mov ah,9
    lea dx ,string
    int 21h
    endm

.model small                             
.stack 100h
.data
names db 'Enter your name: $'
rollno db 'Enter your rollno: $'  
section db 'Enter your section: $ ' 
pass db 'Pass! $'
fail db 'fail $'              
obt_marks db 'Enter your obtained marks: $'  
msg_aone db 'Grade : A-One $'    
msg_a db 'Grade : A $'
msg_b db 'Grade : B $'
msg_c db 'Grade : C $'
msg_d db 'Grade : D $'   
msg_f db 'Grade : F $'
grade_d db 32h,33h,34h     
grade_c db 35h,36h,37h     
grade_b db 38h,39h         
grade_a db 31h,32h,33h     
grade_aone db 34h,34h,36h  

.code    

clrsrc proc 
    mov ax,0600h
    mov bh,7h
    mov dx,184h
    int 10h
    ret
    clrsrc endp 

newline proc
    mov ah ,2
    mov dl,0dh
    int 21h
    mov dl,0ah
    int 21h
    ret 
    newline endp

main proc 
    call clrsrc  
    
    mov ax,@data
    mov ds,ax 
    mov es,ax 
    
    display names
    
    input:
    mov ah,1 
    int 21h  
    mov [si],al
    inc si 
    cmp al,13  
    je nlfunc1
    jmp input
    
    nlfunc1:
    call newline
    
    display rollno
    
    input1:

    mov ah,1 
    int 21h
    
    cmp al,13
    je nlfunc
    
    mov [di],al
    inc di
    jmp input1  
    
    nlfunc:
    call newline
    
    display section
    
    input_section:
    mov ah,1
    int 21h
    mov [si],al
    inc si
    cmp al,13
    je nlfunc2 
    jmp input_section
    
    nlfunc2:
    call newline
          
    display obt_marks
    
    mov ah,1
    int 21h
    mov bh,al
    
    mov ah,1
    int 21h
    mov bl,al
    
    mov ah,1
    int 21h 
    mov dl,al    
    
    call newline     
    
    cmp bh,31h
    je d_show     
    
    cmp bh,32h
    je a_show
   
    cmp bh,30h
    jge f_show 
    
    d_show:  
    
    mov cx,3  
    mov si,offset grade_d
    
    check:   
    
    cmp bl,[si]
    je d   
    inc si
    
    loop check   
    
    
    ; c grade portion
    
    c_show:
    mov cx,3
    mov di,offset grade_c
    
    check2:
    
    cmp bl,[di]
    je c
    inc di
    loop check2   
                   
                   
    ; b grade portion
    
    b_show:
    mov cx,2
    mov di,offset grade_b
    
    check3:
    
    cmp bl,[di]
    je b
    inc di
    
    loop check3 
    
    ; fail special case  
    f_show:
    
    display msg_f
    
    call newline
    
    display fail
      
    jmp exit  
    
     
    
    ; a grade portion
    
    a_show:
    
    mov cx,3
    mov si,offset grade_a
    
    check4:
    
    cmp bl,[si]
    je a
    inc si
    
    loop check4
    jmp aone_show
    
    ; a-one grade portion
    
    aone_show:
    
    mov cx,3
    mov si,offset grade_aone
    
    check5:
    
    cmp bl,[si]
    je aone
    inc si
    
    loop check5   
    
    cmp bl,30h
    je b     
    
    jmp aone
           
    ; printing portion
  
    d:
    
    display msg_d 
    
    display pass
    
    jmp exit    
    
    c:
    
    display msg_c
    
    display pass
    
    jmp exit         
    
    b:
    
    display msg_b
    
    display pass
    
    jmp exit
    
    a:
    
    display msg_a  
    
    display pass
    
    jmp exit
    
    aone:
    
    display msg_aone
    
    display pass
    
    
    jmp exit
    
    exit:    
        
    mov ah,4ch
    int 21h    
        
    main endp
end main
     