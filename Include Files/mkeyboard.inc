;|===============================================================================================================|
;|                                       MOKSHA KEYBOARD BIOS[INT 16H] SYSTEM CALLS                              |
;|===============================================================================================================|
;|_______________________________________________________________________________________________________________|
;|                                      DEVELOPED FOR THE MOKSHA OPERATING SYSTEM                                | 
;|                                      -------------------------------------------                              |
;|                                                    BY                                                         |
;|                                        HEMENDRA SINGH AND SURYA RAJ                                           |
;|                                        S.R.C.E.M.,GWALIOR,M.P.,INDIA                                          |
;|_______________________________________________________________________________________________________________| 
;|_________________________________ALL RIGHTS ARE RESERVED BY THE DEVELOPERS_____________________________________|     

getkey() macro ;REGISTER RETURN VALUE,AH=BIOS SCAN CODE,AL=ASCII CODE
mov ah,10h     ;Does not echo to the video BIOS
int 16h
endm

settyperate() macro delay_rate,repeat_rate
;NOTE #1 :- BH= 0 -> 1/4 sec , BH= 1 -> 1/2 sec(default) , BH= 2 -> 3/4 sec and BH=3 -> 1 sec
;NOTE #2 :- BL = 0(fastest) to 31(slowest) 
mov ah,03H
mov al,05H
mov bh,delay_rate
mov bl,repeat_rate
int 16h
endm


;-------------------------------BIOS KEY DETECTION MACROS---------------------------------------------------------

;================================FUNCTION KEYS====================================================================

;NOTE:-ONLY THE VALUE IN AH REGISTER NEEDS TO BE CHECKED AND THERE IS NO NEED OF CHECKING THE VALUE IN AL REGISTER ;FOR FUNCTION KEYS BECAUSE THE FUNCTION KEYS ALWAYS RETURN 00H IN AL REGISTER

F1 macro
mov bh,3BH
endm

F2 macro
mov bh,3CH
endm

F3 macro
mov bh,3DH
endm

F4 macro
mov bh,3EH
endm

F5 macro
mov bh,3FH
endm

F6 macro
mov bh,40H
endm

F7 macro
mov bh,41H
endm

F8 macro
mov bh,42H
endm

F9 macro
mov bh,43H
endm

F10 macro
mov bh,44H
endm

F11 macro
mov bh,85H
endm

F12 macro
mov bh,86H
endm



SHIFT+F1 macro
mov bh,54h
endm

SHIFT+F2 macro
mov bh,54h
endm

SHIFT+F3 macro
mov bh,54h
endm

SHIFT+F4 macro
mov bh,54h
endm

SHIFT+F5 macro
mov bh,54h
endm

SHIFT+F6 macro
mov bh,54h
endm

SHIFT+F7 macro
mov bh,5Ah
endm

SHIFT+F8 macro
mov bh,5Bh
endm

SHIFT+F9 macro
mov bh,5Ch
endm

SHIFT+F10 macro
mov bh,5Dh
endm

SHIFT+F11 macro
mov bh,87h
endm

SHIFT+F12 macro
mov bh,88h
endm



CTRL+F1 macro
mov bh,5EH
endm

CTRL+F2 macro
mov bh,5FH
endm

CTRL+F3 macro
mov bh,60H
endm

CTRL+F4 macro
mov bh,61H
endm

CTRL+F5 macro
mov bh,62H
endm

CTRL+F6 macro
mov bh,63H
endm

CTRL+F7 macro
mov bh,64H
endm

CTRL+F8 macro
mov bh,65H
endm

CTRL+F9 macro
mov bh,66H
endm

CTRL+F10 macro
mov bh,67H
endm

CTRL+F11 macro
mov bh,89H
endm

CTRL+F12 macro
mov bh,8AH
endm



ALT+F1 macro
mov bh,68H
endm

ALT+F2 macro
mov bh,69H
endm

ALT+F3 macro
mov bh,6AH
endm

ALT+F4 macro
mov bh,6BH
endm

ALT+F5 macro
mov bh,6CH
endm

ALT+F6 macro
mov bh,6DH
endm

ALT+F7 macro
mov bh,6EH
endm

ALT+F8 macro
mov bh,6FH
endm

ALT+F9 macro
mov bh,70H
endm

ALT+F10 macro
mov bh,71H
endm

ALT+F11 macro
mov bh,8BH
endm

ALT+F12 macro
mov bh,8CH
endm

;================================FUNCTION KEYS====================================================================


;================================OPERATION KEYS===================================================================

ESCAPE macro
mov bh,01H
endm

BACKSPACE macro
mov bh,0EH
endm

TAB macro
mov bh,0Fh
endm

ENTER macro
mov bh,1Ch
endm

;================================OPERATION KEYS===================================================================


;-------------------------------BIOS KEY DETECTION MACROS---------------------------------------------------------

