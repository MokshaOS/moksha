;|===============================================================================================================|
;|                                       MOKSHA BIOS DISK[INT 13H] SYSTEM CALLS                                  |
;|===============================================================================================================|
;|_______________________________________________________________________________________________________________|
;|                                      DEVELOPED FOR THE MOKSHA OPERATING SYSTEM                                | 
;|                                      -------------------------------------------                              |
;|                                                    BY                                                         |
;|                                        HEMENDRA SINGH AND SURYA RAJ                                           |
;|                                        S.R.C.E.M.,GWALIOR,M.P.,INDIA                                          |
;|_______________________________________________________________________________________________________________| ;|_________________________________ALL RIGHTS ARE RESERVED BY THE DEVELOPERS_____________________________________|     

;------------------------------------EXECUTES A BINARY FILE-------------------------------------------------------

                    ;NOTE THIS WILL ONLY EXECUTE A BINARY FILE ON THE FLOPPY DISK NO 0.
                    ;IN ORDER TO CHANGE THE DRIVE,MOVE THE VALUE IN DL REGISTER

run() macro head,track,start_sector,nsectors,code_segment
mov ah,02h          ;READ
mov al,nsectors     ;SECTORS TO READ
mov ch,track        ;TRACK/CYLINDER
mov cl,start_sector ;SECTOR
mov dh,head         ;HEAD
mov dl,0            ;FIRST FLOPPY DISK 
mov bx,code_segment ;CODE SEGMENT
mov es,bx           ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                                                   
int 13h             ;CALL INTERRUPT 13H[BIOS DISK]
jmp code_segment:0000h 
hlt   
endm

;------------------------------------EXECUTES A BINARY FILE-------------------------------------------------------


;------------------------------------WRITES ANY FILE--------------------------------------------------------------

                    ;NOTE THIS WILL ONLY WRITE A FILE ON THE FLOPPY DISK NO 0.
                    ;IN ORDER TO CHANGE THE DRIVE,MOVE THE VALUE IN DL REGISTER

write() macro head,track,start_sector,nsectors,write_data
data db write_data,0
mov ah,03h                  ;READ
mov al,nsectors             ;SECTORS TO READ
mov ch,track                ;TRACK/CYLINDER
mov cl,start_sector         ;SECTOR
mov dl,0                    ;FIRST FLOPPY DISK 
mov dh,head                 ;HEAD
mov bx,offset data           
mov es,bx                   ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h
endm

;------------------------------------WRITES ANY FILE--------------------------------------------------------------


