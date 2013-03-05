/*
PROGRAM TO WRITE A 3.5 INCH 1.44 MB FLOPPY DISK IN RAW FILE FORMAT
DEVELOPED BY HEMENDRA SINGH & SURYA RAJ

SPECIFICATIONS:-

DISK SIZE =3.5 INCH
DISK CAPACITY=1.44 MB
NO OF HEADS/SIDES=2
NO OF TRACKS/CYLINDERS=80
NO OF SECTORS PER TRACK=18
BYTES PER SECTOR=512 BYTES
SECTORS PER CLUSTER=1
*/
#include<iostream.h>
#include<stdio.h>
#include<bios.h>
#include<conio.h>
#include<fstream.h>
#include<string.h>
#include<malloc.h>
void main()
{
clrscr();
_setcursortype(_NOCURSOR);
int drive=0;//DRIVE A
int head=0;//FIRST SIDE
int track=0;//CYLINDER/TRACK ZERO
int sector=1;//STARTING SECTOR
int no_of_sectors=18;//NO OF SECTORS TO FORMAT
char file_path[80];
char file_data[3805];
int file_size;
int i=0;
puts("\t\t3.5 INCH,1.44 MB FLOPPY DISK WRITTING TOOL");
puts("\n\t   DEVELOPED BY HEMENDRA SINGH & SURYA RAJ,S.R.C.E.M.,GWALIOR");
cout<<"\n\nENTER HEAD[0/1] = ";
cin>>head;
cout<<"\nENTER TRACK[0-79] = ";
cin>>track;
cout<<"\nENTER STARTING SECTOR[1-18] = ";
cin>>sector;
cout<<"\nENTER FILE PATH = ";
cin>>file_path;
ifstream openfile(file_path,ios::binary,ios::beg);
if(!openfile)
{
cout<<"\n\aFILE I/O ERROR";
}
else
{
while(!openfile.eof())
{
openfile.read((char *)&file_data,sizeof(file_data));
cout<<file_data;
i++;
}
file_size=sizeof(file_data);
puts("\n-------------------------------------------------------------------------------");
cout<<"\nFILE SIZE = "<<file_size<<" BYTES";
puts("\n\n\nWRITTING STARTED...");
biosdisk(_DISK_WRITE,drive,head,track,sector,8,file_data);
puts("\n-------------------------------WRITING COMPLETED-------------------------------");
}
getch();
}