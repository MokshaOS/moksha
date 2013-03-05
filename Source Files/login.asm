include mvideo.inc                 
include emu8086.inc
include mdtimer.inc

#make_bin#

#CS=2001h#	
#IP=0000h#
#DS=2001h#
#SS=2001h#
#SP=0FFFEh#
	                                                                ; Jump to the start label
jmp start:

  

cmd_size      equ   5                    ; size of username
username      db    cmd_size dup (' ')   ; The username entered by the user
password      db    cmd_size dup (' ')   ; The password entered by the user
type          db    1        dup (00h)
real_username db    'root'
real_password db    '123#'

start:        

; Set data segment equal to the value of code segment
push cs
pop ds     

mov ax,2001h
mov ss,ax
mov sp,0fffeh


setvmode()
clrscr() 

cprintf() "Login ( Moksha Operating System User Login )",45,15,1,012
printf() "" ; Insert a blank line  
printf() "--------------------------------------------------------------------------------"
printf() ""
print() "Enter username : "


;Input from the user for the purpose of getting the username
get_command proc near

; wait for a command:
mov     dx, cmd_size                                 ; buffer size.
lea     di, username
call    get_string

printf() ""
print() "Enter password : " 

mov type,01h
mov     dx, cmd_size                                 ; buffer size.
lea     di, password
call    get_string


;///////////Check username///////////////////////////

; set forward direction:
        cld     

; load source into ds:si,
; load target into es:di: 
        push ds
        push es
         
        mov     ax, cs
        mov     ds, ax
        mov     es, ax
        lea     si, username
        lea     di, real_username
        
        pop ds
        pop es
; set counter to string length:
        mov     cx, 4

; compare until equal:
        repe    cmpsb
        jnz     not_equal
;///////////Check username///////////////////////////
        

;///////////Check password///////////////////////////

; set forward direction:
        cld     

; load source into ds:si,
; load target into es:di: 
        push ds
        push es
         
        mov     ax, cs
        mov     ds, ax
        mov     es, ax
        lea     si, password
        lea     di, real_password
        
        pop ds
        pop es
; set counter to string length:
        mov     cx, 4

; compare until equal:
        repe    cmpsb
        jnz     not_equal
;///////////Check password///////////////////////////

printf() ""
printf() ""
printf() "User Authenticated."
delay() 2 
popa
mov ah,02h        ;READ
mov al,6          ;SECTORS TO READ
mov ch,2          ;CYLINDER
mov cl,1          ;SECTOR
mov dh,0          ;HEAD
mov bx,0201h      ;READ FROM 256 Byte;
mov es,bx         ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h
jmp 0201h:0000h    


not_equal:  
printf() ""
printf() ""      
printf() "Invalid Login"
printf() "Moksha Operating System will now reboot the computer."  
delay() 2 

mov     ax, 0040h
mov     ds, ax
mov     w.[0072h], 0000h ; cold boot.
jmp	0ffffh:0000h	 ; reboot!

get_command endp
; Input from the user for the purpose of getting the username


; get characters from keyboard and write a null terminated string 
get_string      proc    near
push    ax
push    cx
push    di
push    dx

mov     cx, 0                                        ; char counter.

cmp     dx, 1                                        ; buffer too small?
jbe     empty_buffer            

dec     dx                                           ; reserve space for last zero.


;============================
; eternal loop to get
; and processes key presses:

wait_for_key:

mov     ah, 0                                        ; get pressed key.
int     16h

cmp     al, 0Dh                                      ; 'return' pressed?
jz      exit


cmp     al, 8                                        ; 'backspace' pressed?
jne     add_to_buffer
jcxz    wait_for_key                                 ; nothing to remove!
dec     cx
dec     di
putc()    8                                          ; backspace.
putc()    ' '                                        ; clear position.
putc()    8                                          ; backspace again.
jmp     wait_for_key

add_to_buffer:

        cmp     cx, dx                               ; buffer is full?
        jae     wait_for_key                         ; if so wait for 'backspace' or 'return'...

        mov     [di], al
        inc     di
        inc     cx
        
        
        cmp type,00h
        je ok:
        jmp not_ok
        
        ok:
        ; print the key:
        mov     ah, 0eh
        int     10h
        jmp wait_for_key
        
        not_ok:
        ; print the key:
        mov     ah, 0eh
        mov     al, '*'
        int     10h
        

jmp     wait_for_key
;============================

exit:


; terminate by null:
mov     [di], 0

empty_buffer:

pop     dx
pop     di
pop     cx
pop     ax
ret
get_string      endp



hlt
