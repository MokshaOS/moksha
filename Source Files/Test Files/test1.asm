include mvideo.inc                 
include mdisk.inc
#make_bin#

#LOAD_SEGMENT=0201h#
#LOAD_OFFSET=0000h#


#CS=0201h#	
#IP=0000h#	

setvmode()
clrscr()   
printf() "Jumping to another Code Segment"
mov ax,02h           
jmp 0401h:0000h      

lb1:printf() "Back to Code Segment 1"
getch()

