;////////////////////////////////////////////////////////Hyper Terminal///////////////////////////////////////////////////////////////
                                                                            
include mvideo.inc                 
include emu8086.inc
include mdtimer.inc

;org 100h
#make_bin#

#LOAD_SEGMENT=8001h#
#LOAD_OFFSET=0000h#

#CS=8001h#	
#IP=0000h#
#DS=8001h#
#SS=8001h#
#SP=0FFFEh#

jmp start:

PORT_NO dw  ?                                                      ; Jump to the start label

start:

; Set data segment equal to the value of code segment
push cs
pop ds     

; Set stack segment equal to the value of code segment   
mov ax,8001h
mov ss,ax 
mov sp,0fffeh                                     

setvmode()   

cprintf() "Hyper Terminal ( Moksha Operating System Communication Utility )",65,10,1,012
printf() "" ; Insert a blank line  
printf() "--------------------------------------------------------------------------------"

printf() ""

printf() "Settings - [ Baud Rate - 9600 ,Data Bits - 8 ,Parity - No Parity ,Stop Bit - 1 ]" 
printf() ""

print() "Enter the port number [ Com1 - 0 , Com2 - 1 , Com3 - 2 , Com4 - 3 ] - "
 
call SCAN_NUM

mov PORT_NO,cx 

; Initialise Serial Communication

mov ah,00h
mov al,11100111b
mov dx,PORT_NO
int 14h


start_serial_communication:
; Input the data to be sent through serial communication
mov ah,0
int 16h  

;**********Send Data********************
;mov ah,01h
;mov dx,PORT_NO
;int 14h
;**********Send Data********************

;**********Receive Data********************
mov ah,02h
mov dx,PORT_NO
int 14h
;**********Receive Data********************

putc() al

delay() 1
jmp start_serial_communication

hlt

DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS