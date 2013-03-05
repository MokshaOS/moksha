#ifndef MOKSHA20_H
#define MOKSHA20_H
void return_to_os()
{
int86(0x20,&in,&out); //RETURN TO THE OPERATING SYSTEM
}
#endif