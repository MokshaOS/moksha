;|===============================================================================================================|
;|                               MOKSHA BIOS SYSTEM TIME [INT 1AH,FUNCTION 02H] SYSTEM CALLS                     |
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

hour() macro
mov ah,02h         
int 1ah
cmp ch,00h 
je ht0  
cmp ch,01h
je ht1  
cmp ch,02h
je ht2
cmp ch,03h
je ht3
cmp ch,04h
je ht4
cmp ch,05h
je ht5
cmp ch,06h
je ht6
cmp ch,07h
je ht7
cmp ch,08h
je ht8
cmp ch,09h
je ht9
cmp ch,10h
je ht10  
cmp ch,11h
je ht11  
cmp ch,12h
je ht12  
cmp ch,13h
je ht13  
cmp ch,14h
je ht14
cmp ch,15h
je ht15
cmp ch,16h
je ht16
cmp ch,17h
je ht17
cmp ch,18h
je ht18    
cmp ch,19h
je ht19    
cmp ch,20h
je ht20    
cmp ch,21h
je ht21   
cmp ch,22h
je ht22    
cmp ch,23h
je ht23    
ht0:  
print() "0"
jmp finish1
ht1:  
print() "1"
jmp finish1
ht2:
print() "2"
jmp finish1
ht3:        
print() "3"
jmp finish1
ht4:
print() "4"
jmp finish1    
ht5:        
print() "5"
jmp finish1
ht6:        
print() "6"
jmp finish1
ht7:        
print() "7"
jmp finish1
ht8:        
print() "8"
jmp finish1
ht9:        
print() "9"
jmp finish1
ht10:       
print() "10"
jmp finish1
ht11:        
print() "11"
jmp finish1
ht12:        
print() "12"
jmp finish1
ht13:      
print() "13"
jmp finish1   
ht14:        
print() "14"
jmp finish1
ht15:        
print() "15"
jmp finish1
ht16:        
print() "16"
jmp finish1
ht17:        
print() "17"
jmp finish1
ht18:        
print() "18"
jmp finish1
ht19:        
print() "19"
jmp finish1
ht20:        
print() "20"
jmp finish1
ht21:        
print() "21"
jmp finish1
ht22:        
print() "22"
jmp finish1 
ht23:        
print() "23"
jmp finish1
finish1:
nop
endm

min() macro
mov ah,02h         
int 1ah  
cmp cl,00h 
je mt0  
cmp cl,01h
je mt1  
cmp cl,02h
je mt2
cmp cl,03h
je mt3
cmp cl,04h
je mt4
cmp cl,05h
je mt5
cmp cl,06h
je mt6
cmp cl,07h
je mt7
cmp cl,08h
je mt8
cmp cl,09h
je mt9
cmp cl,10h
je mt10  
cmp cl,11h
je mt11  
cmp cl,12h
je mt12  
cmp cl,13h
je mt13  
cmp cl,14h
je mt14
cmp cl,15h
je mt15
cmp cl,16h
je mt16
cmp cl,17h
je mt17
cmp cl,18h
je mt18    
cmp cl,19h
je mt19    
cmp cl,20h
je mt20    
cmp cl,21h
je mt21   
cmp cl,22h
je mt22    
cmp cl,23h
je mt23    
cmp cl,24h
je mt24
cmp cl,25h
je mt25
cmp cl,26h
je mt26
cmp cl,27h
je mt27
cmp cl,28h
je mt28
cmp cl,29h
je mt29
cmp cl,30h
je mt30
cmp cl,31h
je mt31
cmp cl,32h
je mt32
cmp cl,33h
je mt33
cmp cl,34h
je mt34
cmp cl,35h
je mt35
cmp cl,36h
je mt36
cmp cl,37h
je mt37
cmp cl,38h
je mt38
cmp cl,39h
je mt39
cmp cl,40h
je mt40
cmp cl,41h
je mt41
cmp cl,42h
je mt42
cmp cl,43h
je mt43
cmp cl,44h
je mt44
cmp cl,45h
je mt45
cmp cl,46h
je mt46
cmp cl,47h
je mt47
cmp cl,48h
je mt48
cmp cl,49h
je mt49
cmp cl,50h
je mt50
cmp cl,51h
je mt51
cmp cl,52h
je mt52
cmp cl,53h
je mt53
cmp cl,54h
je mt54
cmp cl,55h
je mt55
cmp cl,56h
je mt56
cmp cl,57h
je mt57
cmp cl,58h
je mt58
cmp cl,59h
je mt59
 
mt0:  
print() "0"
jmp finish2
mt1:  
print() "1"
jmp finish2
mt2:
print() "2"
jmp finish2
mt3:        
print() "3"
jmp finish2
mt4:
print() "4"
jmp finish2    
mt5:        
print() "5"
jmp finish2
mt6:        
print() "6"
jmp finish2
mt7:        
print() "7"
jmp finish2
mt8:        
print() "8"
jmp finish2
mt9:        
print() "9"
jmp finish2
mt10:       
print() "10"
jmp finish2
mt11:        
print() "11"
jmp finish2
mt12:        
print() "12"
jmp finish2
mt13:      
print() "13"
jmp finish2   
mt14:        
print() "14"
jmp finish2
mt15:        
print() "15"
jmp finish2
mt16:        
print() "16"
jmp finish2
mt17:        
print() "17"
jmp finish2
mt18:        
print() "18"
jmp finish2
mt19:        
print() "19"
jmp finish2
mt20:        
print() "20"
jmp finish2
mt21:        
print() "21"
jmp finish2
mt22:        
print() "22"
jmp finish2 
mt23:        
print() "23"
jmp finish2
mt24:        
print() "24"
jmp finish2 
mt25:        
print() "25"
jmp finish2
mt26:        
print() "26"
jmp finish2 
mt27:        
print() "27"
jmp finish2 
mt28:        
print() "28"
jmp finish2 
mt29:        
print() "29"
jmp finish2 
mt30:        
print() "30"
jmp finish2 
mt31:        
print() "31"
jmp finish2 
mt32:        
print() "32"
jmp finish2 
mt33:        
print() "33"
jmp finish2 
mt34:        
print() "34"
jmp finish2 
mt35:        
print() "35"
jmp finish2 
mt36:        
print() "36"
jmp finish2 
mt37:        
print() "37"
jmp finish2 
mt38:        
print() "38"
jmp finish2 
mt39:        
print() "39"
jmp finish2 
mt40:        
print() "40"
jmp finish2 
mt41:        
print() "41"
jmp finish2 
mt42:        
print() "42"
jmp finish2 
mt43:        
print() "43"
jmp finish2 
mt44:        
print() "44"
jmp finish2 
mt45:        
print() "45"
jmp finish2 
mt46:        
print() "46"
jmp finish2 
mt47:        
print() "47"
jmp finish2 
mt48:        
print() "48"
jmp finish2 
mt49:        
print() "49"
jmp finish2 
mt50:        
print() "50"
jmp finish2 
mt51:        
print() "51"
jmp finish2 
mt52:        
print() "52"
jmp finish2 
mt53:        
print() "54"
jmp finish2 
mt54:        
print() "55"
jmp finish2 
mt55:        
print() "56"
jmp finish2 
mt56:        
print() "57"
jmp finish2 
mt57:        
print() "57"
jmp finish2 
mt58:        
print() "58"
jmp finish2  
mt59:        
print() "59"
jmp finish2  
 
finish2:
nop
endm

sec() macro
mov ah,02h         
int 1ah  
cmp dh,00h 
je st0  
cmp dh,01h
je st1  
cmp dh,02h
je st2
cmp dh,03h
je st3
cmp dh,04h
je st4
cmp dh,05h
je st5
cmp cl,06h
je st6
cmp dh,07h
je st7
cmp dh,08h
je st8
cmp dh,09h
je st9
cmp dh,10h
je st10  
cmp dh,11h
je st11  
cmp dh,12h
je st12  
cmp dh,13h
je st13  
cmp dh,14h
je st14
cmp dh,15h
je st15
cmp dh,16h
je st16
cmp dh,17h
je st17
cmp dh,18h
je st18    
cmp dh,19h
je st19    
cmp dh,20h
je st20    
cmp dh,21h
je st21   
cmp dh,22h
je st22    
cmp dh,23h
je st23    
cmp dh,24h
je st24
cmp dh,25h
je st25
cmp dh,26h
je st26
cmp dh,27h
je st27
cmp dh,28h
je st28
cmp dh,29h
je st29
cmp dh,30h
je st30
cmp dh,31h
je st31
cmp dh,32h
je st32
cmp dh,33h
je st33
cmp dh,34h
je st34
cmp dh,35h
je st35
cmp dh,36h
je st36
cmp dh,37h
je st37
cmp dh,38h
je st38
cmp dh,39h
je st39
cmp dh,40h
je st40
cmp dh,41h
je st41
cmp dh,42h
je st42
cmp dh,43h
je st43
cmp dh,44h
je st44
cmp dh,45h
je st45
cmp dh,46h
je st46
cmp dh,47h
je st47
cmp dh,48h
je st48
cmp dh,49h
je st49
cmp dh,50h
je st50
cmp dh,51h
je st51
cmp dh,52h
je st52
cmp dh,53h
je st53
cmp dh,54h
je st54
cmp dh,55h
je st55
cmp dh,56h
je st56
cmp dh,57h
je st57
cmp dh,58h
je st58
cmp dh,59h
je st59
 
st0:  
print() "0"
jmp finish3
st1:  
print() "1"
jmp finish3
st2:
print() "2"
jmp finish3
st3:        
print() "3"
jmp finish3
st4:
print() "4"
jmp finish3   
st5:        
print() "5"
jmp finish3
st6:        
print() "6"
jmp finish3
st7:        
print() "7"
jmp finish3
st8:        
print() "8"
jmp finish3
st9:        
print() "9"
jmp finish3
st10:       
print() "10"
jmp finish3
st11:        
print() "11"
jmp finish3
st12:        
print() "12"
jmp finish3
st13:      
print() "13"
jmp finish3   
st14:        
print() "14"
jmp finish3
st15:        
print() "15"
jmp finish3
st16:        
print() "16"
jmp finish3
st17:        
print() "17"
jmp finish3
st18:        
print() "18"
jmp finish3
st19:        
print() "19"
jmp finish3
st20:        
print() "20"
jmp finish3
st21:        
print() "21"
jmp finish3
st22:        
print() "22"
jmp finish3 
st23:        
print() "23"
jmp finish3
st24:        
print() "24"
jmp finish3
st25:        
print() "25"
jmp finish3
st26:        
print() "26"
jmp finish3
st27:        
print() "27"
jmp finish3
st28:        
print() "28"
jmp finish3
st29:        
print() "29"
jmp finish3
st30:        
print() "30"
jmp finish3
st31:        
print() "31"
jmp finish3
st32:        
print() "32"
jmp finish3
st33:        
print() "33"
jmp finish3
st34:        
print() "34"
jmp finish3
st35:        
print() "35"
jmp finish3
st36:        
print() "36"
jmp finish3
st37:        
print() "37"
jmp finish3
st38:        
print() "38"
jmp finish3
st39:        
print() "39"
jmp finish3
st40:        
print() "40"
jmp finish3
st41:        
print() "41"
jmp finish3
st42:        
print() "42"
jmp finish3
st43:        
print() "43"
jmp finish3
st44:        
print() "44"
jmp finish3
st45:        
print() "45"
jmp finish3
st46:        
print() "46"
jmp finish3
st47:        
print() "47"
jmp finish3
st48:        
print() "48"
jmp finish3
st49:        
print() "49"
jmp finish3
st50:        
print() "50"
jmp finish3
st51:        
print() "51"
jmp finish3
st52:        
print() "52"
jmp finish3
st53:        
print() "53"
jmp finish3
st54:        
print() "54"
jmp finish3
st55:        
print() "55"
jmp finish3
st56:        
print() "56"
jmp finish3
st57:        
print() "57"
jmp finish3
st58:        
print() "58"
jmp finish3
st59:        
print() "59"
jmp finish3
 
finish3:
nop
endm