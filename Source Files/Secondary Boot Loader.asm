;///////////////////SECONDARY BOOT LOADER//////////////////////

include mvideo.inc                 
include mdtimer.inc

#make_bin#

;#LOAD_SEGMENT=0201h#
;#LOAD_OFFSET=0000h#


#CS=880Ah#	
#IP=0000h#
#DS=880Ah#
#SS=880Ah#
#SP=0FFFEh#

jmp start

startup_value         db 512 dup(' ')
actual_value          db 1   dup (' ')
default_startup_value db 512 dup (00h)  
start:
	
; Set data segment equal to the value of code segment
push cs
pop ds     

; Set stack segment equal to the value of code segment   
mov ax,880Ah
mov ss,ax 
mov sp,0fffeh                                     


setvmode()

clrscr()

nocursor()

; Startup Value

 mov ah,02h                                       ;READ
 mov al,01                                        ;SECTORS TO READ
 lea bx,startup_value                             ;CODE SEGMENT
 mov ch,00                                        ;TRACK/CYLINDER
 mov cl,02                                        ;SECTOR
 mov dh,00                                        ;HEAD
 mov dl,00                                        ;FIRST FLOPPY DISK 
 int 13h                                          ;CALL INTERRUPT 13H[BIOS DISK]        
 
 ; Extract 1 Byte from the starup value for Byte comparison
 CLD
 lea si,startup_value
 lea di,actual_value
 mov cx,1
 rep movsb
 
 ; Compare the startup value
 cmp actual_value,01h
 je go_directly_to_shell1
 jne continue_loading
 
 go_directly_to_shell1:
 ; Write the defualt entry for the startup value
 mov ah,03h                    ;Write 
 mov al,01                     ;SECTORS TO Write
 lea bx,default_startup_value  ;CODE SEGMENT
 mov ch,00                     ;TRACK/CYLINDER
 mov cl,02                     ;SECTOR
 mov dh,00                     ;HEAD
 mov dl,00                     ;FIRST FLOPPY DISK 
 int 13h                       ;CALL INTERRUPT 13H[BIOS DISK]
 
 jmp go_directly_to_shell
 
; Startup Value
 
 continue_loading:


     
cprintf() "MOKSHA OPERATING SYSTEM",24,27,2,04
cprintf() "-----------------------",24,27,3,00FH
cprintf() "Developed By Hemendra Singh & Surya Raj",41,18,6,00FH
cprintf() "C.S.E.,4th Year,S.R.C.E.M.,Banmore,Gwalior,M.P.,India",55,11,7,008H                                                                                                                                                                

cprint() "------------------------",24,24,15,00FH ; Upper Line
cprint() "|",1,24,16,00FH ; Left Side Line
cprint() "|",1,47,16,00FH ; Left Side Line
cprint() "------------------------",24,24,17,00FH ; Lower Line

         
delay() 2
         
gotoxy() 26,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 5%",10,30,18,007H

gotoxy() 27,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 10%",11,30,18,007H

gotoxy() 28,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 15%",11,30,18,007H

gotoxy() 29,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 20%",11,30,18,007H

gotoxy() 30,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 25%",11,30,18,007H

gotoxy() 31,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 30%",11,30,18,007H

gotoxy() 32,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 35%",11,30,18,007H

gotoxy() 33,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 40%",11,30,18,007H

gotoxy() 34,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 45%",11,30,18,007H

gotoxy() 35,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 50%",11,30,18,007H

gotoxy() 36,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 55%",11,30,18,007H

gotoxy() 37,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 60%",11,30,18,007H

gotoxy() 38,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 65%",11,30,18,007H

gotoxy() 39,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 70%",11,30,18,007H

gotoxy() 40,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 75%",11,30,18,007H

gotoxy() 41,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 80%",11,30,18,007H

gotoxy() 42,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 85%",11,30,18,007H

gotoxy() 43,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 90%",11,30,18,007H

gotoxy() 44,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 95%",11,30,18,007H

gotoxy() 45,16
delay() 1
cputc() 0DBH,4 
cprintf() "Loading 100%",11,30,18,007H

; Go to User Login
popa
mov ah,02h        ;READ
mov al,2          ;SECTORS TO READ
mov ch,16         ;CYLINDER
mov cl,1          ;SECTOR
mov dh,0          ;HEAD
mov bx,2001h      ;READ FROM 256 Byte;
mov es,bx         ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h
jmp 2001h:0000h    


go_directly_to_shell:

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

hlt



                                                 