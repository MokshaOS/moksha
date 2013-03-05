
;////////////////////////////////////////CALCULATOR///////////////////////////////////////////////////////////////////
include mvideo.inc
include mmath.inc
include emu8086.inc
#make_bin#
;org 100h

#CS=8001h#	
#IP=0000h#
#DS=8001h#
#SS=8001h#
#SP=0FFFEh#

jmp start

startup_value db 512 dup(01h)  

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

num1 DW ,0
num2 DW ,0

cprintf() "Calculator ( Moksha Operating System Calculator Utility )",59,12,1,012

printf() ""                           ; Insert a blank line  
printf() "--------------------------------------------------------------------------------"

print() "Enter 1st number : "
Call SCAN_NUM                    ; Scan and the result is stored in CX register
mov num1,cx                      ; Store the first variable in 16-bit variable num1   

printf() ""                      ; Insert a blank line 

print() "Enter 2nd number : "
Call SCAN_NUM                    ; Scan and the result is stored in CX register
mov num2,cx                      ; Store the second variable in 16-bit variable num2   

printf() ""
  
printf() "Choose your operator:"   
printf() ""
printf() "+ [Add]"
printf() "- [Minus]"
printf() "* [Multiply]"
printf() "/ [Divide]"
printf() "% [Mod]"
printf() "^ [Power]"
printf() ""
print() "Enter Operator : "
getch()
putc() al

cmp al,'+'
je lbladd

cmp al,'-'
je lblminus

cmp al,'*'
je lblmultiply

cmp al,'/'
je lbldivide

cmp al,'%'
je lblmod

cmp al,'^'
je lblpower:
jne exit


lbladd:  
printf() ""            
print() "Add : "
pusha
mov ax,num1
Call PRINT_NUM
print() " + "
mov ax,num2 
Call PRINT_NUM
print() " = "
add(+)  num1,num2
Call PRINT_NUM
popa              
je exit

lblminus:
printf() ""            
print() "Minus : "
pusha
mov ax,num1
Call PRINT_NUM
print() " - "
mov ax,num2 
Call PRINT_NUM
print() " = "
subtract(-)  num1,num2
Call PRINT_NUM
popa       
je exit
         

lblmultiply:
printf() ""            
print() "Multiply : "
pusha
mov ax,num1
Call PRINT_NUM
print() " * "
mov ax,num2 
Call PRINT_NUM
print() " = "
mov ax,num1
mul num2
mov cx,ax
mov ax,dx
Call PRINT_NUM
mov ax,cx
Call PRINT_NUM
popa       
je exit


lbldivide:
printf() ""            
print() "Divide : "
pusha
mov ax,num1
Call PRINT_NUM
print() " / "
mov ax,num2 
Call PRINT_NUM
print() " = "
mov dx,0
mov ax,num1
div num2
Call PRINT_NUM
popa       
je exit


lblmod:
printf() ""            
print() "Mod : "
pusha
mov ax,num1
Call PRINT_NUM
print() " % "
mov ax,num2 
Call PRINT_NUM
print() " = "
mov dx,0
mov ax,num1
div num2    
mov ax,dx
Call PRINT_NUM
popa       
je exit
               

lblpower:
printf() ""            
print() "Power : "
pusha
mov ax,num1
Call PRINT_NUM
print() " ^ "
mov ax,num2 
Call PRINT_NUM
print() " = " 
mov cx,num2
mov dx,1
sub cx,dx               
mov ax,num1
power:
mul num1
loop power
mov cx,ax
mov ax,dx
Call PRINT_NUM
mov ax,cx
Call PRINT_NUM
popa                    
je exit
               
exit:
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


DEFINE_SCAN_NUM
DEFINE_PRINT_NUM 
DEFINE_PRINT_NUM_UNS
hlt




