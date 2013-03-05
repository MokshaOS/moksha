#make_bin#



len_stkno equ 02
len_descr equ 10
stockn_in db '12'  
stocktbl db "05excavators10lifters   12presses   15valves    23processors27pumps     ",0
ermsg db "string is not in table",0
          
   ;mov cx,06
   lea si,stocktbl
   jmp A20          


A20:mov al,stockn_in
    cmp al,[si] 
    jne A30
    mov al,stockn_in+1
    cmp al,[si+1]
    je A50

A30:
    jb A40
    add si,len_stkno
    add si,len_descr
    loop A20

A40:
    mov dx,0712h
    mov ax,1301h
    mov bx,0061h
    mov cx,18
    lea si,ermsg
    mov bp,si
    int 10h
    jmp A90:
    

A50:
    inc si
    inc si 
    mov ax,1301h
    mov bp,si
    mov bx,0061h
    mov cx,len_descr
    mov dx,0812h
    int 10h                     
          
          
A90:
     HLT           ; halt!


