;|===============================================================================================================|
;|                                       MOKSHA DELAY TIMER BIOS[INT 15H,FUNCTION AH=86H] SYSTEM CALLS           |
;|===============================================================================================================|
;|_______________________________________________________________________________________________________________|
;|                                      DEVELOPED FOR THE MOKSHA OPERATING SYSTEM                                | 
;|                                      -------------------------------------------                              |
;|                                                    BY                                                         |
;|                                        HEMENDRA SINGH AND SURYA RAJ                                           |
;|                                        S.R.C.E.M.,GWALIOR,M.P.,INDIA                                          |
;|_______________________________________________________________________________________________________________| 
;|_________________________________ALL RIGHTS ARE RESERVED BY THE DEVELOPERS_____________________________________|     


delay() macro interval
local lp1
push ax                 ;STORE AX REGISTER
push bx                 ;STORE BX REGISTER 
push cx                 ;STORE CX REGISTER
push dx                 ;STORE DX REGISTER
mov cx,interval         ;STORE THE INTERVAL IN CX (COUNT REGISTER) RUNNING THE LOOP
add cx,1                ;ADD ONE TO THE COUNT REGISER
mov bx,cx               ;STORE THE VALUE OF CX IN BX REGISTER
; set 1 million microseconds interval (1 second)
lp1:                    ;LOOP LABEL
mov     cx, 0fh
mov     dx, 4240h 
mov     ah, 86h
int     15h            
sub bx,1               ;SUBTRACT 1 FROM BX REGISTER
mov cx,bx              ;STORE THE RESULT OF BX IN CX REGISETR
loop lp1               ;LOOP UNTIL (interval!=0)
pop ax                 ;RESTORE AX REGISTER
pop bx                 ;RESTORE BX REGISTER
pop cx                 ;RESTORE CX REGISTER
pop dx                 ;RESTORE DX REGISTER        
endm


