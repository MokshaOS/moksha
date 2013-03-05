include mvideo.inc        ;Include mvideo.inc file for handling the Video Bios[Int 10H]
include mdtimer.inc       ; For using delay() function

#make_bin#

#LOAD_SEGMENT=0201h#
#LOAD_OFFSET=0000h#


#CS=0201h#	
#IP=0000h#	

;org 100h
jmp start ;Skip the variable declaration section and goo he start label  
        
;===================================MOKSHA OPERATING SYSTEM COMMAND INTERPRETER VARIABLE DECLARATION SECTION=========================

cmd_size           equ 10                ; size of command_buffer
command_buffer     db cmd_size dup("b")  ; Command Buffer for accepting commands from the user
;clean_str          db 14 dup(" "), 0
prompt             db "A:\>", 0           
;suspended_duration dw ?

; MOKSHA COMMANDS
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
cmfile  db "mfile", 0
cmfile_tail:
clfile  db "list", 0
clfile_tail:
crfile  db "rfile", 0
crfile_tail:
cdelete  db "delete", 0
cdelete_tail:
crm  db "rm", 0
crm_tail:
cfsize  db "fsize", 0
cfsize_tail:
cshutdown  db "shutdown", 0
cshutdown_tail:
ctime  db "time", 0
ctime_tail:
ccalc  db "calc", 0
ccalc_tail:
cembedded  db "embdd", 0
cembedded_tail:
cbackup  db "backup", 0
cbackup_tail:


         
help_msg db "", 0Dh,0Ah
         db "Moksha Operating System Help", 0Dh,0Ah
         db "Moksha Operating System list of supported commands are as follows :-", 0Dh,0Ah,0dh,0ah
         db "help     - Shows available Moksha Command Interpreter ( MCI ) commands.", 0Dh,0Ah
         db "cls      - Clears the screen.", 0Dh,0Ah
         db "reboot   - Reboots the machine.", 0Dh,0Ah
         db "time     - Gets the current time.", 0Dh,0Ah 
         db "calc     - Opens the Calculator for mathematical calculations",0Dh,0Ah        
         db "mfile    - Creates a file.",0Dh,0Ah     
         db "rfile    - Reads a file.",0Dh,0Ah                                                      
         db "fsize    - Shows the size of user created file.",0Dh,0Ah         
         db "list     - Shows the list of user created files.",0Dh,0Ah
         db "delete   - Deletes a file.",0Dh,0Ah   
         db "rm       - Deletes a file.",0Dh,0Ah     
         db "shutdown - Shuts down Moksha Operating System and the computer.",0Dh,0Ah 
         db "ver      - Shows the version of Moksha Command Interpreter ( MCI ).",0Dh,0Ah 
         db "os       - Shows the name of Operating System.",0Dh,0Ah 
         db "embdd    - Opens the Cross - O.S. Embedded utility.",0Dh,0Ah
         db "backup   - Back's up MFAT - 16 filesystem.",0Dh,0Ah          
         db "exit     - Terminates Moksha Oerating System And Reboots the machine.",0Dh,0Ah,0dh,0ah,0
          
         


unknown  db "Unrecognised Moksha Command: " , 0    

;===================================MOKSHA OPERATING SYSTEM COMMAND INTERPRETER VARIABLE DECLARATION SECTION=========================


;----------------------------------------------MOKSHA INTERPRETER COMMAND INPUT CODE------------------------------------------------

start:     ;start label

; set data segment:
push    cs
pop     ds

; Set stack segment equal to the value of code segment   
mov ax,0201h
mov ss,ax
mov sp,0fffeh                                     

setvmode() ;Set the default video mode defined in MVIDEO.INC


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
cprintf() "MOKSHA COMMAND INTERPRETER",26,25,2,012 
cprintf() "--------------------------",26,25,3,7
delay() 1  ; Delay by 1 seconds              
cprintf() "A Command Line Interpreter Developed for the Moksha Operating System",71,5,5,15
cprintf() "By Hemendra Singh & Surya Raj C.S.E. ,S.R.C.E.M ,Gwalior,M.P.",62,8,6,2 
putc() 0AH ; New Line 
putc() 0AH ; New Line                                                                               
delay() 1  ; Delay by 1 seconds 


;gotoxy() 0,5 ;Default starting position(X,Y)=(0,4)
;rcursor()
eternal_loop: ;Moksha Command Interpreter main loop starts

call    get_command

call    process_cmd

; make eternal loop:
jmp eternal_loop ;Moksha Command Interpreter main loop ends

;----------------------------------------------MOKSHA INTERPRETER COMMAND INPUT CODE------------------------------------------------
get_command proc near


; Get cursor position
;mov ah,03h
;mov bh,0
;int 10h
;Return DH = Row , DL = Column

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
process_cmd proc near    

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

; compare command buffer with 'os'
lea     si, command_buffer
mov     cx, cos_tail - offset cos  ; size of ['reboot',0] string.
lea     di, cos
repe    cmpsb
je      cos_command              

; compare command buffer with 'mfile'
lea     si, command_buffer
mov     cx, cmfile_tail - offset cmfile  ; size of ['reboot',0] string.
lea     di, cmfile
repe    cmpsb
je      cmfile_command

; compare command buffer with 'lfile'
lea     si, command_buffer
mov     cx, clfile_tail - offset clfile  ; size of ['reboot',0] string.
lea     di, clfile
repe    cmpsb
je      clfile_command   

; compare command buffer with 'rfile'
lea     si, command_buffer
mov     cx, crfile_tail - offset crfile  ; size of ['reboot',0] string.
lea     di, crfile
repe    cmpsb
je      crfile_command
   
; compare command buffer with 'delete'
lea     si, command_buffer
mov     cx, cdelete_tail - offset cdelete  ; size of ['reboot',0] string.
lea     di, cdelete
repe    cmpsb
je      cdelete_command

; compare command buffer with 'rm'
lea     si, command_buffer
mov     cx, crm_tail - offset crm  ; size of ['reboot',0] string.
lea     di, crm
repe    cmpsb
je      cdelete_command

; compare command buffer with 'fsize'
lea     si, command_buffer
mov     cx, cfsize_tail - offset cfsize  ; size of ['reboot',0] string.
lea     di, cfsize
repe    cmpsb
je      cfsize_command

; compare command buffer with 'shutdown'
lea     si, command_buffer
mov     cx, cshutdown_tail - offset cshutdown  ; size of ['reboot',0] string.
lea     di, cshutdown
repe    cmpsb
je      cshutdown_command

; compare command buffer with 'time'
lea     si, command_buffer
mov     cx, ctime_tail - offset ctime  ; size of ['reboot',0] string.
lea     di, ctime
repe    cmpsb
je      ctime_command

; compare command buffer with 'calc'
lea     si, command_buffer
mov     cx, ccalc_tail - offset ccalc  ; size of ['reboot',0] string.
lea     di, ccalc
repe    cmpsb
je      ccalc_command

; compare command buffer with 'embedded'
lea     si, command_buffer
mov     cx, cembedded_tail - offset cembedded  ; size of ['reboot',0] string.
lea     di, cembedded
repe    cmpsb
je      cembedded_command

; compare command buffer with 'backup'
lea     si, command_buffer
mov     cx, cbackup_tail - offset cbackup ; size of ['reboot',0] string.
lea     di, cbackup
repe    cmpsb
je      cbackup_command
                 
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
 printf() ""                          
 printf() "MOKSHA OPERATING SYSTEM"
 jmp processed


;///////////////////mfile command/////////////////////   
cmfile_command:                                           

popa              ; Unlock all genreal purpose registers for running external programs

mov ah,02h        ;READ
mov al,17         ;SECTORS TO READ
mov ch,8          ;CYLINDER
mov cl,1          ;SECTOR
mov dh,0          ;HEAD
mov bx,2401h      ;READ FROM 512 Byte;
mov es,bx         ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h  
jmp 2401h:0000h      
;///////////////////mfile command/////////////////////  

;///////////////////lfile command/////////////////////   
clfile_command:                                           

popa              ; Unlock all genreal purpose registers for running external programs

mov ah,02h        ;READ
mov al,6         ;SECTORS TO READ
mov ch,9          ;CYLINDER
mov cl,1          ;SECTOR
mov dh,0          ;HEAD
mov bx,4801h      ;READ FROM 512 Byte;
mov es,bx         ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h  
jmp 4801h:0000h      
;///////////////////lfile command/////////////////////
  
;///////////////////rfile command/////////////////////   
crfile_command:                                           

popa              ; Unlock all genreal purpose registers for running external programs

mov ah,02h        ;READ
mov al,6          ;SECTORS TO READ
mov ch,10         ;CYLINDER
mov cl,1          ;SECTOR
mov dh,0          ;HEAD
mov bx,5401h      ;READ FROM 512 Byte;
mov es,bx         ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h  
jmp 5401h:0000h      
;///////////////////rfile command/////////////////////

;///////////////////delete command/////////////////////   
cdelete_command:                                           

popa              ; Unlock all genreal purpose registers for running external programs

mov ah,02h        ;READ
mov al,10         ;SECTORS TO READ
mov ch,11         ;CYLINDER
mov cl,1          ;SECTOR
mov dh,0          ;HEAD
mov bx,6001h      ;READ FROM 512 Byte;
mov es,bx         ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h  
jmp 6001h:0000h      
;///////////////////rfile command/////////////////////  
     
;///////////////////fsize command/////////////////////   
cfsize_command:                                           

popa              ; Unlock all genreal purpose registers for running external programs

mov ah,02h        ;READ
mov al,6          ;SECTORS TO READ
mov ch,12         ;CYLINDER
mov cl,1          ;SECTOR
mov dh,0          ;HEAD
mov bx,7401h      ;READ FROM 512 Byte;
mov es,bx         ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h  
jmp 7401h:0000h      
;///////////////////fsize command/////////////////////  

;///////////////////shutdown command/////////////////////   
cshutdown_command:                                           

; Shutdown Moksha Operating System and the computer
mov ah,53h
mov al,07h
mov bx,0001h
mov cx,0003h
int 15h

;///////////////////shutdown command/////////////////////
  
;///////////////////time command/////////////////////   
ctime_command:                                           

popa              ; Unlock all genreal purpose registers for running external programs

mov ah,02h        ;READ
mov al,6          ;SECTORS TO READ
mov ch,13         ;CYLINDER
mov cl,1          ;SECTOR
mov dh,0          ;HEAD
mov bx,8001h      ;READ FROM 512 Byte;
mov es,bx         ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h  
jmp 8001h:0000h      
;///////////////////time command///////////////////// 
 
;///////////////////calc command/////////////////////   
ccalc_command:                                           

popa              ; Unlock all genreal purpose registers for running external programs

mov ah,02h        ;READ
mov al,6          ;SECTORS TO READ
mov ch,15         ;CYLINDER
mov cl,1          ;SECTOR
mov dh,0          ;HEAD
mov bx,8001h      ;READ FROM 512 Byte;
mov es,bx         ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h  
jmp 8001h:0000h      
;///////////////////calc command/////////////////////

;///////////////////embedded command/////////////////////   
cembedded_command:                                           

popa              ; Unlock all genreal purpose registers for running external programs

mov ah,02h        ;READ
mov al,4          ;SECTORS TO READ
mov ch,17         ;CYLINDER
mov cl,1          ;SECTOR
mov dh,0          ;HEAD
mov bx,8001h      ;READ FROM 512 Byte;
mov es,bx         ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h  
jmp 8001h:0000h      
;///////////////////embedded command/////////////////////   

;///////////////////backup command/////////////////////   
cbackup_command:                                           

popa              ; Unlock all genreal purpose registers for running external programs

mov ah,02h        ;READ
mov al,4          ;SECTORS TO READ
mov ch,18         ;CYLINDER
mov cl,1          ;SECTOR
mov dh,0          ;HEAD
mov bx,8001h      ;READ FROM 512 Byte;
mov es,bx         ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h  
jmp 8001h:0000h      
;///////////////////embedded command/////////////////////   
  
; +++++ 'help' command ++++++
help_command: 

lea     si, help_msg
call    print_string      
jmp     processed


cver_command:    
printf() ""               
printf() "Moksha Command Interpreter ( MCI ) ver 1.0"              

jmp processed

;///////////////////cls command///////////////////// 
cls_command:
;call    clear_screen
clrscr()
;Set Background & Foreground Color.Bit 0 is Backcolor & Bit F is Forecolor              
setbkcolor() 0Fh ;Function is defined in MVIDEO.INC                       
jmp     processed
;///////////////////cls command///////////////////// 

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


