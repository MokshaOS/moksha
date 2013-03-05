;///////////////////Sets System Time//////////////////////

include mvideo.inc                 
include emu8086.inc
;org 100h
#make_bin#

#LOAD_SEGMENT=0100h#                                                                                                             
LOAD_OFFSET=0000h#


#CS=0100h#	                                                   
#IP=0000h#	


setvmode()     
; Declare variables for storing  hour , minutes & seconds
; which will be taken as input from the user

hour DW ,0
min DW ,0
sec DW ,0

; Input Hour
print() "Enter Hour ( In 24 Hours Format ) - "
call SCAN_NUM
mov hour,cx
printf() "" ; Insert a blank line

; Input Mnutes
print() "Enter Minutes - "
call SCAN_NUM
mov min,cx
printf() "" ; Insert a blank line

; Input Seconds
print() "Enter Seconds - "
call SCAN_NUM
mov sec,cx
printf() "" ; Insert a blank line



; Decimal To BCD Conversion  For Hour
cmp hour,0
je h0
cmp hour,1
je h1
cmp hour,2
je h2
cmp hour,3
je h3
cmp hour,4
je h4    
cmp hour,5
je h5
cmp hour,6
je h6
cmp hour,7
je h7
cmp hour,8
je h8
cmp hour,9
je h9
cmp hour,10
je h10
cmp hour,11
je h11 
cmp hour,12
je h12 
cmp hour,13
je h13 
cmp hour,14
je h14 
cmp hour,15
je h15 
cmp hour,16
je h16 
cmp hour,17
je h17 
cmp hour,18
je h18 
cmp hour,19
je h19 
cmp hour,20
je h20 
cmp hour,21
je h21 
cmp hour,22
je h22 
cmp hour,23
je h23     
cmp hour,24
je h24 


h0:
mov hour,00h   
jmp hour_finish
h1:
mov hour,01h   
jmp hour_finish
h2:
mov hour,02h   
jmp hour_finish
h3:
mov hour,03h   
jmp hour_finish
h4:
mov hour,04h   
jmp hour_finish
h5:
mov hour,05h   
jmp hour_finish
h6:
mov hour,06h   
jmp hour_finish
h7:
mov hour,07h   
jmp hour_finish
h8:
mov hour,08h   
jmp hour_finish
h9:
mov hour,09h   
jmp hour_finish
h10:
mov hour,10h   
jmp hour_finish
h11:
mov hour,11h   
jmp hour_finish
h12:
mov hour,12h   
jmp hour_finish
h13:
mov hour,13h   
jmp hour_finish
h14:
mov hour,14h   
jmp hour_finish
h15:
mov hour,15h   
jmp hour_finish
h16:
mov hour,16h   
jmp hour_finish
h17:
mov hour,17h   
jmp hour_finish
h18:
mov hour,18h   
jmp hour_finish
h19:
mov hour,19h   
jmp hour_finish
h20:
mov hour,20h   
jmp hour_finish
h21:
mov hour,21h   
jmp hour_finish
h22:
mov hour,22h   
jmp hour_finish
h23:
mov hour,23h   
jmp hour_finish
h24:
mov hour,24h   
jmp hour_finish

hour_finish:

; Decimal To BCD Conversion For Hour

                                       
; Decimal To BCD Conversion For Minutes
cmp min,0
je m0
cmp min,1
je m1
cmp min,2
je m2
cmp min,3
je m3
cmp min,4
je m4    
cmp min,5
je m5
cmp min,6
je m6
cmp min,7
je m7     
cmp min,8
je m8
cmp min,9
je m9
cmp min,10
je m10
cmp min,11
je m11                   
cmp min,12
je m12 
cmp min,13
je m13 
cmp min,14
je m14 
cmp min,15
je m15 
cmp min,16
je m16 
cmp min,17
je m17 
cmp min,18
je m18 
cmp min,19
je m19 
cmp min,20
je m20 
cmp min,21
je m21 
cmp min,22
je m22 
cmp min,23
je m23     
cmp min,24
je m24 
cmp min,25
je m25   
cmp min,26
je m26 
cmp min,27
je m27 
cmp min,28
je m28 
cmp min,29
je m29 
cmp min,30
je m30 
cmp min,31
je m31 
cmp min,32
je m32 
cmp min,33
je m33 
cmp min,34
je m34 
cmp min,35
je m35 
cmp min,36
je m36 
cmp min,37
je m37 
cmp min,38
je m38 
cmp min,39
je m39 
cmp min,40
je m40 
cmp min,41
je m41 
cmp min,42
je m42 
cmp min,43
je m43 
cmp min,44
je m44 
cmp min,45
je m45 
cmp min,46
je m46 
cmp min,47
je m47 
cmp min,48
je m48 
cmp min,49
je m49 
cmp min,50
je m50 
cmp min,51
je m51 
cmp min,52
je m52        
cmp min,53
je m53        
cmp min,54
je m54        
cmp min,55
je m55        
cmp min,56
je m56        
cmp min,57
je m57        
cmp min,58
je m58        
cmp min,59
je m59        

m0:
mov min,00h   
jmp min_finish
m1:
mov min,01h   
jmp min_finish
m2:
mov min,02h   
jmp min_finish
m3:
mov min,03h   
jmp min_finish
m4:
mov min,04h   
jmp min_finish
m5:
mov min,05h   
jmp min_finish
m6:
mov min,06h   
jmp min_finish
m7:
mov min,07h   
jmp min_finish
m8:
mov min,08h   
jmp min_finish
m9:
mov min,09h   
jmp min_finish
m10:
mov min,10h   
jmp min_finish
m11:
mov min,11h   
jmp min_finish
m12:
mov min,12h   
jmp min_finish
m13:
mov min,13h   
jmp min_finish
m14:
mov min,14h   
jmp min_finish
m15:
mov min,15h   
jmp min_finish
m16:
mov min,16h   
jmp min_finish
m17:
mov min,17h   
jmp min_finish
m18:
mov min,18h   
jmp min_finish
m19:
mov min,19h   
jmp min_finish
m20:
mov min,20h   
jmp min_finish
m21:
mov min,21h   
jmp min_finish
m22:
mov min,22h   
jmp min_finish
m23:
mov min,23h   
jmp min_finish
m24:
mov min,24h   
jmp min_finish
m25:
mov min,25h   
jmp min_finish
m26:
mov min,26h   
jmp min_finish
m27:
mov min,27h   
jmp min_finish
m28:
mov min,28h   
jmp min_finish
m29:
mov min,29h   
jmp min_finish
m30:
mov min,30h   
jmp min_finish
m31:
mov min,31h   
jmp min_finish
m32:
mov min,32h   
jmp min_finish
m33:
mov min,33h   
jmp min_finish
m34:
mov min,34h   
jmp min_finish
m35:
mov min,35h   
jmp min_finish
m36:
mov min,36h   
jmp min_finish
m37:
mov min,37h   
jmp min_finish
m38:
mov min,38h   
jmp min_finish
m39:
mov min,39h   
jmp min_finish
m40:
mov min,40h   
jmp min_finish
m41:
mov min,41h   
jmp min_finish
m42:
mov min,42h   
jmp min_finish
m43:
mov min,43h   
jmp min_finish
m44:
mov min,44h   
jmp min_finish
m45:
mov min,45h   
jmp min_finish
m46:
mov min,46h   
jmp min_finish
m47:
mov min,47h   
jmp min_finish
m48:
mov min,48h   
jmp min_finish
m49:
mov min,49h   
jmp min_finish
m50:
mov min,50h   
jmp min_finish
m51:
mov min,51h   
jmp min_finish
m52:
mov min,52h   
jmp min_finish
m53:
mov min,53h   
jmp min_finish
m54:
mov min,54h   
jmp min_finish
m55:
mov min,55h   
jmp min_finish
m56:
mov min,56h   
jmp min_finish
m57:
mov min,57h   
jmp min_finish
m58:
mov min,58h   
jmp min_finish
m59:
mov min,59h   
jmp min_finish     

min_finish:
           

; Decimal To BCD Conversion For Minutes


; Decimal To BCD Conversion For Seconds
                           
cmp sec,0
je s0
cmp sec,1
je s1
cmp sec,2
je s2
cmp sec,3
je s3
cmp sec,4
je s4    
cmp sec,5
je s5
cmp sec,6
je s6
cmp sec,7
je s7     
cmp sec,8
je s8
cmp sec,9
je s9
cmp sec,10
je s10
cmp sec,11
je s11                   
cmp sec,12
je s12 
cmp sec,13
je s13 
cmp sec,14
je s14 
cmp sec,15
je s15 
cmp sec,16
je s16 
cmp sec,17
je s17 
cmp sec,18
je s18 
cmp sec,19
je s19 
cmp sec,20
je s20 
cmp sec,21
je s21 
cmp sec,22
je s22 
cmp sec,23
je s23     
cmp sec,24
je s24 
cmp sec,25
je s25   
cmp sec,26
je s26 
cmp sec,27
je s27 
cmp sec,28
je s28 
cmp sec,29
je s29 
cmp sec,30
je s30 
cmp sec,31
je s31 
cmp sec,32
je s32 
cmp sec,33
je s33 
cmp sec,34
je s34 
cmp sec,35
je s35 
cmp sec,36
je s36 
cmp sec,37
je s37 
cmp sec,38
je s38 
cmp sec,39
je s39 
cmp sec,40
je s40 
cmp sec,41
je s41 
cmp sec,42
je s42 
cmp sec,43
je s43 
cmp sec,44
je s44 
cmp sec,45
je s45 
cmp sec,46
je s46 
cmp sec,47
je s47 
cmp sec,48
je s48 
cmp sec,49
je s49 
cmp sec,50
je s50 
cmp sec,51
je s51 
cmp sec,52
je s52        
cmp sec,53
je s53        
cmp sec,54
je s54        
cmp sec,55
je s55        
cmp sec,56
je s56        
cmp sec,57
je s57        
cmp sec,58
je s58        
cmp sec,59
je s59

s0:
mov sec,00h   
jmp sec_finish
s1:
mov sec,01h   
jmp sec_finish
s2:
mov sec,02h   
jmp sec_finish
s3:
mov sec,03h   
jmp sec_finish
s4:
mov sec,04h   
jmp sec_finish
s5:
mov sec,05h   
jmp sec_finish
s6:
mov sec,06h   
jmp sec_finish
s7:
mov sec,07h   
jmp sec_finish
s8:
mov sec,08h   
jmp sec_finish
s9:
mov sec,09h   
jmp sec_finish
s10:
mov sec,10h   
jmp sec_finish
s11:
mov sec,11h   
jmp sec_finish
s12:
mov sec,12h   
jmp sec_finish
s13:
mov sec,13h   
jmp sec_finish
s14:
mov sec,14h   
jmp sec_finish
s15:
mov sec,15h   
jmp sec_finish
s16:
mov sec,16h   
jmp sec_finish
s17:
mov sec,17h   
jmp sec_finish
s18:
mov sec,18h   
jmp sec_finish
s19:
mov sec,19h   
jmp sec_finish
s20:
mov sec,20h   
jmp sec_finish
s21:
mov sec,21h   
jmp sec_finish
s22:
mov sec,22h   
jmp sec_finish
s23:
mov sec,23h   
jmp sec_finish
s24:
mov sec,24h   
jmp sec_finish
s25:
mov sec,25h   
jmp sec_finish
s26:
mov sec,26h   
jmp sec_finish
s27:
mov sec,27h   
jmp sec_finish
s28:
mov sec,28h   
jmp sec_finish
s29:
mov sec,29h   
jmp sec_finish
s30:
mov sec,30h   
jmp sec_finish
s31:
mov sec,31h   
jmp sec_finish
s32:
mov sec,32h   
jmp sec_finish
s33:
mov sec,33h   
jmp sec_finish
s34:
mov sec,34h   
jmp sec_finish
s35:
mov sec,35h   
jmp sec_finish
s36:
mov sec,36h   
jmp sec_finish
s37:   
mov sec,37h   
jmp sec_finish
s38:
mov sec,38h   
jmp sec_finish
s39:
mov sec,39h   
jmp sec_finish
s40:
mov sec,40h   
jmp sec_finish
s41:
mov sec,41h   
jmp sec_finish
s42:
mov sec,42h   
jmp sec_finish
s43:
mov sec,43h   
jmp sec_finish
s44:
mov sec,44h   
jmp sec_finish
s45:
mov sec,45h   
jmp sec_finish
s46:
mov sec,46h   
jmp sec_finish
s47:
mov sec,47h   
jmp sec_finish
s48:
mov sec,48h   
jmp sec_finish
s49:
mov sec,49h   
jmp sec_finish
s50:
mov sec,50h   
jmp sec_finish
s51:
mov sec,51h   
jmp sec_finish
s52:
mov sec,52h   
jmp sec_finish
s53:
mov sec,53h   
jmp sec_finish
s54:
mov sec,54h   
jmp sec_finish
s55:
mov sec,55h   
jmp sec_finish
s56:
mov sec,56h   
jmp sec_finish
s57:
mov sec,57h   
jmp sec_finish
s58:
mov sec,58h   
jmp sec_finish
s59:
mov sec,59h   
jmp sec_finish     

sec_finish:
        
                           
; Decimal To BCD Conversion For Seconds

; Set time to the input from the user  
mov ah,03h
mov ch,b.hour 
mov cl,b.min 
mov dh,b.sec
mov dl,00h  
int 1ah 


printf() "Time changed"

getch()                
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
hlt



                                                 