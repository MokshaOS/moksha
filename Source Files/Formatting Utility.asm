;///////////////////Formatting Utility//////////////////////

include mvideo.inc                 

;#make_bin#

;#LOAD_SEGMENT=0100h#
;#LOAD_OFFSET=0000h#


;#CS=0100h#	
;#IP=0000h#	
org 100h
formatting_buffer db 512 dup(00h)

setvmode()

printf() "Formatting Started"

 mov ah,03h       ;Write 
   mov al,1      ;SECTORS TO Write
   lea bx,formatting_buffer ;CODE SEGMENT
   mov ch,01      ;TRACK/CYLINDER
   mov cl,01      ;SECTOR
   mov dh,00      ;HEAD
   mov dl,00      ;FIRST FLOPPY DISK 
   int 13h        ;CALL INTERRUPT 13H[BIOS DISK]    
   
  mov ah,03h       ;Write 
   mov al,1      ;SECTORS TO Write
   lea bx,formatting_buffer ;CODE SEGMENT
   mov ch,01      ;TRACK/CYLINDER
   mov cl,02      ;SECTOR
   mov dh,00      ;HEAD
   mov dl,00      ;FIRST FLOPPY DISK 
   int 13h        ;CALL INTERRUPT 13H[BIOS DISK]    

printf() "Formatting Completed"
getch()

hlt