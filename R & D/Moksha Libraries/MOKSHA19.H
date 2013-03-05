#ifndef MOKSHA19_H
#define MOKSHA19_H
void restart_computer()
{
int86(0x19,&in,&out); //RESTART/REBOOT THE COMPUTER
}
#endif