include mvideo.inc ;Include mvideo.inc file for handling the Video Bios[Int 10H]
include mtime.inc
#make_bin#


; set loading address, .bin file will be loaded to this address:
#LOAD_SEGMENT=0201h#
#LOAD_OFFSET=0000h#

; set entry point:
#CS=0201h#    ; same as loading segment
#IP=0000h#    ; same as loading offset

jmp start ;Skip the variable declaration section and goo he start label

;===================================MOKSHA OPERATING SYSTEM COMMAND INTERPRETER VARIABLE DECLARATION SECTION=========================

cmd_size        equ 10    ; size of command_buffer
command_buffer  db cmd_size dup("b")
clean_str       db 14 dup(" "), 0
filenamesize equ 9 
filename db filenamesize dup("b")
prompt          db "A:\>", 0

; MOKSHA COMMANDS
chelp    db "help", 0
chelp_tail:
ccls     db "cls", 0
ccls_tail:      
cmfile     db "mfile", 0
cmfile_tail:      
crfile     db "rfile", 0
crfile_tail:
cexit    db "exit", 0
cexit_tail:
creboot  db "reboot", 0
creboot_tail:
cver  db "version", 0
cver_tail:
cos  db "time", 0
cos_tail:

help_msg db "Moksha Operating System Help", 0Dh,0Ah
db "The short list of supported commands:", 0Dh,0Ah
db "help   - print out this list.", 0Dh,0Ah 
db "mfile  - make a 512 byte long file on floppy drive.", 0Dh,0Ah
db "rfile  - read a 512 byte long file present on flopy drive.", 0Dh,0Ah
db "cls    - clear the screen.", 0Dh,0Ah
db "time - to print current time on screen.", 0Dh,0Ah  
db "reboot - reboot the machine.", 0Dh,0Ah    
db "exit   - same as quit.",0Dh,0Ah



unknown  db "Unknown Moksha Command: " , 0

;===================================MOKSHA OPERATING SYSTEM COMMAND INTERPRETER VARIABLE DECLARATION SECTION=========================


;----------------------------------------------MOKSHA INTERPRETER COMMAND INPUT CODE------------------------------------------------

start:     ;start label
setvmode() ;Set he defaul video mode defined in MVIDEO.INC

; set data segment:
push    cs
pop     ds

; blinking disabled for compatibility with dos/bios,
; emulator and windows prompt never blink.
mov     ax, 1003h
mov     bx, 0      ; disable blinking.
int     10h

;Clear Screen
clrscr()

;Set Background & Foreground Color.Bit 0 is Backcolor & Bit F is Forecolor
setbkcolor() 0Fh ;Function is defined in MVIDEO.INC

; print out the message:
gotoxy() 26,1
cprintf() "MOKSHA COMMAND INTERPRETER",26,25,2,4

gotoxy() 0,5 ;Default starting position(X,Y)=(0,4)

eternal_loop: ;Moksha Command Interpreter main loop starts

call    get_command

call    process_cmd

; make eternal loop:
jmp eternal_loop ;Moksha Command Interpreter main loop ends

;----------------------------------------------MOKSHA INTERPRETER COMMAND INPUT CODE------------------------------------------------
get_command proc near




; show prompt:
lea     si, prompt
call    print_string


; wait for a command:
mov     dx, cmd_size    ; command size.
lea     di, command_buffer ;command buffer address
call    get_string         


ret
get_command endp
;----------------------------------------------MOKSHA INTERPRETER COMMAND INPUT CODE------------------------------------------------


;----------------------------------------------MOKSHA INTERPRETER COMMAND AUTHENTICATION CODE---------------------------------------
process_cmd proc    near

;//// check commands here ///
; set es to ds
push    ds
pop     es

cld     ; forward compare.

; compare command buffer with 'help'
lea     si, command_buffer
mov     cx, chelp_tail - offset chelp   ; size of ['help',0] string.
lea     di, chelp
repe    cmpsb
je      help_command

; compare command buffer with 'cls'
lea     si, command_buffer
mov     cx, ccls_tail - offset ccls  ; size of ['cls',0] string.
lea     di, ccls
repe    cmpsb
jne     not_cls
jmp     cls_command
not_cls:


; compare command buffer with 'exit'
lea     si, command_buffer
mov     cx, cexit_tail - offset cexit ; size of ['exit',0] string.
lea     di, cexit
repe    cmpsb
je      reboot_command

; compare command buffer with 'read'
lea     si, command_buffer
mov     cx, crd_tail - offset crd ; size of ['exit',0] string.
lea     di, crd
repe    cmpsb
je      read_command                         
                         
; compare command buffer with 'reboot'
lea     si, command_buffer
mov     cx, creboot_tail - offset creboot  ; size of ['reboot',0] string.
lea     di, creboot
repe    cmpsb
je      reboot_command

; compare command buffer with 'version'
lea     si, command_buffer
mov     cx, cver_tail - offset cver  ; size of ['reboot',0] string.
lea     di, cver
repe    cmpsb
je      cver_command

; compare command buffer with 'time'
lea     si, command_buffer
mov     cx, cos_tail - offset cos  ; size of ['reboot',0] string.
lea     di, cos
repe    cmpsb
je      cos_command


; ignore empty lines
cmp     command_buffer, 0
jz      processed

;----------------------------------------------MOKSHA INTERPRETER COMMAND AUTHENTICATION CODE---------------------------------------


;----------------------------------CODE FOR UNKNOWN COMMAND STARTS------------------------------------------------------------------

printf() "" ;Print a blank Line to avoid overwriting on the current x,y position

lea     si, unknown
call    print_string

lea     si, command_buffer
call    print_string

printf() "" ;Print a blank line after displaying the above message


jmp     processed

;----------------------------------CODE FOR UNKNOWN COMMAND ENDS--------------------------------------------------------------------


;----------------------------------MCI COMMANDS OPERATIONAL BODY--------------------------------------------------------------------

cos_command:
hour()
print() ":"
min()
print() ":"
sec()
jmp processed       

; +++++ 'help' command ++++++
help_command:


lea     si, help_msg
call    print_string

jmp     processed


cver_command:
printf() ""
printf() "MCI ver 1.0"
jmp processed                   

; +++++ 'cls' command ++++++
cls_command:
;call    clear_screen
clrscr()
;Set Background & Foreground Color.Bit 0 is Backcolor & Bit F is Forecolor
setbkcolor() 0Fh ;Function is defined in MVIDEO.INC
jmp     processed

read_command:

  buffer db 512 dup(' ') ; defining buffer area where the data stored
  ; set data segment:
  xor     ax, ax
  mov     ds, ax
  
  ; set default video mode 80x25:
  mov     ah, 00h ;VIDEO BIOS
  mov     al, 03h ;GRAPHICS MODE,RESOLUTION 720X400 PIXELS
  int     10h     ;CALL INTERRUPT 10H VIDEO BIOS  
 
  ;WAIT FOR A KEY
  mov ah,0h
  int 16h
   
  
    
        
   mov ah,02h    ;READ
   mov al,01     ;SECTORS TO READ
   lea bx,buffer ;CODE SEGMENT
   mov ch,00     ;TRACK/CYLINDER
   mov cl,01     ;SECTOR
   mov dh,00     ;HEAD
   mov dl,00     ;FIRST FLOPPY DISK 
   int 13h       ;CALL INTERRUPT 13H[BIOS DISK]
   call print
   hlt

   print:
          mov ah,13h
          mov al,01h
          mov bh,00h
          mov bl,17h
          mov cx,512
          mov dx,0100h
          push cs
          pop es
          mov bp,offset [buffer]
          int 10h    
          
          
          mov dx,1010h
          mov bh,00h
          mov ah,2
          int 10h
          mov al,b. offset[buffer] 
          ;cmp al,'q' 
          ;je label1 
          ;print 'al is not equal to q'
          ;jmp exit
          mov ah,09h
          mov bh,00h
          mov bl,018h
          mov cx,01h 
          int 10h
          ;label1:
          ;print 'al is containing q' 
          ;exit:
          ;ret
          mov ah,0
          int 16h
          ret

jmp     processed


; +++ 'quit', 'exit', 'reboot' +++
reboot_command:

;call    clear_screen
;print 5,2,0011_1111b," please eject any floppy disks "
;print 5,3,0011_1111b," and press any key to reboot... "
;mov ax, 0  ; wait for any key....
;int 16h

; store magic value at 0040h:0072h:
;   0000h - cold boot.
;   1234h - warm boot.
mov     ax, 0040h
mov     ds, ax
mov     w.[0072h], 0000h ; cold boot.
jmp    0ffffh:0000h     ; reboot!

; ++++++++++++++++++++++++++

;----------------------------------MCI COMMANDS OPERATIONAL BODY--------------------------------------------------------------------

processed:
ret
process_cmd endp

;-------------------MOKSHA STRING HANDLING PROCEDURES---------------------------------------------------------

; get characters from keyboard and write a null terminated string
; to buffer at DS:DI, maximum buffer size is in DX.
; 'enter' stops the input.
get_string      proc    near
push    ax
push    cx
push    di
push    dx

mov     cx, 0                   ; char counter.

cmp     dx, 1                   ; buffer too small?
jbe     empty_buffer            ;

dec     dx                      ; reserve space for last zero.


;============================
; eternal loop to get
; and processes key presses:

wait_for_key:

mov     ah, 0                   ; get pressed key.
int     16h

cmp     al, 0Dh                 ; 'return' pressed?
jz      exit

cmp     al,20h
jz      get_perameter


cmp     al, 8                   ; 'backspace' pressed?
jne     add_to_buffer
jcxz    wait_for_key            ; nothing to remove!
dec     cx
dec     di
putc()    8                       ; backspace.
putc()    ' '                     ; clear position.
putc()    8                       ; backspace again.
jmp     wait_for_key

add_to_buffer:

cmp     cx, dx          ; buffer is full?
jae     wait_for_key    ; if so wait for 'backspace' or 'return'...

mov     [di], al
inc     di
inc     cx

; print the key:
mov     ah, 0eh
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




; print a null terminated string at current cursor position,
; string address: ds:si
print_string proc near
push    ax      ; store registers...
push    si      ;

next_char:
mov     al, [si]
cmp     al, 0
jz      printed
inc     si
mov     ah, 0eh ; teletype function.
int     10h
jmp     next_char
printed:

pop     si      ; re-store registers...
pop     ax      ;

ret
print_string endp

;-----------------------------------------MOKSHA STRING HANDLING PROCEDURES---------------------------------------------------------

ret


;===========================================
get_perameter proc near

; set cursor position to bottom
; of the screen:
mov     ax, 40h
mov     es, ax
mov     al, es:[84h]

;gotoxy  0, al

; clear command line:
;lea     si, clean_str
;call    print_string

;gotoxy  0, al

; show prompt:
;lea     si, prompt 
;call    print_string


; wait for a command:
mov     dx, filenamesize    ; buffer size.
lea     di, filename
call    get_perastring


ret
get_perameter endp
;===========================================



; get characters from keyboard and write a null terminated string 
; to buffer at DS:DI, maximum buffer size is in DX.
; 'enter' stops the input.
get_perastring      proc    near
push    ax
push    cx
push    di
push    dx

mov     cx, 0                   ; char counter.

cmp     dx, 1                   ; buffer too small?
jbe     empty_buffer            ;

dec     dx                      ; reserve space for last zero.


;============================
; eternal loop to get
; and processes key presses:

wait_for_key:

mov     ah, 0                   ; get pressed key.
int     16h

cmp     al, 0Dh                 ; 'return' pressed?
jz      exit1


cmp     al, 8                   ; 'backspace' pressed?
jne     add_to_buffer
jcxz    wait_for_key            ; nothing to remove!
dec     cx
dec     di
putc    8                       ; backspace.
putc    ' '                     ; clear position.
putc    8                       ; backspace again.
jmp     wait_for_key

add_to_buffer:

        cmp     cx, dx          ; buffer is full?
        jae     wait_for_key    ; if so wait for 'backspace' or 'return'...

        mov     [di], al
        inc     di
        inc     cx
        
        ; print the key:
        mov     ah, 0eh
        int     10h

jmp     wait_for_key
;============================

exit1:

; terminate by null:
mov     [di], 0

empty_buffer:

pop     dx
pop     di
pop     cx
pop     ax
call go
ret
get_string      endp





; [SOURCE]: L:\MOKSHA\shell.asm
