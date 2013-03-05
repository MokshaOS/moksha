#write.inc#


buffer DB 512 dup('')
mov ah,03h            ;WRITE 
mov al,secttoread     ;SECTORS TO READ
mov ch,track          ;TRACK/CYLINDER
mov cl,sectno         ;SECTOR
mov dl,drive          ;FIRST FLOPPY DISK 
mov dh,head           ;HEAD
lea bx,buffer         ;MOVE BUFFER ADDRESS TO BX          
mov es,bx             ;SET EXTRA SEGMENT REGISTER TO ADDRESS OF BUFFER                                              
int 13h               ;CALLING INTERRUPT 13H
RET                   ;RETURN TO O.S.


