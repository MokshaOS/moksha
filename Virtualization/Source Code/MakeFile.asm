;////////////////////////////////////////////////////Makes A File////////////////////////////////////////////////////////////////////        


include mvideo.inc 
org 100h
;#make_bin#

;#LOAD_SEGMENT=2401h#                                                                                                             
;#LOAD_OFFSET=0000h#


;#CS=2401h#	                                                   
;#IP=0000h#
;#DS=2401h#
;#SS=2401h#
;#SP=0FFFEh#
	  

jmp start                               ; Jump to the start label
                                       
cmd_size           equ 513              ; size of Make File buffer 
command_buffer     db cmd_size dup(090h)
prompt             db "             Make File ( Moksha Operating System File Making Utility )", 0
f_size             equ 11
filename           db f_size dup (' ')  ; Gets the filename from the user
sval               db 16     dup (090h)    ; Appends the location of the file with end of file delimeter ( 090h )
v1                 db 5      dup (' ')  ; Stores the head , track and sector informtion of the file for appending to MFAT16_buffer   
rud                db 512    dup (' ')  ; Gets rid of unuseful data and makes it a pure 16 byte entry  
count_file         db 512    dup (' ')  ; Gets the total file count from the file system
real_count_file    db 512    dup (' ')  ; Updates the file count of the current track used for writing the sector in the file system
testme             db 00h               ; Test variable for setting the initial file count information
track_for_saving   db 6                 ; Initial track for saving the files = 6 
total_file_count   db 512    dup (' ')  ; Gets and sets the total file count ( of all the used tracks ) in the file system
total_update_file  db 512    dup (' ')  ; Updates the total file count in the file system 
MFAT16_buffer      db 512    dup (' ')  ; 16 byte Moksha File Allocation Table buffer for reading and writing informaton 
head               db 00h               ; Head for writing the file and MFAT 16 information ,starting head = 0
MFAT16_Size        db 1      dup (' ')  ; Calculates the size of MFAT 16 
Find_del_file      db 512    dup (' ')  ; Finds the deleted file                                  
Compare_del_file   db 512    dup (0F0H) ; Finds the deleted file                                  
del_head           db 1      dup (00h)  ; Deleted Head
del_track          db 1      dup (06h)  ; Deleted Track
del_sector         db 1      dup (01h)  ; Deleted Sector
del_file_counter   db 1      dup (00h)  ; Counts the number of file processed
MaxFile_count      db 512    dup (' ')  ; Gets the total number of file for checking the maximum file count
MaxFile_net_count  db 512    dup (' ')  ; Calculates the total number of files for checking the maximum file count   
MFAT16_Read_buffer             db    512      dup (' ')   ; 16 byte MFAT buffer for reading and writing information 
MFAT16_Read_total_file_count   db    512      dup (' ')   ; Gets and sets the total file count in the file system
MFAT16_Read_size               db    1        dup (' ')   ; Calculates the size of MFAT 16 filesystem
MFAT16_Read_filename           db    10       dup (' ')   ; The filename present in the MFAT 16 filesyatem
MFAT16_Read_incrementer        dw    1        dup (00h)   ; Increment MFAT 16 filesystem by 16 each time
MFAT16_Read_empty_filename     db    10       dup (' ')   ; Flushes the MFAT16_filename each time for finding the next file


start:                                  ; Start from this label



; Set data segment equal to the value of code segment
;push cs
;pop ds     

; Set stack segment equal to the value of code segment   
;mov ax,2401h
;mov ss,ax
;mov sp,0fffeh  

setvmode()
clrscr()


;//////////////////////////////////////////////////////File contents//////////////////////////////////////////////////////

          
; Input from the user for the purpose of getting the file contents
get_command proc near

; shows prompt
;lea     si, prompt 
;call    print_string
cprintf() "Make File ( Moksha Operating System File Making Utility )",59,12,1,012

printf() ""                           ; Insert a blank line  
printf() "--------------------------------------------------------------------------------"

printf() "Note - Press F2 key for saving the file.Enter your file data below."
printf() ""         

; wait for a command:
mov     dx, cmd_size                  ; buffer size.
lea     di, command_buffer
call    get_string


ret
get_command endp
; Input from the user for the purpose of getting the file contents



get_string      proc    near
push    ax
push    cx
push    di
push    dx

mov     cx, 0                        ; char counter.
                                
cmp     dx, 1                        ; buffer too small?
jbe     empty_buffer            

dec     dx                           ; reserve space for last zero.


;============================
; eternal loop to get
; and processes key presses:

wait_for_key:

mov     ah, 0                   ; get pressed key.
int     16h


cmp al,0dh 
je enterkey
jne notpressed

enterkey:
mov ah,0eh
mov al,0ah
int 10h

mov ah,0eh
mov al,0dh
int 10h

notpressed:
                                 
cmp     ah, 03Ch              ; F2 pressed?
jz      exit


cmp     al, 8                   ; 'backspace' pressed?
jne     add_to_buffer
jcxz    wait_for_key            ; nothing to remove!
dec     cx
dec     di
putc()    8                       ; backspace.
putc()    ' '                     ; clear position.
putc()    8                       ; backspace again.
jmp     wait_for_key

add_to_buffer:

        cmp     cx, dx          ; buffer is full?
        jae     wait_for_key    ; if so wait for 'backspace' or 'return'...

        mov     [di], al
        inc     di
        inc     cx
        
        ; print the key:
        mov     ah, 0eh
        int     10h

jmp     wait_for_key
;============================

exit:

; terminate by null:
;mov     [di], 0         

;*************************************Gets and calculates the maxmimum file count***************

  mov ah,02h               ;READ
   mov al,01               ;SECTORS TO READ
   lea bx,MaxFile_count    ;CODE SEGMENT
   mov ch,01               ;TRACK/CYLINDER
   mov cl,02               ;SECTOR
   mov dh,00               ;HEAD
   mov dl,00               ;FIRST FLOPPY DISK 
   int 13h                 ;CALL INTERRUPT 13H[BIOS DISK] 
   
 ; Extract the first byte from the array of 512 bytes
   CLD
   lea si,MaxFile_count    ; Source Array
  lea di,MaxFile_net_count; Destination Array
   mov cx,1                ; No. Of Bytes To Exchange , Here No Of Bytes To Exchange = 1 Byte
   rep movsb               ; Move the first byte from total_file_count array to total_update_file array
    
   cmp MaxFile_net_count,20h
   je  MaxFileCountReached 
;*************************************Gets and calculates the maxmimum file count***************


;////////////////////////////////////////////Get No of Files Already Present In The File System//////////////////////////////

;*******************************************************************************************                        
  mov ah,02h               ;READ
   mov al,01               ;SECTORS TO READ
   lea bx,count_file       ;CODE SEGMENT
   mov ch,01               ;TRACK/CYLINDER
   mov cl,01               ;SECTOR
   mov dh,00               ;HEAD
   mov dl,00               ;FIRST FLOPPY DISK 
   int 13h                 ;CALL INTERRUPT 13H[BIOS DISK] 
      

  ; Extract the first byte from the array of 512 bytes
   CLD
   lea si,count_file       ; Source Array
   lea di,real_count_file  ; Destination Array
   mov cx,1                ; No. Of Bytes To Exchange , Here No Of Bytes To Exchange = 1 Byte
   rep movsb               ; Move the first byte from count_file array to real_count_file array
    
  inc real_count_file ; Increment the file count by 1 i.e. File Count = File Count + 1
 
 cmp real_count_file,13h ; If no. 19th is encountered then increment the track by one
 je  IncrementTrack      ; Jump to IncrementTrack label
 jne ContinueSameTrack   ; Else jump to ContinueSameTrack label
 
 IncrementTrack:
 inc track_for_saving   ; Increment the track by 1          
 sub real_count_file,18 ; Set the starting sector for the incremented track to 1
 
 ContinueSameTrack:
  
; Updates current track total no. of files information
 mov ah,03h       ;Write 
   mov al,01      ;SECTORS TO Write
   lea bx,real_count_file  ;CODE SEGMENT
   mov ch,01      ;TRACK/CYLINDER
   mov cl,01      ;SECTOR
   mov dh,00      ;HEAD
   mov dl,00      ;FIRST FLOPPY DISK 
  int 13h        ;CALL INTERRUPT 13H[BIOS DISK]

;*******************************************************************************************                        
   
;************************************* Gets and sets the total file count***************

  mov ah,02h      ;READ
   mov al,01      ;SECTORS TO READ
   lea bx,total_file_count  ;CODE SEGMENT
   mov ch,01      ;TRACK/CYLINDER
   mov cl,02      ;SECTOR
   mov dh,00      ;HEAD
   mov dl,00      ;FIRST FLOPPY DISK 
   int 13h        ;CALL INTERRUPT 13H[BIOS DISK] 
   
 ; Extract the first byte from the array of 512 bytes
   CLD
   lea si,total_file_count ; Source Array
   lea di,total_update_file; Destination Array
   mov cx,1                ; No. Of Bytes To Exchange , Here No Of Bytes To Exchange = 1 Byte
   rep movsb               ; Move the first byte from total_file_count array to total_update_file array
    
 inc total_update_file     ; Increment the total file count by 1          
 
; Updates total no. of files information
 mov ah,03h       ;Write 
   mov al,01      ;SECTORS TO READ
   lea bx,total_update_file ;CODE SEGMENT
   mov ch,01      ;TRACK/CYLINDER
   mov cl,02      ;SECTOR
   mov dh,00      ;HEAD
   mov dl,00      ;FIRST FLOPPY DISK 
   int 13h        ;CALL INTERRUPT 13H[BIOS DISK]
   
;************************************* Gets and sets the total file count***************
                      
;////////////////////////////////////////////Get No of Files Already Present In The File System//////////////////////////////


;//////////////////////////////////Find Deleted Space And Set Head,Track And Sector For File Writing ////////////////////////////////

  read_deleted_files:
  
   mov ah,02h                 ;READ
   mov al,01                  ;SECTORS TO READ
   lea bx,Find_del_file       ;CODE SEGMENT
   mov ch,del_track           ;TRACK/CYLINDER
   mov cl,del_sector          ;SECTOR
   mov dh,del_head            ;HEAD
   mov dl,00                  ;FIRST FLOPPY DISK 
   int 13h                    ;CALL INTERRUPT 13H[BIOS DISK] 
 
  ; set forward direction:
        cld     

; load source into ds:si,
; load target into es:di:
        mov     ax, cs
        mov     ds, ax
        mov     es, ax
        lea     si, Find_del_file
        lea     di, Compare_del_file

; set counter to string length:
        mov     cx, 512

; compare until equal:
        repe    cmpsb
        ;jnz     read_deleted_files
        jz      deleted_file_found
   
  inc del_sector
  cmp del_sector,18
  je increment_del_track
  jne read_deleted_files
  
  increment_del_track:
  inc del_track
  mov del_sector,01h
   

  inc del_file_counter                    ; Increment the delete file counter
  mov al,total_update_file
  cmp del_file_counter,al
  je  deleted_file_not_found
  
  jmp read_deleted_files          
  
  deleted_file_found: 
  
  mov al,del_track
  mov track_for_saving,al
  mov al,del_sector
  mov real_count_file,al
  
  deleted_file_not_found:
    

;//////////////////////////////////Find Deleted Space And Set Head,Track And Sector For File Writing ////////////////////////////////


 mov ah,03h       ;Write
   mov al,01      ;SECTORS TO Write
   lea bx,command_buffer  ;CODE SEGMENT
   mov ch,track_for_saving      ;TRACK/CYLINDER
   mov cl,real_count_file      ;SECTOR
   mov dh,00      ;HEAD
   mov dl,00      ;FIRST FLOPPY DISK 
   int 13h        ;CALL INTERRUPT 13H[BIOS DISK]
   
call file_command




empty_buffer:

pop     dx
pop     di
pop     cx
pop     ax
ret
get_string      endp




; print a null terminated string at current cursor position, 
; string address: ds:si
print_string proc near
push    ax                              ; store registers...
push    si      

next_char:      
        mov     al, [si]
        cmp     al, 0
        jz      printed
        inc     si
        mov     ah, 0eh                 ; teletype function.
        int     10h
        jmp     next_char
printed:

pop     si                              ; re-store registers...
pop     ax      

ret
print_string endp

;//////////////////////////////////////////////////////File contents//////////////////////////////////////////////////////




;//////////////////////////////////////////////////////////////////Filename//////////////////////////////////////////////////////

; Input from the user for the purpose of getting the filename

file_command proc near

NewFileName:                     ; Come here if the given filename already exists

printf() ""           
printf() ""
print() "Enter the filename - "

; wait for a command:
mov     dx, f_size                     ; buffer size.
lea     di, filename
call    get_filename


ret
file_command endp


get_filename      proc    near
push    ax
push    cx
push    di
push    dx

mov     cx, 0                          ; char counter.

cmp     dx, 1                          ; buffer too small?
jbe     empty_buffer1                

dec     dx                             ; reserve space for last zero.


;============================
; eternal loop to get
; and processes key presses:

wait_for_key1:

mov     ah, 0                          ; get pressed key.
int     16h

                                  
cmp     al, 0dh                        ; F2 pressed?
jz      exit1


cmp     al, 8                          ; 'backspace' pressed?
jne     add_to_buffer1
jcxz    wait_for_key1                  ; nothing to remove!
dec     cx
dec     di
putc()    8                            ; backspace.
putc()    ' '                          ; clear position.
putc()    8                            ; backspace again.
jmp     wait_for_key1

add_to_buffer1:

        cmp     cx, dx                 ; buffer is full?
        jae     wait_for_key1          ; if so wait for 'backspace' or 'return'...

        mov     [di], al
        inc     di
        inc     cx
        
        ; print the key:
        mov     ah, 0eh
        int     10h

jmp     wait_for_key1
;============================

exit1:


;******************************** Read MFAT 16 **********************************
 mov ah,02h                                         ;READ
   mov al,01                                        ;SECTORS TO READ
   lea bx,MFAT16_Read_buffer                        ;CODE SEGMENT
   mov ch,01                                        ;TRACK/CYLINDER
   mov cl,03                                        ;SECTOR
   mov dh,00                                        ;HEAD
   mov dl,00                                        ;FIRST FLOPPY DISK 
   int 13h                                          ;CALL INTERRUPT 13H[BIOS DISK]        

;******************************** Read MFAT 16 **********************************
   
;******************************** Get MFAT 16 Size ******************************
  mov ah,02h                                        ;READ
   mov al,01                                        ;SECTORS TO READ
   lea bx,MFAT16_Read_total_file_count              ;CODE SEGMENT
   mov ch,01                                        ;TRACK/CYLINDER
   mov cl,02                                        ;SECTOR
   mov dh,00                                        ;HEAD
   mov dl,00                                        ;FIRST FLOPPY DISK 
   int 13h                                          ;CALL INTERRUPT 13H[BIOS DISK] 
                                                                                
                                                                                
   ; Extract one byte from MFAT16_toatl_file_count for calculating MFAT1 16 size    
   CLD
   lea si,MFAT16_Read_total_file_count
   lea di,MFAT16_Read_size
   mov cx,1
   rep movsb



FindNextMatchingFile:

mov bx,MFAT16_Read_incrementer

CLD
lea si,MFAT16_Read_buffer + bx
lea di,MFAT16_Read_filename
mov cx,10
rep movsb                 


; set forward direction:
        cld     

; load source into ds:si,
; load target into es:di: 
        push ds
        push es

        mov     ax, cs
        mov     ds, ax
        mov     es, ax
        lea     si, filename
        lea     di, MFAT16_Read_filename
        
        pop ds
        pop es
; set counter to string length:
        mov     cx, 10

; compare until equal:
        repe    cmpsb
        jnz     not_equal

printf() ""
printf() "File with this name already exists.Please choose a different filename."

CLD                                              ; Empty filename for reusage
lea si,MFAT16_Read_empty_filename
lea di,filename           
mov cx,10                                        ; Move 10 blank bytes into MFAT16_filename
rep movsb     

;pop     dx
;pop     di
;pop     cx                                                 
;pop     ax  
            

;call file_command

pop    ax
pop    cx
pop    di
pop    dx

jmp NewFileName 
 
not_equal:   ; If the file is not found then     

add MFAT16_Read_incrementer,10h                       ; Increment by 16 


CLD                                              ; Empty MFAT16_filename for reusage
lea si,MFAT16_Read_empty_filename
lea di,MFAT16_Read_filename           
mov cx,10                                        ; Move 10 blank bytes into MFAT16_filename
rep movsb                 


mov ax,MFAT16_Read_incrementer                        ; Calculate the max file count
mov bl,16                                        ; Size of MFAT 16 single file entry
div bl                                           ; Calculate the number of files that have been processed

      
cmp al,MFAT16_Read_size                          ; Stop when MFAT 16 filesystem max file count is reached
je  end_file_not_found                             
      
jmp FindNextMatchingFile                         ; Continue searching for the file in the MFAT 16 filesystem

end_file_not_found:   
;******************************** Get MFAT 16 Size **********************************

;///////////////////////////////////////////Chech if the file already exists or not ? //////////////////////////////////////////////

;///////////////////////////////////////////Chech if the file already exists or not ? //////////////////////////////////////////////

; terminate by null:
;mov     [di], 0

CLD
lea si,filename
lea di,sval
mov cx,10
rep movsb

; Storing the file head,track and sector informatioon

CLD                                      ; Stores the head information
lea si,head
lea di,v1
mov cx,1
rep movsb

CLD
lea si,track_for_saving                  ; Stores the track information
lea di,v1+1
mov cx,1
rep movsb

CLD
lea si,real_count_file                   ; Stores the sector information
lea di,v1+2
mov cx,1
rep movsb

; Storing the file head,track and sector information


CLD
lea si,v1
lea di,sval+10
mov cx,5
rep movsb

CLD
lea si,sval
lea di,rud
mov cx,16
rep movsb


;********************* Read And Write the contents of the MFAT 16 ( 16 Byte Moksha File Allocation Table )********************

;  MFAT 16 starts from Track No. = 1 and Sector No. = 3 

 mov ah,02h                               ;READ
   mov al,01                              ;SECTORS TO READ
   lea bx,MFAT16_buffer                   ;CODE SEGMENT
   mov ch,01                              ;TRACK/CYLINDER
   mov cl,03                              ;SECTOR
   mov dh,00                              ;HEAD
   mov dl,00                              ;FIRST FLOPPY DISK 
   int 13h                                ;CALL INTERRUPT 13H[BIOS DISK] 

   cmp total_file_count,00h               ; Check if the total file count is zero
   je  FirstFileEntry
   jne NotFirstFileEntry
   
   FirstFileEntry:                        ; If the total file count is greater than one
   CLD
   lea si,rud                             ; Source Array
   lea di,MFAT16_buffer                   ; Destination Array
   mov cx,16                              ; No. Of Bytes To Exchange , Here No Of Bytes To Exchange = 1 Byte
   rep movsb                              ; Move the first byte from count_file array to real_count_file array
   jmp ContineFileEntry
   
   NotFirstFileEntry:   
   
   ;****** Calculate the MFAT 16 Size ******  
     
   CLD
   lea si,total_update_file               ; Source Array
   lea di,MFAT16_size                     ; Destination Array
   mov cx,1                               ; No. Of Bytes To Exchange , Here No Of Bytes To Exchange = 1 Byte
   rep movsb                              ; Move the first byte from total_update_file array to MFAT16_size array

   sub MFAT16_size,1                      ; Subtract 1 from MFAT16_size = total_update_file - 1
   mov al,16
   mul MFAT16_size
   mov bx,ax                              ; Move the value of AX = MFAT16_size * 16 into BX register
   
   ;****** Calculate the MFAT 16 Size ******
   
   ; Append the information of the current file to the MFAT 16
   CLD
   lea si,rud                             ; Source Array
   lea di,MFAT16_buffer + bx              ; Destination Array
   mov cx,16                              ; No. Of Bytes To Exchange , Here No Of Bytes To Exchange = 1 Byte
   rep movsb                              ; Move the first byte from count_file array to real_count_file array
 
   ContineFileEntry:
 mov ah,03h                               ;Write
   mov al,01                              ;SECTORS TO Write
   lea bx,MFAT16_buffer                   ;CODE SEGMENT
   mov ch,01                              ;TRACK/CYLINDER
   mov cl,03                              ;SECTOR
   mov dh,00                              ;HEAD
   mov dl,00                              ;FIRST FLOPPY DISK 
   int 13h                                ;CALL INTERRUPT 13H[BIOS DISK]

;********************* Read And Write the contents of the MFAT 16 ( 16 Byte Moksha File Allocation Table )********************

   
empty_buffer1:

pop     dx
pop     di
pop     cx                                                 
pop     ax  

printf() ""
printf() "File written successfully."
printf() "Press any key to return to Moksha Command Interpreter."
getch() 
jmp ReturnToShell  
ret
get_filename      endp

; Input from the user for the purpose of getting the filename

MaxFileCountReached:
printf() ""
printf() "The maxmimum file limit has been reached."
printf() "Please delete some files for creating new files."
printf() "Press any key to return to Moksha Command Interpreter."
getch() 

;//////////////////////////////////////////////////////////////////Filename//////////////////////////////////////////////////////


ReturnToShell: 
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
                                                 