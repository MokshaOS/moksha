include emu8086.inc
#make_bin#

; BIN is plain binary format similar to .com format, but not limited to 1 segment;
; All values between # are directives, these values are saved into a separate .binf file.
; Before loading .bin file emulator reads .binf file with the same file name.

; All directives are optional, if you don't need them, delete them.

; set loading address, .bin file will be loaded to this address:
#LOAD_SEGMENT=0201h#
#LOAD_OFFSET=0000h#

; set entry point:
#CS=0201h#	; same as loading segment
#IP=0000h#	; same as loading offset

call CLEAR_SCREEN
;org 100h   
gotoxy 30,1   
printn "MOKSHA KERNEL"
;printn "DEVELOPED BY HEMENDRA SINGH & SURYA RAJ OF C.S.E.,S.R.C.E.M.,Gwalior"  
putc 0dh,0ah ;CARRIAGE RETURN[LEFT POSITION OF SCREEN],LINE FEED[ADVANCE TO NEXT LINE]    
printn ""
printn "  MOKSHA BOOTUP SYSTEM CONFIGURATION:"

putc 0dh,0ah ;CARRIAGE RETURN[LEFT POSITION OF SCREEN],LINE FEED[ADVANCE TO NEXT LINE]    
putc 0dh,0ah ;CARRIAGE RETURN[LEFT POSITION OF SCREEN],LINE FEED[ADVANCE TO NEXT LINE]   
printn ""
printn "  |==========================================================================|"
printn "  |                OS NAME              = MOKSHA                             |"                                            
printn "  |                OS TYPE              = CONSOLE                            |"                                           
printn "  |                VIDEO BIOS MODE      = GRAPHICS MODE                      |"                                     
printn "  |                RESOLUTION SUPPORTED = 720x400                            |"
printn "  |                COLOUR PALETTE       = 16                                 |"
printn "  |==========================================================================|" 


putc 0dh,0ah ;CARRIAGE RETURN[LEFT POSITION OF SCREEN],LINE FEED[ADVANCE TO NEXT LINE]   
putc 0dh,0ah ;CARRIAGE RETURN[LEFT POSITION OF SCREEN],LINE FEED[ADVANCE TO NEXT LINE]   
printn ""
printn "PRESS ANY KEY TO REBOOT COMPUTER..."  
mov ah,10h
int 16h

call CLEAR_SCREEN
printn "PLEASE TAKE OUT ANY DISKETTE FROM THE DISK DRIVE..."
; reboot...
;mov     ax, 0040h
;mov     ds, ax
;mov     w.[0072h], 0000h
;jmp	0ffffh:0000h	 
; *** ok ***  ;Restart Computer
mov ax,0
mov bx,0
mov cx,0
mov dx,0
mov si,0
mov di,0                              
DEFINE_CLEAR_SCREEN
HLT           ; halt!
;ret

