#ifndef MOKSHA33_H
#define MOKSHA33_H
////////////////////////////////INT 33H FUNCTIONS/////////////////////////////
void loadmouse()
{
in.x.ax=0x00;//FUNCTION 0[ASCII] FOR LOADING THE MOUSE
int86(0x33,&in,&out);//INT 33H[MOUSE INTERRUPT]
}
void showmouse()
{
in.x.ax=0x01;//FUNCTION 1[ASCII] FOR SHOWING THE MOSUE
int86(0x33,&in,&out);//INT 33H[MOUSE INTERRUPT]
}
void awakemouse()
{
//FUNCTION FOR LOADING AND SHOWING THE MOUSE
in.x.ax=0x00;
int86(0x33,&in,&out);
in.x.ax=0x01;
int86(0x33,&in,&out);
}
void hidemouse()
{
//FUNCTION FOR HIDING THE MOUSE
in.x.ax=0x02;
int86(0x33,&in,&out);
}
void restrictmouse(int x1,int y1,int x2,int y2)
{
in.x.ax=7;
in.x.cx=x1;
in.x.dx=x2;
int86(0x33,&in,&out);
in.x.ax=8;
in.x.cx=y1;
in.x.dx=y2;
int86(0x33,&in,&out);
}
void set_mouseposition(int x,int y)
{
in.x.ax=0x04;
in.x.cx=x;
in.x.dx=y;
int86(0x33,&in,&out);
}
int getmousex()
{
int mousex;
in.x.ax=3;
int86(0x33,&in,&out);
mousex=out.x.cx;
return mousex;
}
int getmousey()
{
int mousey;
in.x.ax=3;
int86(0x33,&in,&out);
mousey=out.x.dx;
return mousey;
}

////////////////////////////////INT 33H FUNCTIONS/////////////////////////////

#endif