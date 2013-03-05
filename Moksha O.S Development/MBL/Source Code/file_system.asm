;ORG 100h           ; this directive required for a simple 1 segment .com program. 
;MOV AX, 0B800h     ; set AX to hexadecimal value of B800h. 
;MOV DS, AX         ; copy value of AX to DS. 
;MOV CL, 'A'        ; set CL to ASCII code of 'A', it is 41h. 
;MOV CH, 1101_1111b ; set CH to binary value. 
;MOV BX, 15Eh       ; set BX to 15Eh. 
;MOV [BX], CX       ; copy contents of CX to memory at B800:015E 
;RET     

include emu8086.inc
#make_bin#

;org 7c00h      ; set location counter.

buffer db 512 dup(' ') 
; set data segment:
xor     ax, ax
mov     ds, ax
  
; set default video mode 80x25:
mov     ah, 00h ;VIDEO BIOS
mov     al, 03h ;GRAPHICS MODE,RESOLUTION 720X400 PIXELS
int     10h     ;CALL INTERRUPT 10H VIDEO BIOS  
 


;gotoxy 20,1
;printn "MOKSHA OPERATING ~~~~ SYSTEM BOOT LOADER"
;gotoxy 20,2
;printn "==================================="
;printn ""
;printn " Developed by Hemendra Singh & Surya Raj of S.R.C.E.M.,C.S.E,Gwalior,M.P.,INDIA" 
;gotoxy 20,12
;printn "Press any key to continue..."
;gotoxy 3,22
;printn "ALL RIGHTS RESERVED BY HEMENDRA SINGH & SURYA RAJ.COPYRIGHT @ DECEMBER 2008"


;WAIT FOR A KEY
mov ah,0h
int 16h
   
  
    ;mov ah, 03h  ; write command
    ;mov al, 01 ; write 1 sector (512 bytes).
    ;mov cl, 01  ; sector (1..18)
    ;mov ch, 0  ; cylinder (0..79)
    ;mov dh, 0  ; head  (0..1)  
    ;mov dl, 0 ; always 0 (A:)
    ;mov bx, offset buffer
    ;int 13h

;run() macro head,track,start_sector,nsectors,code_segment
;mov ah,02h          ;READ
;mov al,01;nsectors     ;SECTORS TO READ
;mov ch,0;track        ;TRACK/CYLINDER
;mov cl,1;start_sector ;SECTOR
;mov dh,0;head         ;HEAD
;mov dl,0            ;FIRST FLOPPY DISK 
;mov bx,0201h ;code_segment ;CODE SEGMENT
;mov es,bx           ;SET EXTRA SEGMENT REGISTER
;mov w.buffer,bx   
;int 13h             ;CALL INTERRUPT 13H[BIOS DISK]  

        ;mov ah,02h       ; request read
        ;mov al,01        ; number of sector
        ;lea bx,offset[buffer]  ; address of buffer
        ;mov cx,0001  ; track/sector
        ;mov cl,03
        ;mov dh,00;side      ; side   
        ;mov dl,00        ; drive a:
        ;int 13h                    
        ;jnc C90          ; if normal read , exit
        ;mov endcode,01    ; else
        ;lea bp,readmsg   ; display erorr
        ;mov cx,18        ; message 
        
   mov ah,02h          ;READ
   mov al,01     ;SECTORS TO READ
   lea bx,buffer ;CODE SEGMENT
   mov ch,00        ;TRACK/CYLINDER
   mov cl,01 ;SECTOR
   mov dh,00         ;HEAD
   mov dl,00            ;FIRST FLOPPY DISK 
   
  ;mov es,bx           ;SET EXTRA SEGMENT REGISTER
  ;mov bx,0                                                                                   
   int 13h             ;CALL INTERRUPT 13H[BIOS DISK]
   mov cx,18     
        
   call print
hlt

print:
          mov ah,13h
          mov al,01h
          mov bh,00h
          mov bl,17h
          mov cx,512
          ;mov cx,offset sectorin
          mov dx,0100h
          ;mov es,cx
          push cs
          pop es
          mov bp,offset [buffer]
          int 10h    
          
          mov dx,1010h
          mov bh,00h
          mov ah,2
          int 10h
          mov ax,offset[buffer] 
          cmp al,'b' 
          je label1 
         
          print 'al is not equal to q'
          jmp exit
          ;mov ah,09h
          ;mov bh,00h
          ;mov bl,018h
          ;mov cx,01h 
          ;int 10h
          label1:
          print 'al is containing q' 
          exit:
          ret
          mov ah,0
          int 16h
          ret

;iret  

;buffer  db "this is os first file read operation",0 