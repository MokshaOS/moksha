#include<iostream.h>
#include<conio.h>
#include<fstream.h>
#include<stdio.h>
#include<process.h>
#include<io.h>
void filestatus(char filename[]);
void main()
{
clrscr();
char data[]="";
int i=0;
char filename[400];
char **q;
textcolor(BLUE);
cprintf("                      MOKSHA COMMAND INTERPRETER FILE OPENER");
cout<<"\nENTER FILENAME:";
cin>>filename;
//CHECK THE FILE STATUS
filestatus(filename);
ifstream inputdata(filename);
if(!inputdata)
{
cout<<"NO FILE PRESENT TO OPEN";
}
else
{
cout<<"\nOUTPUT:\n\n";
while(!inputdata.eof())
{
inputdata>>data;
cout<<data<<" ";
i++;
if(i==220)
{
getch();
}
else if(i==240)
{
getch();
}
else if(i==250)
{
getch();
}
else if(i==270)
{
getch();
}
else if(i==290)
{
getch();
}
else if(i==310)
{
getch();
}
else if(i==330)
{
getch();
}
else if(i==350)
{
getch();
}
else if(i==370)
{
getch();
}
else if(i==390)
{
getch();
}
else if(i==410)
{
getch();
}
else if(i==430)
{
getch();
}
else if(i==450)
{
getch();
}
else if(i==470)
{
getch();
}
else if(i==490)
{
getch();
}
else if(i==510)
{
getch();
}
else if(i==520)
{
getch();
}
else if(i==540)
{
getch();
}
else if(i==560)
{
getch();
}
else if(i==580)
{
getch();
}
else if(i==600)
{
getch();
}
else if(i==620)
{
getch();
}
else if(i==640)
{
getch();
}
else if(i==680)
{
getch();
}
else if(i==700)
{
getch();
}
else if(i==720)
{
getch();
}
else if(i==740)
{
getch();
}
else if(i==760)
{
getch();
}
else if(i==780)
{
getch();
}
else if(i==800)
{
getch();
}
else if(i==820)
{
getch();
}
else if(i==840)
{
getch();
}
else if(i==860)
{
getch();
}
else if(i==880)
{
getch();
}
else if(i==900)
{
getch();
}
else if(i==920)
{
getch();
}
else if(i==940)
{
getch();
}
else if(i==980)
{
getch();
}
else if(i==1000)
{
getch();
}
else if(i==1020)
{
getch();
}
else if(i==1040)
{
getch();
}
else if(i==1080)
{
getch();
}
else if(i==1100)
{
getch();
}
else if(i==1120)
{
getch();
}
else if(i==1140)
{
getch();
}
else if(i==1160)
{
getch();
}
else if(i==1180)
{
getch();
}
else if(i==1200)
{
getch();
}
else if(i==1220)
{
getch();
}
else if(i==1240)
{
getch();
}
else if(i==1260)
{
getch();
}
else if(i==1280)
{
getch();
}
else if(i==1300)
{
getch();
}
else if(i==1320)
{
getch();
i=0;
}
}
}
textcolor(RED);
cout<<(int)sizeof(data);
cprintf("\n\n\r                      PRESS ANY KEY TO RETURN TO MCI");
getch();
execv("CMDNTPRT.EXE",q);
delete q;
exit(1);
}
void filestatus(char filename[])
{
int *accessreturnvalue=new int;//ALLOCATE MEMORY
*accessreturnvalue=access(filename,4);
if(*accessreturnvalue!=0)
{
cout<<"\nFILE DOES NOT EXIST/NO READ PERMISSION--ACCESS DENIED!";
delete accessreturnvalue;//DEALLOCATE MEMORY
char **q;
getch();
execv("CMDNTPRT.EXE",q);
delete q;
exit(1);
}
}
