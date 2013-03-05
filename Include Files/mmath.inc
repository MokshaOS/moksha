;|===============================================================================================================|
;|                                      MOKSHA LOW TO HIGH LEVEL PROCESSOR ARITHMETIC                            | 
;|===============================================================================================================|
;|_______________________________________________________________________________________________________________|
;|                                      DEVELOPED FOR THE MOKSHA OPERATING SYSTEM                                | 
;|                                      -------------------------------------------                              |
;|                                                    BY                                                         |
;|                                        HEMENDRA SINGH AND SURYA RAJ                                           |
;|                                        S.R.C.E.M.,GWALIOR,M.P.,INDIA                                          |
;|_______________________________________________________________________________________________________________| 
;|_________________________________ALL RIGHTS ARE RESERVED BY THE DEVELOPERS_____________________________________|     

;Note:The result of any macro described in this include file is always stored in Processor Accumulator(AX) 
;register

;------------------------------------BASIC ARITHMETIC FUNCTIONS---------------------------------------------------

add(+) macro wvar1,wvar2      ;For both 8-bit & 16-bit operands
mov ax,wvar1
mov bx,wvar2
add ax,bx
endm

subtract(-) macro wvar1,wvar2 ;For both 8-bit & 16-bit operands
mov ax,wvar1
mov bx,wvar2
sub ax,bx
endm


multiply(*) macro bvar1,bvar2 ;For 8-bit operands only
mov al,bvar1
mov bl,bvar2
mul bl
endm

divide(/) macro bvar1,bvar2   ;For 8-bit operands only
mov al,bvar1
mov bl,bvar2
div bl
endm

modulo(%) macro bvar1,bvar2   ;For 8-bit operands only
mov al,bvar1
mov bl,bvar2
div bl
mov al,ah
mov ah,0
endm


power() macro variable,value  ;For 8-bit operands only
mov cx,value
mov dx,1
sub cx,dx
mov al,variable
mov bl,variable
power:
mul bl
loop power
endm
;------------------------------------BASIC ARITHMETIC FUNCTIONS---------------------------------------------------


;----------------------------------UNARY ARITHMETIC FUNCTIONS---------------------------------------------------

++ macro varinc   ;For both 8-bit & 16-bit operands
inc varinc
mov ax,varinc
endm

-- macro vardec   ;For both 8-bit & 16-bit operands
dec vardec
mov ax,vardec
endm


++2 macro varinc2 ;For both 8-bit & 16-bit operands
inc varinc
inc varinc
mov ax,varinc
endm

--2 macro vardec2 ;For both 8-bit & 16-bit operands
dec vardec
dec vardec
mov ax,vardec
endm


++3 macro varinc3 ;For both 8-bit & 16-bit operands
inc varinc
inc varinc
inc varinc
mov ax,varinc
endm

--3 macro vardec3 ;For both 8-bit & 16-bit operands
dec vardec
dec vardec
dec vardec
mov ax,vardec
endm

;------------------------------------UNARY ARITHMETIC FUNCTIONS---------------------------------------------------


;------------------------------------------TRIGNOMETRIC ARITHMETIC------------------------------------------------


sin(0) macro
mov ax,0
endm

sin(90) macro
mov ax,1
endm

sin(180) macro
mov ax,0
endm

cos(0) macro
mov ax,1
endm

cos(90) macro
mov ax,0
endm


cos(180) macro
mov ax,-1
endm

;------------------------------------------TRIGNOMETRIC ARITHMETIC------------------------------------------------
