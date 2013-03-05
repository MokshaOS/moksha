include emu8086.inc
#make_boot#

org 7c00h      ; set location counter.

; set data segment:
xor     ax, ax
mov     ds, ax

; set default video mode 80x25:
mov     ah, 00h ;VIDEO BIOS
mov     al, 03h ;GRAPHICS MODE,RESOLUTION 720X400 PIXELS
int     10h     ;CALL INTERRUPT 10H VIDEO BIOS


gotoxy 20,1
printn "MOKSHA OPERATING SYSTEM BOOT LOADER"
gotoxy 20,2
printn "==================================="
printn ""
printn " Developed by Hemendra Singh & Surya Raj of S.R.C.E.M.,C.S.E,Gwalior,M.P.,INDIA"
gotoxy 20,12
printn "Press any key to continue..."
gotoxy 3,22
printn "ALL RIGHTS RESERVED BY HEMENDRA SINGH & SURYA RAJ.COPYRIGHT @ DECEMBER 2008"


;WAIT FOR A KEY
mov ah,10h
int 16h

;LOAD KERNEL INTO RAM
mov ah,02h ;READ
mov al,13  ;SECTORS TO READ
mov ch,0   ;CYLINDER
mov cl,2   ;SECTOR
mov dh,0   ;HEAD
mov bx,0201h ;READ FROM 513 Byte i.e. start of sector 2;
mov es,bx    ;SET EXTRA SEGMENT REGISTER
mov bx,0
int 13h
jmp 0201h:0000h
hlt



; [SOURCE]: C:\Documents and Settings\surya\Desktop\MBL\MBL\Source Code\mbl.asm
