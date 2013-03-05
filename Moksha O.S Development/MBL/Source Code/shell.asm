include mvideo.inc ; Include mvideo.inc file for handling the Video Bios[Int 10H]
org 100h
jmp start ; Skip the variable declaration section and go to the start label  
        
;===================================MOKSHA OPERATING SYSTEM COMMAND INTERPRETER VARIABLE DECLARATION SECTION=========================

cmd_size        equ 10               ; Size of the input command in the MCI(Maximum size is 9 characters) 
command_buffer  db cmd_size dup("b") ; Byte Array variable for holding the input command in the MCI 
prompt          db "A:\>", 0         ; The prompt for MCI(Default Symbolizes Floppy Disk A,which is equal to 0 when addressed

; MCI COMMANDS STARTS
chelp    db "help", 0
chelp_tail:
ccls     db "cls", 0
ccls_tail:
cexit    db "exit", 0
cexit_tail:
creboot  db "reboot", 0
creboot_tail:
cver  db "ver", 0
cver_tail:
cos  db "os", 0
cos_tail:   


help_msg db "Moksha Operating System Help", 0Dh,0Ah
         db "The short list of supported commands:", 0Dh,0Ah
         db "help   - print out this list.", 0Dh,0Ah
         db "cls    - clear the screen.", 0Dh,0Ah
         db "reboot - reboot the machine.", 0Dh,0Ah
         db "exit   - same as quit.",0Dh,0Ah 
                        
         

unknown  db "Unknown Moksha Command: " , 0    
; MCI COMMANDS STARTS


;===================================MOKSHA OPERATING SYSTEM COMMAND INTERPRETER VARIABLE DECLARATION SECTION=========================


;----------------------------------------------MOKSHA INTERPRETER COMMAND INPUT CODE STARTS------------------------------------------

start:     ; start label
setvmode() ; Set he defaul video mode defined in MVIDEO.INC                      
; set data segment:
push    cs
pop     ds


; blinking disabled for compatibility with Bios
mov     ax, 1003h
mov     bx, 0      ; disable blinking.
int     10h

;Clear Screen
clrscr()       

;Set Background & Foreground Color.Bit 0 is Backcolor & Bit F is Forecolor              
setbkcolor() 0Fh ;Function is defined in MVIDEO.INC                       

; print out the message:                                                              
cprintf() "MOKSHA COMMAND INTERPRETER (MCI)",32,20,0,4                            
cprintf() "--------------------------------",32,20,1,0FH                            
cprintf() "DEVELOPED BY HEMENDRA SINGH & SURYA RAJ",39,17,2,0BH
cprintf() "C.S.E.,S.R.C.E.M,BANMORE,GWALIOR,M.P.,INDIA",43,15,3,7
cprint()  "A COMMAND LINE INTERPRETER FOR THE MOKSHA OPERATING SYSTEM",58,8,4,8
gotoxy() 0,6 ;Default starting position(X,Y)=(0,4)

eternal_loop: ;Moksha Command Interpreter main loop starts

call    get_command  ;Get a command from the MCI

call    process_cmd  ;Process the command which has been entered by the user in then MCI

; make eternal loop:
jmp eternal_loop ;Moksha Command Interpreter main loop ends

;----------------------------------------------MOKSHA INTERPRETER COMMAND INPUT CODE ENDS--------------------------------------------
get_command proc near

; show prompt:
lea     si, prompt 
call    print_string

; wait for a command:
mov     dx, cmd_size    ; buffer size.
lea     di, command_buffer
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

; compare command buffer with 'version'
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

printf() "" ; Print a blank Line to avoid overwriting on the current x,y position

lea     si, unknown
call    print_string

lea     si, command_buffer
call    print_string

printf() "" ;Print a blank line after displaying the above message  


jmp     processed

;----------------------------------CODE FOR UNKNOWN COMMAND ENDS--------------------------------------------------------------------

     
;----------------------------------MCI COMMANDS OPERATIONAL BODY STARTS-------------------------------------------------------------
 
 cos_command:  
 printf() ""                        ; Print a blank line on the Video Bios in the MCI                                                 
 printf() "MOKSHA OPERATING SYSTEM" ; Print the name of the operating system
 jmp processed                      ; Jump to processed label for finishing the operation
; +++++ 'help' command ++++++
help_command:


lea     si, help_msg
call    print_string

jmp     processed

;////////////////////////////////////VERSION OF THE MCI STARTS//////////////////////////////////////////////////////////////////////
cver_command:    
printf() ""                              
printf() "MCI VERSION 1.0"              
jmp processed
;////////////////////////////////////VERSION OF THE MCI ENDS////////////////////////////////////////////////////////////////////////

; +++++ 'cls' command ++++++
cls_command:
;call    clear_screen
clrscr()
;Set Background & Foreground Color.Bit 0 is Backcolor & Bit F is Forecolor              
setbkcolor() 0Fh ;Function is defined in MVIDEO.INC                       
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
jmp	0ffffh:0000h	 ; reboot!

; ++++++++++++++++++++++++++

;----------------------------------MCI COMMANDS OPERATIONAL BODY--------------------------------------------------------------------

processed:
ret
process_cmd endp

;-----------------------------------------MOKSHA STRING HANDLING PROCEDURES---------------------------------------------------------

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

cmp ah,3bh                      ; Detects F1 key 
je  F1_BREAK                    ; Jumps to F1_BREAK label which terminates the current command and shows the MCI prompt 

cmp     al, 8                   ; 'backspace' pressed?
jne     add_to_buffer
jcxz    wait_for_key            ; nothing to remove!
dec     cx
dec     di
putc()    8                     ; backspace.
putc()    ' '                   ; clear position.
putc()    8                     ; backspace again.
jmp     wait_for_key

add_to_buffer:

        cmp     cx, dx          ; buffer is full?
        jae     wait_for_key    ; if so wait for 'backspace' or 'return'...

        mov     [di], al
        inc     di
        inc     cx
        
        ; print the key:
        mov     ah, 0eh        ; Teletype function
        int     10h            ; Execute Int 10h

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
        mov     ah, 0eh ;teletype function.
        int     10h
        jmp     next_char
printed:

pop     si      ; re-store registers...
pop     ax      ;

ret
print_string endp

;-----------------------------------------MOKSHA STRING HANDLING PROCEDURES---------------------------------------------------------

;-----------------------------------------F1 BREAK HANDLER STARTS-------------------------------------------------------------------
F1_BREAK:
printf() " "
mov    [di], 0 ; terminate by null:
; Clean the string buffer starts
pop     dx     ; Restore DX register 
pop     di     ; Restore DI register
pop     cx     ; Restore CX register
pop     ax     ; Restore AX register
;Clean the string buffer ends
jmp eternal_loop
;-----------------------------------------F1 BREAK HANDLER ENDS---------------------------------------------------------------------
    
ret             




