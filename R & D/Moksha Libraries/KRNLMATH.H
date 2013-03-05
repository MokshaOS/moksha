#ifndef KRNLMATH_H
#define KRNLMATH_H

///////////////////////INCREMENT REGITSER BY ONE SARTS////////////////////////

void inc(unsigned int regno)
{
if(regno==1)
{
asm inc ax   //INCREMENT AX REGISTER BY ONE
}
else if(regno==2)
{
asm inc bx   //INCREMENT BX REGISTER BY ONE
}
else if(regno==3)
{
asm inc cx   //INCREMENT CX REGISTER BY ONE
}
else if(regno==4)
{
asm inc dx   //INCREMENT DX REGISTER BY ONE
}
}

///////////////////////INCREMENT REGITSER BY ONE ENDS////////////////////////

///////////////////////DECREMENT REGITSER BY ONE SARTS////////////////////////

void dec(unsigned int regno)
{
if(regno==1)
{
asm dec ax   //DECREMENT AX REGISTER BY ONE
}
else if(regno==2)
{
asm dec bx   //DECREMENT AX REGISTER BY ONE
}
else if(regno==3)
{
asm dec cx   //DECREMENT AX REGISTER BY ONE
}
else if(regno==4)
{
asm dec dx   //DECREMENT AX REGISTER BY ONE
}
}

///////////////////////DECREMENT REGITSER BY ONE ENDS/////////////////////////

///////////////////////ADDITION OF REGISTER STARTS////////////////////////////

void add(unsigned int regno,unsigned int val)
{
if(regno==1)
{
asm add ax,val     //AX <- AX+val [REGISTER TRANSFER LANGUAGE]
}
if(regno==2)
{
asm add bx,val     //BX <- BX+val [REGISTER TRANSFER LANGUAGE]
}
if(regno==3)
{
asm add cx,val     //BX <- CX+val [REGISTER TRANSFER LANGUAGE]
}
if(regno==4)
{
asm add dx,val     //BX <- DX+val [REGISTER TRANSFER LANGUAGE]
}
}

///////////////////////ADDITION OF REGISTER ENDS///////////////////////////////

///////////////////////SUBRTACTION OF REGISTER STARTS//////////////////////////

void sub(unsigned int regno,unsigned int val)
{
if(regno==1)
{
asm sub ax,val   //AX <- AX-val [REGISTER TRANSFER LANGUAGE]
}
if(regno==2)
{
asm sub bx,val   //BX <- BX-val [REGISTER TRANSFER LANGUAGE]
}
if(regno==3)
{
asm sub cx,val   //CX <- CX+val [REGISTER TRANSFER LANGUAGE]
}
if(regno==4)
{
asm sub dx,val   //DX <- DX+val [REGISTER TRANSFER LANGUAGE]
}
}

///////////////////////SUBRTACTION OF REGISTER ENDS//////////////////////////

#endif