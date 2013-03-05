include mvideo.inc
#make_bin#

; BIN is plain binary format similar to .com format, but not limited to 1 segment;
; All values between # are directives, these values are saved into a separate .binf file.
; Before loading .bin file emulator reads .binf file with the same file name.

; All directives are optional, if you don't need them, delete them.

; set loading address, .bin file will be loaded to this address:
#LOAD_SEGMENT=2401h#
#LOAD_OFFSET=0000h#

; set entry point:
#CS=02401h#	; same as loading segment
#IP=0000h#	; same as loading offset

setvmode()

print() "Module 3" 

mov ah,02h        ;READ
mov al,1          ;SECTORS TO READ
mov ch,1          ;CYLINDER
mov cl,1          ;SECTOR
mov dh,0          ;HEAD
mov bx,0201h      ;READ FROM 512 Byte;
mov es,bx         ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h
jmp 0201h:0000h  

getch()            


HLT           ; halt!


