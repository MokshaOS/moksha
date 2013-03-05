;///////////////////////////////////////////////////////////List/////////////////////////////////////////////////////////////////////
                                                                                                       
include mvideo.inc                 
include emu8086.inc
org 100h
;#make_bin#

;#LOAD_SEGMENT=2401h#
;#LOAD_OFFSET=0000h#


;#CS=4801h#	
;#IP=0000h#
;#CS=4801h#	                                                   
;#DS=4801h#
;#SS=4801h#
;#SP=0FFFEh#
	                                                                ; Jump to the start label
jmp start:

MFAT16_buffer             db    512      dup (' ')   ; 16 byte MFAT buffer for reading and writing information 
MFAT16_total_file_count   db    512      dup (' ')   ; Gets and sets the total file count in the file system
MFAT16_filename           db    10       dup (' ')   ; The filename present in the MFAT 16 filesyatem
MFAT16_incrementer        dw    1        dup (00h)   ; Increment MFAT 16 filesystem by 16 each time
MFAT16_empty_filename     db    10       dup (' ')   ; Flushes the MFAT16_filename each time for finding the next file
File_buffer               db    512      dup (' ')   ; Reads the user file stored in the floppy disk
MFAT16_size               db    1        dup (' ')   ; Calculates the size of MFAT 16 filesystem

start:        

; Set data segment equal to the value of code segment
;push cs
;pop ds     

;mov ax,4801h
;mov ds,ax
;mov ss,ax
;mov sp,0fffeh

; Set stack segment equal to the value of code segment   
;mov ax,2401h
;mov ss,ax
;mov sp,0fffeh                                     

setvmode()
clrscr() 

cprintf() "List ( Moksha Operating System File Listing Utility )",53,10,1,012
printf() "" ; Insert a blank line  
printf() "--------------------------------------------------------------------------------"
printf() ""
cprintf() "List of files present :-",25,0,5,009
printf() ""            

printf() ""

;////////////////////////////MFAT 16/////////////////////////////////////////////////////////////////////////////

 
;******************************** Read MFAT 16 **********************************
 mov ah,02h                                         ;READ
   mov al,01                                        ;SECTORS TO READ
   lea bx,MFAT16_buffer                             ;CODE SEGMENT
   mov ch,01                                        ;TRACK/CYLINDER
   mov cl,03                                        ;SECTOR
   mov dh,00                                        ;HEAD
   mov dl,00                                        ;FIRST FLOPPY DISK 
   int 13h                                          ;CALL INTERRUPT 13H[BIOS DISK]        

;******************************** Read MFAT 16 **********************************
   
;******************************** Get MFAT 16 Size ******************************
  mov ah,02h                                        ;READ
   mov al,01                                        ;SECTORS TO READ
   lea bx,MFAT16_total_file_count                   ;CODE SEGMENT
   mov ch,01                                        ;TRACK/CYLINDER
   mov cl,02                                        ;SECTOR
   mov dh,00                                        ;HEAD
   mov dl,00                                        ;FIRST FLOPPY DISK 
   int 13h                                          ;CALL INTERRUPT 13H[BIOS DISK] 
                                                                                
                                                                                
   ; Extract one byte from MFAT16_toatl_file_count for calculating MFAT1 16 size    
   CLD
   lea si,MFAT16_total_file_count
   lea di,MFAT16_size
   mov cx,1
   rep movsb


;******************************** Get MFAT 16 Size **********************************
 
;******************************** Check Filename **********************************


FindNextMatchingFile:

mov bx,MFAT16_incrementer


CLD
lea si,MFAT16_buffer + bx
lea di,MFAT16_filename
mov cx,10
rep movsb                 



lea bp,MFAT16_filename                            ; Load File_bufefr into si register pro printing on the screen through Video BIOS

mov cx,0                                                 
next_char:      
mov     al, [bp]                                  ; Terminate reading if end of file character is found
cmp     cx,10 
je      printed
inc     bp
mov     ah, 0eh                                   ; teletype function.
int     10h  
inc     cx
jmp     next_char


printed:

jmp     not_equal

;******************************** Check Filename **********************************

            
;********************************************************************************************


;//////////////////////////Display the file list/////////////////////

           
        
                 
;//////////////////////////Display the file list/////////////////////

;********************************************************************************************

not_equal:   ; If the file is not found then     


add MFAT16_incrementer,10h                       ; Increment by 16 


CLD                                              ; Empty MFAT16_filename for reusage
lea si,MFAT16_empty_filename
lea di,MFAT16_filename           
mov cx,10                                        ; Move 10 blank bytes into MFAT16_filename
rep movsb                 


mov ax,MFAT16_incrementer                        ; Calculate the max file count
mov bl,16                                        ; Size of MFAT 16 single file entry
div bl                                           ; Calculate the number of files that have been processed


cmp al,18
je  Wait_for_a_key_press
jne Dont_wait_for_a_key_press
                          
                          
Wait_for_a_key_press:                            ; Wait for a key press before scrolling the screen
printf() ""
printf() ""
print() "Press ay key to continue....."
getch()                               
printf() ""                 
mov al,18
jmp Dont_wait_for_a_key_press                          
                          
Dont_wait_for_a_key_press:
                        
cmp al,MFAT16_size                               ; Stop when MFAT 16 filesystem max file count is reached
je  end_file_not_found                             

printf() ""
      
jmp FindNextMatchingFile                         ; Continue searching for the file in the MFAT 16 filesystem
;******************************** Check Filename **********************************
 

;////////////////////////////MFAT 16/////////////////////////////////////////////////////////////////////////////

                      
end_file_not_found:
                      
endme:

printf() ""
printf() ""
print() "Total number of files = "              ; Display the total number of files presenet in the MFAT 16 file system    
mov al,MFAT16_size
mov ah,00h
call PRINT_NUM                     

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
hlt
                    
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
