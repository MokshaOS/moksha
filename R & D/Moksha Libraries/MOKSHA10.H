#ifndef MOKSHA10_H
#define MOKSHA10_H
///////////////////////////INT 10H FUNCTIONS//////////////////////////////////
//////////////////////////TEXT MODE FUNCTIONS////////////////////////////////
void writeascii(char character)
{
//FOR TEXT MODE ONLY
in.h.ah=0x0A;
in.h.al=character;//CHARACTER TO DISPLAY
in.h.bh=0;//PAGENO
in.x.cx=1;//REPEAT TIMES
int86(0x10,&in,&out);
}
void repeatascii(char character,int repeat_no_of_times)
{
//FOR TEXT MODE ONLY
in.h.ah=0x0A;
in.h.al=character;//CHARACTER TO DISPLAY
in.h.bh=0;//PAGENO
in.x.cx=repeat_no_of_times;//REPEAT TIMES
int86(0x10,&in,&out);
}

void gotoxy(int row,int column)
{//FOR TEXT MODE ONLY
in.h.ah=0x02;//FUNCTION FOR SETTING THE CURSOR
in.h.bh=0;//STARTING PAGE NUMBER
in.h.dh=column;//STARTING ROW
in.h.dl=row;//STARTING COLUMN
int86(0x10,&in,&out);//INTERRUPT 10H
}
void scrolluptext()
{
//TEXT MODE ONLY
in.x.ax=0x601;
in.h.bh=0x61;
in.x.cx=0x0000;
in.x.dx=0x184F;
int86(0x10,&in,&out);
}
int readcursor()
{//FOR TEXT MODE ONLY
in.h.ah=0x08;
in.h.bh=0;//PAGENO
int86(0x10,&in,&out);
return in.h.al;//RETURNS CHARACTER AT CURSOR
}
void teletype(char character)
{//FOR TEXT MODE
in.h.ah=0x0E;
in.h.al=character;
int86(0x10,&in,&out);
}
//////////////////////////TEXT MODE FUNCTIONS////////////////////////////////

/////////////////////////COMMON MODE FUNCTIONS///////////////////////////////
void clrscr()
{//ALL MODES SUPPORTED
in.x.ax=0x0600;//AH=06(SCROLL),AL=00(FULL SCREEN)
in.h.bh=0x07;//0=BLACK BAKGROUND,7=WHITE FOREGROUND
in.x.cx=0x0000;//UPPER LEFT ROW:COLUMN
in.x.dx=0x4979;//49TH ROW,79TH COLUMN
int86(0x10,&in,&out);
}
void setcursor()
{//ALL MODES SUPPORTED
in.h.ah=0x02;//FUNCTION FOR SETTING THE CURSOR
in.h.bh=0;//STARTING PAGE NUMBER
in.h.dh=0;//STARTING ROW
in.h.dl=0;//STARTING COLUMN
int86(0x10,&in,&out);//INTERRUPT 10H
}
void rectanglecursor()
{
//ALL MODES SUPPORTED
in.h.ah=0x01;
in.h.ch=0x00;
in.h.cl=0x14;
int86(0x10,&in,&out);
}
void nocursor()
{
//ALL MODES SUPPORTED
in.h.ah=0x01;//SET CURSOR
in.x.cx=0x1000;//CH[START SCAN LINE]:CL[END SCAN LINE]
int86(0x10,&in,&out);
}
/////////////////////////COMMON MODE FUNCTIONS//////////////////////////////

//////////////////////////////GRAPHICS MODE FUNCTIONS////////////////////////
void setvideomode(int modeno)
{
//FOR GRAPHICS MODE ONLY EXCEPT SETTING IT FOR MODENO 7
in.h.ah=0x00;
in.h.al=modeno;
int86(0x10,&in,&out);
/*
MODENO  ROWS x COLUMNS TYPE       AREA  PAGES RESOLUTION PALETTE
0       25 x 40        COLOR      B800  0-7   360 x 400   16
1       25 x 40        COLOR      B800  0-7   360 x 400   16
2       25 x 80        COLOR      B800  0-3   720 x 400   16
3       25 x 80        COLOR      B800  0-3   720 x 400   16
7       25 x 80        MONOCHROME B800  0     720 x 400
NOTE-MODENO 7 IS TEXT MODE WHICH IS THE DEFAULT MODENO IF
NO OTHER MODE IS SPECIFIED
*/
}
void writechar(char character,int attribute,int pageno)
{
//FOR GRAPHICS MODE ONLY
in.h.ah=0x0A;
in.h.al=character;//CHARACTER TO DISPLAY
in.h.bh=pageno;//PAGENO
in.h.bl=attribute;//COLOUR CODE
in.x.cx=1;//REPEAT TIMES
int86(0x10,&in,&out);
}
void moveto(int row,int column,int pageno)
{
//FOR GRAPHICS MODE ONLY
in.h.ah=0x02;//FUNCTION FOR SETTING THE CURSOR
in.h.bh=pageno;//STARTING PAGE NUMBER
in.h.dh=column;//STARTING ROW
in.h.dl=row;//STARTING COLUMN
int86(0x10,&in,&out);//INTERRUPT 10H
}

void setcolor(int colourcode)
{
//FOR GRAPHICS MODE ONLY
in.h.bh=0x0+colourcode;//SET TEXT FOREGROUND COLOUR
int86(0x10,&in,&out);//INTERRUPT 1OH
}
void setactivepage(int pageno)
{
//FOR GRAPHICS MODE ONLY
in.h.ah=0x05;//FUNCTION FOR SETTING THE ACTIVE PAGE[16 BIT]
	     //HIGH MEMORY AREA
in.h.al=pageno;//MOVE VALUE OF pageno INTO LOW MEMORY AREA
int86(0x10,&in,&out);//INT 10H
}
void setcurpage(int page,int row,int column)
{
//FOR GRAPHICS MODE ONLY
in.h.ah=0x02;//FUNCTION FOR SETTING THE CURSOR
in.h.bh=(int)page;//STARTING PAGE NUMBER
in.h.dh=(int)row;//STARTING ROW
in.h.dl=(int)column;//STARTING COLUMN
int86(0x10,&in,&out);//INTERRUPT 10H
}
void fillcolor(int colourcode)
{
//FOR GRAPHICS MODE ONLY
in.x.ax=0x0600;//AH=06(SCROLL),AL=00(FULL SCREEN)
in.h.bh=colourcode;//0=BLACK BAKGROUND,7=WHITE FOREGROUND
in.x.cx=0x0000;//UPPER LEFT ROW:COLUMN
in.x.dx=0x4979;//49TH ROW,79TH COLUMN
int86(0x10,&in,&out);
}
int readgraphics(int pageno)
{
//FOR GRAPHICS MODE ONLY
in.h.ah=0x08;
in.h.bh=pageno;//PAGENO
int86(0x10,&in,&out);
return in.h.al;//RETURNS CHARACTER AT CURSOR
}
int readattrib()
{
//FOR GRAPHICS MODE
in.h.ah=0x08;
in.h.bh=0;
int86(0x10,&in,&out);
return in.h.ah;//RETURNS ATTRIBUTE AT CURSOR
}
void graphicsteletype(char character,int foregroundcolor)
{
//FOR GRAPHICS MODE
in.h.ah=0x0E;
in.h.al=character;
in.h.bl=foregroundcolor;
int86(0x10,&in,&out);
}
void scrollupgraphics()
{
//GRAPHICS MODE ONLY
in.x.ax=0x601;
in.h.bh=0x61;
in.x.cx=0x0000;
in.x.dx=0x184F;
int86(0x10,&in,&out);
}
///////////////////////////////GRAPHICS MODE FUNCTIONS////////////////////////

#endif