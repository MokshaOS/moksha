
include mvideo.inc                 

#make_bin#

#LOAD_SEGMENT=0401h#
#LOAD_OFFSET=0000h#


#CS=0401h#	
#IP=0000h#	   
cmp ax,02h
je lby:
jne lbn:
lby:
printf() "EQUAL"
jmp 0201h:005Ch 
hlt
lbn:
printf() "NOT EQUAL"  

ipbk dw equ 0
hlt







