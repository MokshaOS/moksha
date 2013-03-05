;////////////Primary Boot Loader//////////////////////////

include mvideo.inc
#make_boot#

org 7c00h      ; set location counter.
; set data segment:
xor     ax, ax
mov     ds, ax
 
                                                                                                                                      
;LOAD Secondary Boot Loader INTO RAM
mov ah,02h   ;READ
mov al,8     ;SECTORS TO READ
mov ch,14    ;CYLINDER
mov cl,1     ;SECTOR
mov dh,0     ;HEAD
mov bx,880Ah ;READ FROM 513 Byte i.e. start of sector 2;
mov es,bx    ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h
jmp 880Ah:0000h    

hlt         