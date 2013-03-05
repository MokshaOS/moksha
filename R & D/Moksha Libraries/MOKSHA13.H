#ifndef MOKSHA13_H
#define MOKSHA13_H
int resetdisk()
{
in.h.ah=0x00;
in.h.dl=0x80;
int86(0x13,&in,&out);
return out.h.ah;
}
#endif