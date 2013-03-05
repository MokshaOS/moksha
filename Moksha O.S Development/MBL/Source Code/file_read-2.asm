;ORG 100h           ; this directive required for a simple 1 segment .com program. 
;MOV AX, 0B800h     ; set AX to hexadecimal value of B800h. 
;MOV DS, AX         ; copy value of AX to DS. 
;MOV CL, 'A'        ; set CL to ASCII code of 'A', it is 41h. 
;MOV CH, 1101_1111b ; set CH to binary value. 
;MOV BX, 15Eh       ; set BX to 15Eh. 
;MOV [BX], CX       ; copy contents of CX to memory at B800:015E 
;RET     

;include emu8086.inc
#make_bin#

filename db 8 dup(' ')
buffer db 512 dup(' ') ;TO MAKE 512 BYTE OF EMPTY/UNVALUED ARRAY
;SET DATA SEGMENT:
xor     ax, ax  ;FLUSHING VALUE OF REGISTER AX
mov     ds, ax  ;MOVING VALUE OF REGISTER AX TO DS
  
;SET DEFAULT VIDEO MODE 80x25:
mov     ah, 00h ;VIDEO BIOS
mov     al, 03h ;GRAPHICS MODE,RESOLUTION 720X400 PIXELS
int     10h     ;CALL INTERRUPT 10H VIDEO BIOS  
 
lea bp,filename
mov sp,offset [filename]+8
mov dl,00h
call start



start:
;WAIT FOR A KEY
mov ah,00h      ;MOVING 0 TO REGISTER AH
int 16h         ;CALLING INTERRUPT 16H

;ADVANCE CURSOR TO NEW POSITION
mov dh,00h ;DH=ROW(Y CO-ORDINATE)
mov bh,00h  ;BH FOR PAGE NO.
inc dl      ;DL=COLUMN(X CO-ORDINATE)
mov ah,2    ;REQUEST TO MOVE CURSOR
int 10h     ;CALLING INTERRUPT 10H  

;PRINT THE INPUT KEY ON SCREEN
mov [bp],al 
mov bl,0F0h
mov cx,1
mov ah,09h
int 10h 
inc [bp] 
cmp sp,bp
je go
call start   
  
    
go:        
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
   mov ah,13h           ;REQUEST TO PRINT STRING
   mov al,01h           ;SET WRITE MODE TO 1
   mov bh,00h           ;PAGE NO. 0
   mov bl,17h           ;0001 FOR BACKGROUND 0111 FOR FOREGROUND
   mov cx,512           ;NUMBER OF CHARACTER TO PRINT
   mov dx,0100h         ;DL=COLUMN(X CO-ORDINATE),DH=ROW(Y CO-ORDINATE)
   push cs              ;PUSHING CS INTO STACK
   pop es               ;POPING OUT ES FROM STACK
   mov bp,offset buffer ;MOVING ADDRESS OF BUFFER INTO BP
   int 10h              ;CALLING INTERRUPT 10H

;--------------------------------------------
;-----------PRINTING DATA OVER--------------- 
;--------------------------------------------    
          
   lea si,buffer
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
   ;call print_me       
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
          
   call cmpr   
   
;print_me     PROC

;next_char:
    ;mov dx,1000h ;DH=ROW(Y CO-ORDINATE)
   ; mov bh,00h  ;DL=COLUMN(X CO-ORDINATE)
    ;mov ah,2    ;REQUEST TO MOVE CURSOR
    ;int 10h     ;CALLING INTERRUPT 10H 
   
    ;CMP  b.[SI], 0    ; check for zero to stop
    ;JE   stop         ;

    ;MOV  AL, [SI]     ; next get ASCII char.

    ;MOV  AH, 0Eh      ; teletype function number.
    ;INT  10h          ; using interrupt to print a char in AL.
    ;inc dl
    ;ADD  SI, 1        ; advance index of string array.

    ;JMP  next_char    ; go back, and type another char.

;stop:
;RET                   ; return to caller.
;print_me     ENDP

          
          
;-------------------------
    
          
          
;--------------------------------------------
;----------COMPARE DATA OVER----------------- 
;--------------------------------------------          
    exit:             
          mov ah,0
          int 16h
          hlt
                     