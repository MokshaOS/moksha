;------------------WRITES ANY FILE----------------------------------

   ;NOTE THIS WILL ONLY WRITE A FILE ON THE FLOPPY DISK NO 0.
   ;IN ORDER TO CHANGE THE DRIVE,MOVE THE VALUE IN DL REGISTER


write() macro secttoread,track,sectno,head,drive  

buffer DB 512 dup('')
mov ah,03h          ;WRITE 
mov al,secttoread   ;SECTORS TO READ
mov ch,track        ;TRACK/CYLINDER
mov cl,sectno       ;SECTOR
mov dl,drive        ;FIRST FLOPPY DISK 
mov dh,head         ;HEAD
lea bx,buffer       ;MOVE BUFFER ADDRESS TO BX          
mov es,bx           ;SET EXTRA SEGMENT REGISTER TO ADDRESS OF BUFFER                                              
int 13h
endm  

include emu8086.inc
#make_bin# 
write() 1,0,1,0,0  
buffer DB 512 dup('')
mov ah,03h          ;WRITE 
mov al,secttoread   ;SECTORS TO READ
mov ch,track        ;TRACK/CYLINDER
mov cl,sectno       ;SECTOR
mov dl,drive        ;FIRST FLOPPY DISK 
mov dh,head         ;HEAD
lea bx,buffer       ;MOVE BUFFER ADDRESS TO BX          
mov es,bx           ;SET EXTRA SEGMENT REGISTER TO ADDRESS OF BUFFER                                              
int 13h