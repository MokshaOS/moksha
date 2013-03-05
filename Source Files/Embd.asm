
;////////////////////////////////////////EMBEDDED///////////////////////////////////////////////////////////////////
include mvideo.inc
#make_bin#
;org 100h

#CS=8001h#	
#IP=0000h#
#DS=8001h#
#SS=8001h#
#SP=0FFFEh#

jmp start

startup_value   db 512 dup(01h)  
Embedded_buffer db 512 dup(' ')

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


cprintf() "Cross Embedded Sub - System ( Moksha Operating System Embedded Utility )",72,4,1,012

printf() ""                           ; Insert a blank line  
printf() "--------------------------------------------------------------------------------"

;******************************** Read Embedded Data **********************************
 mov ah,02h                                         ;READ
   mov al,01                                        ;SECTORS TO READ
   lea bx,Embedded_buffer                           ;CODE SEGMENT
   mov ch,00                                        ;TRACK/CYLINDER
   mov cl,03                                        ;SECTOR
   mov dh,00                                        ;HEAD
   mov dl,00                                        ;FIRST FLOPPY DISK 
   int 13h                                          ;CALL INTERRUPT 13H[BIOS DISK]        

;******************************** Read Embedded Data **********************************

printf() ""
printf() ""     
cprintf() "Your Embedded Data :-",21,0,5,009 
printf() ""                              
printf() ""
     
lea si,Embedded_buffer                                ; Load File_bufefr into si register for printing on the screen through Video BIOS
                                                 
next_char:      
mov     al, [si]                                  ; Terminate reading if end of file character is found
cmp     al, 23h
jz      printed
        
cmp     al,0dh                                    ; If Carriage return is found , then goto LineFeed label
je      LineFeed
        
continue:
        
inc     si
mov     ah, 0eh                                   ; teletype function.
int     10h
jmp     next_char
        
LineFeed:
mov     ah, 0eh                                   ; teletype function.
mov     al, 0ah 
int     10h                  
        
mov     ah, 0eh                                   ; teletype function.
mov     al, 0dh 
int     10h                  
        
jmp continue
        
printed:

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




