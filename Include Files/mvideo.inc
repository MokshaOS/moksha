;|===============================================================================================================|
;|                                       MOKSHA VIDEO BIOS[INT 10H] SYSTEM CALLS                                 |
;|===============================================================================================================|
;|_______________________________________________________________________________________________________________|
;|                                      DEVELOPED FOR THE MOKSHA OPERATING SYSTEM                                | 
;|                                      -------------------------------------------                              |
;|                                                    BY                                                         |
;|                                        HEMENDRA SINGH AND SURYA RAJ                                           |
;|                                        S.R.C.E.M.,GWALIOR,M.P.,INDIA                                          |
;|_______________________________________________________________________________________________________________| 
;|_________________________________ALL RIGHTS ARE RESERVED BY THE DEVELOPERS_____________________________________|     

;-#1-----------------------MACRO TO HOLD THE SCREEN---------------------------------------------------------------

getch() macro ;START getch() MACRO 
mov ah,0      ;DIRECT KEYBOARD INPUT WITHOUT ECHO
int 16h       ;CALL INTERRUPT 16H[BIOS KEYBOARD]
endm          ;END getch() MACRO 

;--------------------------MACRO TO HOLD THE SCREEN---------------------------------------------------------------


;-#2-----------------------MACRO TO SET VIDEO MODE----------------------------------------------------------------

setvmode() macro  ;START setvmode() MACRO
mov ah,00h        ;FUNCTION FOR SETTING THE VIDEO BIOS MODE
mov al,3          ;SET MODE TO 25x80,16 colour palette,3 pages,graphics mode
int 10h           ;CAL INTERRUPT 10H[VIDEO BIOS] 
endm              ;END vmode() MACRO

;--------------------------MACRO TO SET VIDEO MODE----------------------------------------------------------------


;-#3-----------------------MACRO TO SET BACK COLOR----------------------------------------------------------------

setbkcolor() macro color_code
mov ax,0600h
mov bh,color_code
mov cx,0000h
mov dx,4979h
int 10h
endm

;--------------------------MACRO TO SET BACK COLOR----------------------------------------------------------------


;-#4-----------------------MACRO TO SET ACTIVE PAGE---------------------------------------------------------------

setpage() macro pageno
mov ah,05h
mov al,pageno
int 10h
endm

;--------------------------MACRO TO SET ACTIVE PAGE---------------------------------------------------------------


;-#5-----------------------MACRO TO SET CURSOR OFF----------------------------------------------------------------

nocursor() macro
mov ah,01h       
mov cx,1000h     ;CH[START SCAN LINE]:CL[END SCAN LINE] 
int 10h          ;EXECUTE INTERRUPT 10H[VIDEO BIOS] 
endm

;--------------------------MACRO TO SET CURSOR OFF----------------------------------------------------------------


;-#6-----------------------MACRO TO SET RECTANGLE CURSOR----------------------------------------------------------

rcursor() macro
mov ah,01h
mov ch,00h
mov cl,14h
int 10h
endm

;--------------------------MACRO TO SET RECTANGLE CURSOR----------------------------------------------------------

;-#7-----------------------MACRO TO CLEAR THE SCREEN--------------------------------------------------------------

clrscr() macro
mov ax,0600h   ;AH=06(SCROLL),AL=00(FULL SCREEN)
mov bh,07h     ;0=BLACK BAKGROUND,7=WHITE FOREGROUND   
mov cx,0000h   ;UPPER LEFT ROW:COLUMN 
mov dx,4979h   ;49TH ROW,79TH COLUMN 
int 10h        ;EXECUTE INTERRUPT 10H[VIDEO BIOS]
mov ah,02h     ;FUNCTION FOR SETTING THE CURSOR
mov bh,0       ;STARTING PAGE NUMBER
mov dh,0       ;STARTING ROW
mov dl,0       ;STARTING COLUMN
int 10h        ;EXECUTE INTERRUPT 10H[VIDEO BIOS]
endm

;--------------------------MACRO TO CLEAR THE SCREEN--------------------------------------------------------------

;-#8-----------------------MACRO TO PRINT A STRING ON THE SCREEN[WITH NEW LINE]-----------------------------------

printf()   macro  sdat
LOCAL   next_char, s_dcl, printed, skip_dcl

PUSH    AX      ; store registers...
PUSH    SI      ;
JMP     skip_dcl        ; skip declaration.
        s_dcl DB sdat, 13, 10, 0

skip_dcl:
        LEA     SI, s_dcl
        
next_char:      
        MOV     AL, CS:[SI]
        CMP     AL, 0
        JZ      printed
        INC     SI
        MOV     AH, 0Eh ; teletype function.
        INT     10h
        JMP     next_char
printed:

POP     SI      ; re-store registers...
POP     AX      ;
ENDM

;--------------------------MACRO TO PRINT A STRING ON THE SCREEN[WITH NEW LINE]-----------------------------------


;-#9-----------------------MACRO TO PRINT A STRING ON THE SCREEN[NO NEW LINE]-------------------------------------

print()   macro   sdat
LOCAL   next_char, s_dcl, printed, skip_dcl

PUSH    AX      ; store registers...
PUSH    SI      ;

JMP     skip_dcl        ; skip declaration.
        s_dcl DB sdat, 0

skip_dcl:
        LEA     SI, s_dcl
        
next_char:      
        MOV     AL, CS:[SI]
        CMP     AL, 0
        JZ      printed
        INC     SI
        MOV     AH, 0Eh ; teletype function.
        INT     10h
        JMP     next_char
printed:

POP     SI      ; re-store registers...
POP     AX      ;
ENDM
;--------------------------MACRO TO PRINT A STRING ON THE SCREEN[NO NEW LINE]-------------------------------------


;-#10----------------------GOTO (X,Y) CORDINATE ON THE VIDEO BIOS-------------------------------------------------
gotoxy()  macro   col, row
        PUSH    AX
        PUSH    BX
        PUSH    DX
        MOV     AH, 02h
        MOV     DH, row
        MOV     DL, col
        MOV     BH, 0
        INT     10h
        POP     DX
        POP     BX
        POP     AX
ENDM

;--------------------------GOTO (X,Y) CORDINATE ON THE VIDEO BIOS-------------------------------------------------


; this macro prints a char in al and advances
; the current cursor position:
putc()    macro   char
        push    ax
        mov     al, char
        mov     ah, 0eh
        int     10h     
        pop     ax
endm

;-#11----------------------DISPLAY COLORED CHARACTER ON VIDEO BIOS------------------------------------------------ 

cputc() macro character,forecolor     ;START cputc() MACRO
push    cx                            ;STORE CX 
mov     al, character                 ;LOAD THE ENTERED CHARACTER 
mov     bh, 0                         ;DEFAULT PAGE NUMBER  
mov     cx, 1                         ;DISPLAY ONCE
mov     bl,forecolor                  ;SET CHARACTER FORE COLOR
mov     ah, 09h                       ;LOAD INTERRUPT FUNCTION TO DISPLAY THE COLORED CHARACTER ON THE VIDEO BIOS  
int     10h                           ;CALL INTERRUPT 10H[VIDEO BIOS]
pop     cx                            ;RE-STORE CX  
endm                                  :END cputc() MACRO 

;--------------------------DISPLAY COLORED CHARACTER ON VIDEO BIOS------------------------------------------------ 


;-#12----------------------DISPLAY COLORED STRING ON THE VIDEO BIOS WITH CR & LF---------------------------------- 

;CR=CARRIAGE RETURN
;LF=LINE FEED

cprintf() macro string,len,row,col,color       ;START cprint() MACRO 
local str1c,skip_dlc
jmp skip_dlc
str1c db string,13,10,0                               
skip_dlc:
push ax 
push bx
push cx
push dx                                  
mov ah,13h                                    ;STRING DISPLAY FUNCTION
mov al,01h                                    ;DISPLAY CHARACTER AND ADVANCE THE CURSOR
mov bh,0                                       ;DEFAULT PAGENO
mov bl,color                                  ;FORE COLOR OF THE STRING
lea bp,str1c                                    ;LOAD THE ADDRESS OF THE STRING INTO BASE POINTER REGISTER
mov cx,len                                    ;LOAD THE LENGHT OF THE STRING INO COUNT REGISTER
mov dh,col                                    ;LOAD THE COLUMN NUMBER IN DATA HIGH REGISTER  
mov dl,row                                    ;LOAD THE RO NUMBER IN THE DATA LOW REGISTER
int 10h                                       ;CALL INTERRUPT 10H[VIDEO BIOS]
pop ax   
pop bx   
pop cx   
pop dx                                       
endm                                          ;END cprintf() MACRO 


;--------------------------DISPLAY COLORED STRING ON THE VIDEO BIOS----------------------------------------------- 

;-#13----------------------DISPLAY COLORED STRING ON THE VIDEO BIOS WITHOUT CR & LF------------------------------- 

;CR=CARRIAGE RETURN
;LF=LINE FEED

cprint() macro string,len,row,col,color       ;START cprint() MACRO 
local str1c,skip_dlc
jmp skip_dlc
str1c db string,0                               
skip_dlc:
push ax 
push bx
push cx
push dx                                  
mov ah,13h                                    ;STRING DISPLAY FUNCTION
mov al,01h                                    ;DISPLAY CHARACTER AND ADVANCE THE CURSOR
mov bh,0                                       ;DEFAULT PAGENO
mov bl,color                                  ;FORE COLOR OF THE STRING
lea bp,str1c                                    ;LOAD THE ADDRESS OF THE STRING INTO BASE POINTER REGISTER
mov cx,len                                    ;LOAD THE LENGHT OF THE STRING INO COUNT REGISTER
mov dh,col                                    ;LOAD THE COLUMN NUMBER IN DATA HIGH REGISTER  
mov dl,row                                    ;LOAD THE RO NUMBER IN THE DATA LOW REGISTER
int 10h                                       ;CALL INTERRUPT 10H[VIDEO BIOS]
pop ax   
pop bx   
pop cx   
pop dx                                       
endm                                          ;END cprintf() MACRO 

;--------------------------DISPLAY COLORED STRING ON THE VIDEO BIOS----------------------------------------------- 

