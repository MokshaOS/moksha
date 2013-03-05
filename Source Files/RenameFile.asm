;/////////////////////////////////////////////////////////Rename File////////////////////////////////////////////////////////////////
                                                                            
include mvideo.inc                 

;org 100h
#make_bin#

;#LOAD_SEGMENT=0100h#
;#LOAD_OFFSET=0000h#


#CS=2401h#	
#IP=0000h#
#DS=2401h#
#SS=2401h#
#SP=0FFFEh#
	
                                                     ; Jump to the start label
jmp start:

cmd_size                  equ   11                   ; size of Read File buffer 
command_buffer            db    cmd_size dup (' ')   ; The filename entered by the user
Rename_buffer             db    cmd_size dup (' ')   ; The filename entered by the user
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
startup_value             db    512      dup(01h)  

start:

; Set data segment equal to the value of code segment
push cs
pop ds     

; Set stack segment equal to the value of code segment   
mov ax,2401h
mov ss,ax
mov sp,0fffeh  

setvmode()       ; Set the video BIOS initialization mode

clrscr()         ; Clear the screen on the video BIOS

cprintf() "Rename File ( Moksha Operating System File Renaming Utility )",61,9,1,012
printf() "" ; Insert a blank line  
printf() "--------------------------------------------------------------------------------"
print() "Enter the old filename - "               

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


;//////////////////////////Rename file/////////////////////

enter_rename_file_again:

printf() ""
print() "Enter the new filename - "
           
;Input from the user for the purpose of getting the file contents
get_command2 proc near

; wait for a command:
mov     dx, cmd_size                                 ; buffer size.
lea     di, rename_buffer
call    get_string2


ret
get_command2 endp
; Input from the user for the purpose of getting the file contents


; get characters from keyboard and write a null terminated string 
get_string2      proc    near
push    ax
push    cx
push    di
push    dx

mov     cx, 0                                        ; char counter.

cmp     dx, 1                                        ; buffer too small?
jbe     empty_buffer2            

dec     dx                                           ; reserve space for last zero.


;============================
; eternal loop to get
; and processes key presses:

wait_for_key2:

mov     ah, 0                                        ; get pressed key.
int     16h

cmp     al, 0Dh                                      ; 'return' pressed?
jz      exit2


cmp     al, 8                                        ; 'backspace' pressed?
jne     add_to_buffer2
jcxz    wait_for_key2                                 ; nothing to remove!
dec     cx
dec     di
putc()    8                                          ; backspace.
putc()    ' '                                        ; clear position.
putc()    8                                          ; backspace again.
jmp     wait_for_key2

add_to_buffer2:

        cmp     cx, dx                               ; buffer is full?
        jae     wait_for_key2                         ; if so wait for 'backspace' or 'return'...

        mov     [di], al
        inc     di
        inc     cx
        
        ; print the key:
        mov     ah, 0eh
        int     10h

jmp     wait_for_key2
;============================

exit2:

jmp rename_file

; terminate by null:
mov     [di], 0


empty_buffer2:

pop     dx
pop     di
pop     cx
pop     ax
ret
get_string2      endp


rename_file:


;////////////Check if the renamed file name pre exist on the MFAT 16 filesystem////////////////////////  

FindRenamedNextMatchingFile:

mov ax,00h
mov MFAT16_incrementer,ax    ; Put initial in MFAT16_incrementer for resetting to it's orgnal value for searching the filenam again

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
        lea     si, Rename_buffer
        lea     di, MFAT16_filename

; set counter to string length:
        mov     cx, 10

; compare until equal:
        repe    cmpsb
        jnz     renamedfile_not_equal


;******If the filename already exists then prompt for renetry of the rename filename**********

printf() ""
printf() "File with this name already exists.Please choose a different filename."

pop    ax
pop    cx
pop    di
pop    dx

jmp enter_rename_file_again
;******If the filename already exists then prompt for renetry of the rename filename**********

renamedfile_not_equal:   ; If the file is not found then     

pop    ax
pop    cx
pop    di
pop    dx


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
je  continue_renameing_process                             
      
jmp FindRenamedNextMatchingFile                         ; Continue searching for the file in the MFAT 16 filesystem

;////////////Check if the renamed file name pre exist on the MFAT 16 filesystem////////////////////////


;///////Renaming module////////////////////
continue_renameing_process:

mov bx,MFAT16_incrementer

CLD
lea si,Rename_buffer
lea di,MFAT16_buffer + bx
mov cx,10
rep movsb           

 mov ah,03h                               ;Write
   mov al,01                              ;SECTORS TO Write
   lea bx,MFAT16_buffer                   ;CODE SEGMENT
   mov ch,01                              ;TRACK/CYLINDER
   mov cl,03                              ;SECTOR
   mov dh,00                              ;HEAD
   mov dl,00                              ;FIRST FLOPPY DISK 
   int 13h                                ;CALL INTERRUPT 13H[BIOS DISK]


printf() ""
printf() ""
printf() "File renamed successfully"              
printf() "Press any key to return to Moksha Command Interpreter."
getch()
                 
;//////////////////////////Rename file/////////////////////

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
printf() "Press any key to return to Moksha Command Interpreter."
getch()
                      
endme:

pop     dx
pop     di
pop     cx                                                 
pop     ax  

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


hlt
