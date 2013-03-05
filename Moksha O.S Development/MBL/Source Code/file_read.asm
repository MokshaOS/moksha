;ORG 100h           ; this directive required for a simple 1 segment .com program. 
;MOV AX, 0B800h     ; set AX to hexadecimal value of B800h. 
;MOV DS, AX         ; copy value of AX to DS. 
;MOV CL, 'A'        ; set CL to ASCII code of 'A', it is 41h. 
;MOV CH, 1101_1111b ; set CH to binary value. 
;MOV BX, 15Eh       ; set BX to 15Eh. 
;MOV [BX], CX       ; copy contents of CX to memory at B800:015E 
;RET     

include emu8086.inc
include mvideo.inc
#make_bin#


buffer db 512 dup(' ') ;TO MAKE 512 BYTE OF EMPTY/UNVALUED ARRAY     
;SET DATA SEGMENT:
xor     ax, ax  ;FLUSHING VALUE OF REGISTER AX
mov     ds, ax  ;MOVING VALUE OF REGISTER AX TO DS
  
;SET DEFAULT VIDEO MODE 80x25:
mov     ah, 00h ;VIDEO BIOS
mov     al, 03h ;GRAPHICS MODE,RESOLUTION 720X400 PIXELS
int     10h     ;CALL INTERRUPT 10H VIDEO BIOS  
 




;WAIT FOR A KEY
mov ah,00h      ;MOVING 0 TO REGISTER AH
int 16h         ;CALLING INTERRUPT 16H
   
  
    
        
   mov ah,02h     ;READ
   mov al,01      ;SECTORS TO READ
   lea bx,buffer  ;CODE SEGMENT
   mov ch,00      ;TRACK/CYLINDER
   mov cl,01      ;SECTOR
   mov dh,00      ;HEAD
   mov dl,00      ;FIRST FLOPPY DISK 
   int 13h        ;CALL INTERRUPT 13H[BIOS DISK]
   call print
   

print:    

;--------------------------------------------
;--------------PRINTING DATA----------------- 
;--------------------------------------------
  ; mov ah,13h           ;REQUEST TO PRINT STRING
  ; mov al,01h           ;SET WRITE MODE TO 1
  ; mov bh,00h           ;PAGE NO. 0
  ; mov bl,17h           ;0001 FOR BACKGROUND 0111 FOR FOREGROUND
  ; mov cx,512           ;NUMBER OF CHARACTER TO PRINT
  ; mov dx,0100h         ;DL=COLUMN(X CO-ORDINATE),DH=ROW(Y CO-ORDINATE)
  ; push cs              ;PUSHING CS INTO STACK
  ; pop es               ;POPING OUT ES FROM STACK
  ; mov bp,offset buffer ;MOVING ADDRESS OF BUFFER INTO BP
  ; int 10h              ;CALLING INTERRUPT 10H

;--------------------------------------------
;-----------PRINTING DATA OVER--------------- 
;--------------------------------------------    
          
   lea bp,buffer
   jmp cmpr      
            


          
                                               
          
;--------------------------------------------
;--------------COMPARE DATA------------------ 
;--------------------------------------------                                                  
cmpr:
   mov dh,010h ;DH=ROW(Y CO-ORDINATE)
   mov bh,00h  ;DL=COLUMN(X CO-ORDINATE)
   mov ah,2    ;REQUEST TO MOVE CURSOR
   int 10h     ;CALLING INTERRUPT 10H         
;-------------------------       
          
   xor al,al
          
  mov al,[bp]   
   mov bl,0F0h
   mov cx,1
   mov ah,09h
   int 10h 
   inc bp 
   inc dl        
   cmp b.[bp],90h
   je exit
   cmp dx,00h
   je exit
          
   call cmpr   
          
          
;-------------------------
             
;--------------------------------------------
;----------COMPARE DATA OVER----------------- 
;--------------------------------------------          
    exit:             
       
          mov ah,0
          int 16h
          hlt             