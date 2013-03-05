;/////////////////////////////////////////////////////////Gets The Size Of A File///////////////////////////////////////////////////////////////////
                                                                            
include mvideo.inc                 
include emu8086.inc

;org 100h
#make_bin#

;#LOAD_SEGMENT=7401h#
;#LOAD_OFFSET=0000h#


#CS=7401h#	
#IP=0000h#	
#DS=7401h#
#SS=7401h#
#SP=0FFFEh#
                                                     ; Jump to the start label
jmp start:

cmd_size                  equ   11                   ; size of Read File buffer 
command_buffer            db    cmd_size dup (' ')   ; The filename entered by the user
MFAT16_buffer             db    512      dup (' ')   ; 16 byte MFAT buffer for reading and writing information 
MFAT16_total_file_count   db    512      dup (' ')   ; Gets and sets the total file count in the file system
MFAT16_filename           db    10       dup (' ')   ; The filename present in the MFAT 16 filesyatem
MFAT16_head               db    1        dup (' ')   ; Gets filename head information from MFAT 16 filesystem
MFAT16_track              db    1        dup (' ')   ; Gets filename track information from MFAT 16 filesystem
MFAT16_sector             db    1        dup (' ')   ; Gets filename sector information from MFAT 16 filesystem
MFAT16_incrementer        dw    1        dup (00h)   ; Increment MFAT 16 filesystem by 16 each time
MFAT16_empty_filename     db    10       dup (' ')   ; Flushes the MFAT16_filename each time for finding the next file
File_buffer               db    512      dup (' ')   ; Reads the user file stored in the floppy disk
MFAT16_size               db    1        dup (' ')   ; Calculates the size of MFAT 16 filesystem
FSize_Accounting          dw    0

start:
setvmode()
clrscr()

; Set data segment equal to the value of code segment
push cs
pop ds     

; Set stack segment equal to the value of code segment   
mov ax,7401h
mov ss,ax 
mov sp,0fffeh                                     


cprintf() "File Size ( Moksha Operating System File Size Accounting Utility )",66,8,1,012
printf() "" ; Insert a blank line  
printf() "--------------------------------------------------------------------------------"
print() "Enter the filename - "               

;Input from the user for the purpose of getting the file contents
get_command proc near

; wait for a command:
mov     dx, cmd_size                                 ; buffer size.
lea     di, command_buffer
call    get_string


ret
get_command endp
; Input from the user for the purpose of getting the file contents

; get characters from keyboard and write a null terminated string 
get_string      proc    near
push    ax
push    cx
push    di
push    dx

mov     cx, 0                                        ; char counter.

cmp     dx, 1                                        ; buffer too small?
jbe     empty_buffer            

dec     dx                                           ; reserve space for last zero.


;============================
; eternal loop to get
; and processes key presses:

wait_for_key:

mov     ah, 0                                        ; get pressed key.
int     16h

cmp     al, 0Dh                                      ; 'return' pressed?
jz      exit


cmp     al, 8                                        ; 'backspace' pressed?
jne     add_to_buffer
jcxz    wait_for_key                                 ; nothing to remove!
dec     cx
dec     di
putc()    8                                          ; backspace.
putc()    ' '                                        ; clear position.
putc()    8                                          ; backspace again.
jmp     wait_for_key

add_to_buffer:

        cmp     cx, dx                               ; buffer is full?
        jae     wait_for_key                         ; if so wait for 'backspace' or 'return'...

        mov     [di], al
        inc     di
        inc     cx
        
        ; print the key:
        mov     ah, 0eh
        int     10h

jmp     wait_for_key
;============================

exit:

jmp chkfilename

; terminate by null:
mov     [di], 0

empty_buffer:

pop     dx
pop     di
pop     cx
pop     ax
ret
get_string      endp


chkfilename:

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

printf() ""         
gotoxy() 0,6
printf() "Current Action - Searching for file..."            


FindNextMatchingFile:

mov bx,MFAT16_incrementer

CLD
lea si,MFAT16_buffer + bx
lea di,MFAT16_filename
mov cx,10
rep movsb                 


; set forward direction:
        cld     

; load source into ds:si,
; load target into es:di:
        mov     ax, cs
        mov     ds, ax
        mov     es, ax
        lea     si, command_buffer
        lea     di, MFAT16_filename

; set counter to string length:
        mov     cx, 10

; compare until equal:
        repe    cmpsb
        jnz     not_equal


printf() ""
gotoxy() 0,8
printf() "Action Result  - File found"  

;********************************************************************************************
;//////////Get File Head,Track And Sector information///////////////////////////

; Get Head Information
mov bx,MFAT16_incrementer
add bx,0AH                                          ; Increment By 10

CLD
lea si,MFAT16_buffer + bx
lea di,MFAT16_head
mov cx,1
rep movsb


; Get Track Information
mov bx,MFAT16_incrementer
add bx,0BH                                          ; Increment By 11

CLD
lea si,MFAT16_buffer + bx
lea di,MFAT16_track
mov cx,1
rep movsb        


; Get Sector Information
mov bx,MFAT16_incrementer
add bx,0CH                                          ; Increment By 12

CLD
lea si,MFAT16_buffer + bx
lea di,MFAT16_sector
mov cx,1
rep movsb        
                                  
;//////////Get File Head,Track And Sector information/////////////////////////// 


;///////////////////////////Read File/////////////////////////////////////////// 

mov ah,02h                                          ;READ
   mov al,01                                        ;SECTORS TO READ
   lea bx,File_buffer                               ;CODE SEGMENT
   mov ch,MFAT16_track                              ;TRACK/CYLINDER
   mov cl,MFAT16_sector                             ;SECTOR
   mov dh,MFAT16_head                               ;HEAD
   mov dl,00                                        ;FIRST FLOPPY DISK 
   int 13h                                          ;CALL INTERRUPT 13H[BIOS DISK] 

;///////////////////////////Read File/////////////////////////////////////////// 


;//////////////////////////Display the contents of the file/////////////////////
         
lea si,File_buffer                                ; Load File_bufefr into si register pro printing on the screen through Video BIOS

                                               
next_char:      
mov     al, [si]                                  ; Terminate reading if end of file character is found
cmp     al, 90h
jz      printed
        
cmp     al,0dh                                    ; If Carriage return is found , then goto LineFeed label
je      LineFeed

inc FSize_Accounting                              ; Calculate the file size without Line Feed
        
continue:
        
inc     si
;mov     ah, 0eh                                   ; teletype function.
;int     10h
jmp     next_char
        
LineFeed:
;mov     ah, 0eh                                   ; teletype function.
;mov     al, 0ah 
;int     10h                  
        
;mov     ah, 0eh                                   ; teletype function.
;mov     al, 0dh 
;int     10h                  

inc FSize_Accounting                               ; Calculate the file size with Line Feed
jmp continue
        
printed:
           
        
                 
;//////////////////////////Display the contents of the file/////////////////////

;********************************************************************************************
            
jmp endme    ; After the file has been found and displayed , then end the program

not_equal:   ; If the file is not found then     
printf() ""         
gotoxy() 0,6
printf() "Current Action - Searching for file..."            


add MFAT16_incrementer,10h                       ; Increment by 16 


CLD                                              ; Empty MFAT16_filename for reusage
lea si,MFAT16_empty_filename
lea di,MFAT16_filename           
mov cx,10                                        ; Move 10 blank bytes into MFAT16_filename
rep movsb                 


mov ax,MFAT16_incrementer                        ; Calculate the max file count
mov bl,16                                        ; Size of MFAT 16 single file entry
div bl                                           ; Calculate the number of files that have been processed

      
cmp al,MFAT16_size                               ; Stop when MFAT 16 filesystem max file count is reached
je  end_file_not_found                             
      
jmp FindNextMatchingFile                         ; Continue searching for the file in the MFAT 16 filesystem
;******************************** Check Filename **********************************
 

;////////////////////////////MFAT 16/////////////////////////////////////////////////////////////////////////////
   
                      
end_file_not_found:
gotoxy() 0,8
printf() "Action Result  - File not found"              
getch() 
                      
endme:     
printf() ""
print() "File Size : "
mov ax,FSize_Accounting
call PRINT_NUM
print() ""          
print() " Bytes."
getch()

pop    ax
pop    cx
pop    di
pop    dx

; Return To MCI / Shell
popa
mov ah,02h        ;READ
mov al,6          ;SECTORS TO READ
mov ch,2          ;CYLINDER
mov cl,1          ;SECTOR
mov dh,0          ;HEAD
mov bx,0201h      ;READ FROM 256 Byte;
mov es,bx         ;SET EXTRA SEGMENT REGISTER
mov bx,0                                                             
int 13h
jmp 0201h:0000h    
  
hlt

DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS