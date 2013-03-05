;|===============================================================================================================|
;|                                       MOKSHA MFAT16 Backup SYSTEM CALLS                                        |
;|===============================================================================================================|
;|_______________________________________________________________________________________________________________|
;|                                      DEVELOPED FOR THE MOKSHA OPERATING SYSTEM                                | 
;|                                      -------------------------------------------                              |
;|                                                    BY                                                         |
;|                                        HEMENDRA SINGH AND SURYA RAJ                                           |
;|                                        S.R.C.E.M.,GWALIOR,M.P.,INDIA                                          |
;|_______________________________________________________________________________________________________________| 
;|_________________________________ALL RIGHTS ARE RESERVED BY THE DEVELOPERS_____________________________________|     

;-#1-----------------------Procedure To Backup MFAT 16---------------------------------------------------------------

MFAT16Backup proc
;////*******************************Backup MFAT 16 File System****************************////
MFAT16_buffer             db    512      dup (' ')   ; 16 byte MFAT buffer for reading and writing information 
;******************************** Read Original MFAT 16 **********************************
 mov ah,02h                                         ;READ
   mov al,01                                        ;SECTORS TO READ
   lea bx,MFAT16_buffer                             ;CODE SEGMENT
   mov ch,01                                        ;TRACK/CYLINDER
   mov cl,03                                        ;SECTOR
   mov dh,00                                        ;HEAD
   mov dl,00                                        ;FIRST FLOPPY DISK 
   int 13h                                          ;CALL INTERRUPT 13H[BIOS DISK]        

;******************************** Read Original MFAT 16 **********************************
;******************************** Write Backup MFAT 16 **********************************
 mov ah,03h                                         ;WRITE
   mov al,01                                        ;SECTORS TO READ
   lea bx,MFAT16_buffer                             ;CODE SEGMENT
   mov ch,01                                        ;TRACK/CYLINDER
   mov cl,04                                        ;SECTOR
   mov dh,00                                        ;HEAD
   mov dl,00                                        ;FIRST FLOPPY DISK 
   int 13h                                          ;CALL INTERRUPT 13H[BIOS DISK]        

;******************************** Write Backup MFAT 16 **********************************
;////*******************************Backup MFAT 16 File System****************************////
ret
MFAT16Backup endp

;--------------------------Procedure To Backup MFAT 16---------------------------------------------------------------


