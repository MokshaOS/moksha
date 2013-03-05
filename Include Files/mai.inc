;|===============================================================================================================|
;|                               MOKSHA ARTIFICIAL INTELLIGENCE [INT 1AH,FUNCTION 02H] SYSTEM CALLS              |
;|===============================================================================================================|
;|_______________________________________________________________________________________________________________|
;|                                      DEVELOPED FOR THE MOKSHA OPERATING SYSTEM                                | 
;|                                      -------------------------------------------                              |
;|                                                    BY                                                         |
;|                                        HEMENDRA SINGH AND SURYA RAJ                                           |
;|                                        S.R.C.E.M.,GWALIOR,M.P.,INDIA                                          |
;|_______________________________________________________________________________________________________________| 
;|_________________________________ALL RIGHTS ARE RESERVED BY THE DEVELOPERS_____________________________________| 

;NOTE:IT REQUIRES MVIDEO.INC,PRINT() MACRO TO BE INCLUDED IN THE PROGRAM FOR PRINTING THE STRING ON THE VIDEO BIOS
;IT GIVES A GREETING MESSAGE BASED ON THE TIME OF THE DAY,THUS IMPLEMENTING ATRIFICAL INTELLIGENCE
;i.e THE ABILITY TO TAKE DECISIONS DEPENDING UPON THE PREVALING CIRUMSTANCES

maimsg() macro    ;SART MACRO
mov ah,02h      ;PASS GET SYSTEM TIME FUNCTION INTO AH REGISTER   
int 1ah         ;CALL INTERRUPT 1AH             
cmp ch,00h      ;COMPARE FOR 00 HRS,12 AM
je mai0  
cmp ch,01h      ;COMPARE FOR 01 HRS,1 AM
je mai1  
cmp ch,02h      ;COMPARE FOR 02 HRS,2 AM
je mai2
cmp ch,03h      ;COMPARE FOR 03 HRS,3 AM
je mai3
cmp ch,04h      ;COMPARE FOR 04 HRS,4 AM
je mai4
cmp ch,05h      ;COMPARE FOR 05 HRS,5 AM 
je mai5
cmp ch,06h      ;COMPARE FOR 06 HRS,6 AM
je mai6
cmp ch,07h      ;COMPARE FOR 07 HRS,7 AM
je mai7
cmp ch,08h      ;COMPARE FOR 08 HRS,8 AM 
je mai8
cmp ch,09h      ;COMPARE FOR 09 HRS,9 AM
je mai9
cmp ch,10h      ;COMPARE FOR 10 HRS,10 AM
je mai10  
cmp ch,11h      ;COMPARE FOR 11 HRS,11 AM
je mai11  
cmp ch,12h      ;COMPARE FOR 12 HRS,12 PM
je mai12  
cmp ch,13h      ;COMPARE FOR 13 HRS,1 PM 
je mai13  
cmp ch,14h      ;COMPARE FOR 14 HRS,2 PM 
je mai14
cmp ch,15h      ;COMPARE FOR 15 HRS,3 PM
je mai15
cmp ch,16h      ;COMPARE FOR 16 HRS,4 PM 
je mai16
cmp ch,17h      ;COMPARE FOR 17 HRS,5 PM 
je mai17
cmp ch,18h      ;COMPARE FOR 18 HRS,6 PM
je mai18    
cmp ch,19h      ;COMPARE FOR 19 HRS,7 PM
je mai19    
cmp ch,20h      ;COMPARE FOR 20 HRS,8 PM
je mai20    
cmp ch,21h      ;COMPARE FOR 21 HRS,9 PM
je mai21   
cmp ch,22h      ;COMPARE FOR 22 HRS,10 PM
je mai22    
cmp ch,23h      ;COMPARE FOR 23 HRS,11 PM
je mai23    
mai0:  
print() "MOKSHA->HELLO,GOOD MORNING USER"
jmp maifnsh
mai1:  
print() "MOKSHA->HELLO,GOOD MORNING USER"
jmp maifnsh
mai2:
print() "MOKSHA->HELLO,GOOD MORNING USER"
jmp maifnsh
mai3:        
print() "MOKSHA->HELLO,GOOD MORNING USER"
jmp maifnsh
mai4:
print() "MOKSHA->HELLO,GOOD MORNING USER"
jmp maifnsh    
mai5:        
print() "MOKSHA->HELLO,GOOD MORNING USER"
jmp maifnsh
mai6:        
print() "MOKSHA->HELLO,GOOD MORNING USER"
jmp maifnsh
mai7:        
print() "MOKSHA->HELLO,GOOD MORNING USER"
jmp maifnsh
mai8:        
print() "MOKSHA->HELLO,GOOD MORNING USER"
jmp maifnsh
mai9:        
print() "MOKSHA->HELLO,GOOD MORNING USER"
jmp maifnsh
mai10:       
print() "MOKSHA->HELLO,GOOD MORNING USER"
jmp maifnsh
mai11:        
print() "MOKSHA->HELLO,GOOD MORNING USER"
jmp maifnsh
mai12:        
print() "MOKSHA->HELLO,GOOD AFTERNOON USER"
jmp maifnsh
mai13:      
print() "MOKSHA->HELLO,GOOD AFTERNOON USER"
jmp maifnsh   
mai14:        
print() "MOKSHA->HELLO,GOOD AFTERNOON USER"
jmp maifnsh
mai15:        
print() "MOKSHA->HELLO,GOOD AFTERNOON USER"
jmp maifnsh
mai16:        
print() "MOKSHA->HELLO,GOOD AFTERNOON USER"
jmp maifnsh
mai17:        
print() "MOKSHA->HELLO,GOOD EVENING USER"
jmp maifnsh
mai18:        
print() "MOKSHA->HELLO,GOOD EVENING USER"
jmp maifnsh
mai19:        
print() "MOKSHA->HELLO,GOOD EVENING USER"
jmp maifnsh
mai20:        
print() "MOKSHA->HELLO,GOOD EVENING USER"
jmp maifnsh
mai21:        
print() "MOKSHA->HELLO,GOOD EVENING USER"
jmp maifnsh
mai22:        
print() "MOKSHA->HELLO,GOOD EVENING USER"
jmp maifnsh 
mai23:        
print() "MOKSHA->HELLO,GOOD EVENING USER"
jmp maifnsh
maifnsh:
nop
endm
