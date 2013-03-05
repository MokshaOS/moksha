
;////////////////////////////////////////BACKUP///////////////////////////////////////////////////////////////////
include mvideo.inc
#make_bin#
;org 100h

#CS=8001h#	
#IP=0000h#
#DS=8001h#
#SS=8001h#
#SP=0FFFEh#

jmp start

startup_value               db 512 dup(01h)  
MFAT16_BKP_buffer           db 512 dup(' ') 

start:
; Set data segment equal to the value of code segment
push cs
pop ds     

; Set stack segment equal to the value of code segment   
mov ax,8001h
mov ss,ax 
mov sp,0fffeh                                     

setvmode()

clrscr()


cprintf() "Backup ( Moksha Operating System File System Backup Utility )",62,9,1,012

printf() ""                           ; Insert a blank line  
printf() "--------------------------------------------------------------------------------"

printf() ""
printf() "Backup started....."



;///////////////File Entry Backup///////////////////////////////   
;******************************** Read MFAT 16 **********************************
 mov ah,02h                                         ;READ
   mov al,01                                        ;SECTORS TO READ
   lea bx,MFAT16_BKP_buffer                         ;CODE SEGMENT
   mov ch,01                                        ;TRACK/CYLINDER
   mov cl,03                                        ;SECTOR
   mov dh,00                                        ;HEAD
   mov dl,00                                        ;FIRST FLOPPY DISK 
   int 13h                                          ;CALL INTERRUPT 13H[BIOS DISK]        

;******************************** Read MFAT 16 **********************************
;******************************** Write Backed Up MFAT 16 **********************************
  mov ah,03h                 ;Write 
   mov al,01                 ;SECTORS TO Write
   lea bx,MFAT16_BKP_buffer  ;CODE SEGMENT
   mov ch,01                 ;TRACK/CYLINDER
   mov cl,04                 ;SECTOR
   mov dh,00                 ;HEAD
   mov dl,00                 ;FIRST FLOPPY DISK 
  int 13h                    ;CALL INTERRUPT 13H[BIOS DISK]

;******************************** Write Backed Up MFAT 16 **********************************
;///////////////File Entry Backup///////////////////////////////

   

printf() ""
printf() "Backup finished."
printf() ""
printf() ""
printf() "Press any key to return to Moksha Command Interpreter."

getch()

mov ah,03h              ;Write 
mov al,01               ;SECTORS TO Write
lea bx,startup_value    ;CODE SEGMENT
mov ch,00               ;TRACK/CYLINDER
mov cl,02               ;SECTOR
mov dh,00               ;HEAD
mov dl,00               ;FIRST FLOPPY DISK 
int 13h                 ;CALL INTERRUPT 13H[BIOS DISK]


mov     ax, 0040h
mov     ds, ax
mov     w.[0072h], 0000h ; cold boot.
jmp	0ffffh:0000h	 ; reboot!


hlt




