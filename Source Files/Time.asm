;///////////////////////////////////////////////////////////Time/////////////////////////////////////////////////////////////////////

include mvideo.inc
include emu8086.inc
;org 100h
#make_bin#

;#LOAD_SEGMENT=2401h#
;#LOAD_OFFSET=0000h#

#CS=8001h#	
#IP=0000h#
#CS=8001h#	                                                   
#DS=8001h#
#SS=8001h#
#SP=0FFFEh#


jmp start:

startup_value db 512 dup(01h)  

;hour dw ?
;min  dw ?
;sec  dw ? 

start:

; Set data segment equal to the value of code segment
push cs
pop ds     

mov ax,8001h
mov ss,ax
mov sp,0fffeh

setvmode()
clrscr()  

cprintf() "Time ( Moksha Operating System Time Accounting Utility )",56,10,1,012
printf() "" ; Insert a blank line  
printf() "--------------------------------------------------------------------------------"
printf() ""

cprintf() "Current Time :-",15,0,5,009 
printf() ""
printf() ""
;**************************Hour*********************************
mov ah,02h         
int 1ah

cmp ch,00h 
mov bh,0
je  ok

cmp ch,01h 
mov bh,1
je  ok

cmp ch,02h 
mov bh,2
je  ok

cmp ch,03h
mov bh,3 
je  ok

cmp ch,04h
mov bh,4 
je  ok

cmp ch,05h
mov bh,5 
je  ok

cmp ch,06h
mov bh,6 
je  ok

cmp ch,07h
mov bh,7 
je  ok

cmp ch,08h
mov bh,8 
je  ok

cmp ch,09h
mov bh,9 
je  ok

cmp ch,10h 
mov bh,10
je  ok

cmp ch,11h
mov bh,11 
je  ok

cmp ch,12h
mov bh,12 
je  ok

cmp ch,13h
mov bh,13 
je  ok

cmp ch,14h
mov bh,14 
je  ok

cmp ch,15h
mov bh,15 
je  ok

cmp ch,16h
mov bh,16 
je  ok

cmp ch,17h
mov bh,17 
je  ok

cmp ch,18h
mov bh,18 
je  ok

cmp ch,19h
mov bh,19 
je  ok    

cmp ch,20h
mov bh,20 
je  ok    

cmp ch,21h
mov bh,21 
je  ok   

cmp ch,22h
mov bh,22 
je  ok   

cmp ch,23h
mov bh,23 
je  ok   



ok:

mov ax,0
mov al,bh  
;mov hour,ax
call PRINT_NUM
print() " : "

;**************************Hour*********************************


;**************************Minute*********************************

mov ah,02h         
int 1ah

cmp cl,00h 
mov bh,0
je  ok1

cmp cl,01h 
mov bh,1
je  ok1

cmp cl,02h 
mov bh,2
je  ok1

cmp cl,03h
mov bh,3 
je  ok1

cmp cl,04h
mov bh,4 
je  ok1

cmp cl,05h
mov bh,5 
je  ok1

cmp cl,06h
mov bh,6 
je  ok1

cmp cl,07h
mov bh,7 
je  ok1

cmp cl,08h
mov bh,8 
je  ok1

cmp cl,09h
mov bh,9 
je  ok1


cmp cl,10h 
mov bh,10
je  ok1

cmp cl,11h
mov bh,11 
je  ok1

cmp cl,12h
mov bh,12 
je  ok1

cmp cl,13h
mov bh,13 
je  ok1

cmp cl,14h
mov bh,14 
je  ok1

cmp cl,15h
mov bh,15 
je  ok1

cmp cl,16h
mov bh,16 
je  ok1

cmp cl,17h
mov bh,17 
je  ok1

cmp cl,18h
mov bh,18 
je  ok1

cmp cl,19h
mov bh,19 
je  ok1    

cmp cl,20h
mov bh,20 
je  ok1    

cmp cl,21h
mov bh,21 
je  ok1   

cmp cl,22h
mov bh,22 
je  ok1   

cmp cl,23h
mov bh,23 
je  ok1


cmp cl,23h
mov bh,23 
je  ok1

cmp cl,24h
mov bh,24 
je  ok1

cmp cl,25h
mov bh,25 
je  ok1


cmp cl,26h
mov bh,26 
je  ok1

cmp cl,27h
mov bh,27 
je  ok1

cmp cl,28h
mov bh,28 
je  ok1

cmp cl,29h
mov bh,29 
je  ok1

cmp cl,30h
mov bh,30 
je  ok1

cmp cl,31h
mov bh,31 
je  ok1

cmp cl,32h
mov bh,32 
je  ok1

cmp cl,33h
mov bh,33 
je  ok1

cmp cl,34h
mov bh,34 
je  ok1

cmp cl,35h
mov bh,35 
je  ok1

cmp cl,36h
mov bh,36 
je  ok1

cmp cl,37h
mov bh,37 
je  ok1

cmp cl,38h
mov bh,38 
je  ok1

cmp cl,39h
mov bh,39 
je  ok1

cmp cl,40h
mov bh,40 
je  ok1

cmp cl,41h
mov bh,41 
je  ok1

cmp cl,42h
mov bh,42 
je  ok1

cmp cl,43h
mov bh,43 
je  ok1

cmp cl,44h
mov bh,44 
je  ok1

cmp cl,45h
mov bh,45 
je  ok1

cmp cl,46h
mov bh,46 
je  ok1

cmp cl,47h
mov bh,47 
je  ok1

cmp cl,48h
mov bh,48 
je  ok1

cmp cl,49h
mov bh,49 
je  ok1

cmp cl,50h
mov bh,50 
je  ok1

cmp cl,51h
mov bh,51 
je  ok1

cmp cl,52h
mov bh,52 
je  ok1

cmp cl,53h
mov bh,53 
je  ok1

cmp cl,54h
mov bh,54 
je  ok1

cmp cl,55h
mov bh,55 
je  ok1

cmp cl,56h
mov bh,56 
je  ok1

cmp cl,57h
mov bh,57 
je  ok1

cmp cl,58h
mov bh,58 
je  ok1

cmp cl,59h
mov bh,56 
je  ok1


ok1:

mov ax,0
mov al,bh  
;mov min,ax
call PRINT_NUM
print() " : "

;**************************Minute*********************************


;**************************Second*********************************

mov ah,02h         
int 1ah

cmp dh,00h 
mov bh,0
je  ok2

cmp dh,01h 
mov bh,1
je  ok2

cmp dh,02h 
mov bh,2
je  ok2

cmp dh,03h
mov bh,3 
je  ok2

cmp dh,04h
mov bh,4 
je  ok2

cmp dh,05h
mov bh,5 
je  ok2

cmp dh,06h
mov bh,6 
je  ok2

cmp dh,07h
mov bh,7 
je  ok2

cmp dh,08h
mov bh,8 
je  ok2

cmp dh,09h
mov bh,9 
je  ok2

cmp dh,10h 
mov bh,10
je  ok2

cmp dh,11h
mov bh,11 
je  ok2

cmp dh,12h
mov bh,12 
je  ok2

cmp dh,13h
mov bh,13 
je  ok2

cmp dh,14h
mov bh,14 
je  ok2

cmp dh,15h
mov bh,15 
je  ok2

cmp dh,16h
mov bh,16 
je  ok2

cmp dh,17h
mov bh,17 
je  ok2

cmp dh,18h
mov bh,18 
je  ok2

cmp dh,19h
mov bh,19 
je  ok2    

cmp dh,20h
mov bh,20 
je  ok2    

cmp dh,21h
mov bh,21 
je  ok2   

cmp dh,22h
mov bh,22 
je  ok2   

cmp dh,23h
mov bh,23 
je  ok2

cmp dh,23h
mov bh,23 
je  ok2

cmp dh,24h
mov bh,24 
je  ok2

cmp dh,25h
mov bh,25 
je  ok2

cmp dh,26h
mov bh,26 
je  ok2

cmp dh,27h
mov bh,27 
je  ok2

cmp dh,28h
mov bh,28 
je  ok2

cmp dh,29h
mov bh,29 
je  ok2

cmp dh,30h
mov bh,30 
je  ok2

cmp dh,31h
mov bh,31 
je  ok2

cmp dh,32h
mov bh,32 
je  ok2

cmp dh,33h
mov bh,33 
je  ok2

cmp dh,34h
mov bh,34 
je  ok2

cmp dh,35h
mov bh,35 
je  ok2

cmp dh,36h
mov bh,36 
je  ok2

cmp dh,37h
mov bh,37 
je  ok2

cmp dh,38h
mov bh,38 
je  ok2

cmp dh,39h
mov bh,39 
je  ok2

cmp dh,40h
mov bh,40 
je  ok2

cmp dh,41h
mov bh,41 
je  ok2

cmp dh,42h
mov bh,42 
je  ok2

cmp dh,43h
mov bh,43 
je  ok2

cmp dh,44h
mov bh,44 
je  ok2

cmp dh,45h
mov bh,45 
je  ok2

cmp dh,46h
mov bh,46 
je  ok2

cmp dh,47h
mov bh,47 
je  ok2

cmp dh,48h
mov bh,48 
je  ok2

cmp dh,49h
mov bh,49 
je  ok2

cmp dh,50h
mov bh,50 
je  ok2

cmp dh,51h
mov bh,51 
je  ok2

cmp dh,52h
mov bh,52 
je  ok2

cmp dh,53h
mov bh,53 
je  ok2

cmp dh,54h
mov bh,54 
je  ok2

cmp dh,55h
mov bh,55 
je  ok2

cmp dh,56h
mov bh,56 
je  ok2

cmp dh,57h
mov bh,57 
je  ok2

cmp dh,58h
mov bh,58 
je  ok2

cmp dh,59h
mov bh,59 
je  ok2


ok2:

mov ax,0
mov al,bh  
;mov sec,ax
call PRINT_NUM

printf() " Hrs"
;**************************Second*********************************

printf() "" ; Print a blank line
printf() "Press any key to return to Moksha Command Interpreter."

getch()

;popa
;mov ah,02h        ;READ
;mov al,6          ;SECTORS TO READ
;mov ch,2          ;CYLINDER
;mov cl,1          ;SECTOR
;mov dh,0          ;HEAD
;mov bx,0201h      ;READ FROM 256 Byte;
;mov es,bx         ;SET EXTRA SEGMENT REGISTER
;mov bx,0                                                             
;int 13h
;jmp 0201h:0000h    

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


;hlt

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS


