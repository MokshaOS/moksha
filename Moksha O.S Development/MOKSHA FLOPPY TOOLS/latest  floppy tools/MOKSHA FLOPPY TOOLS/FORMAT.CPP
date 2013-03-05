/*
PROGRAM TO FORMAT A 3.5 INCH 1.44 MB FLOPPY DISK IN RAW FILE FORMAT
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
#include<stdio.h>
#include<bios.h>
#include<conio.h>
#include<process.h>
void main()
{
clrscr();
_setcursortype(_NOCURSOR);
int drive=0;//DRIVE A
int head=0;//FIRST SIDE
int track=0;//CYLINDER/TRACK ZERO
int sector=1;//STARTING SECTOR
int no_of_sectors=18;//NO OF SECTORS TO FORMAT
char buffer[512];//DATA BUFFER
int disk_status;
int completed_percent;
int i;
int count=1;
puts("--------------------------------------------------------------------------------");
textcolor(7);
cprintf("                   3.5 INCH,1.44 MB FLOPPY DISK FORMATTIING TOOL");
textcolor(11);
cprintf("\r\n\n     DEVELOPED BY HEMENDRA SINGH & SURYA RAJ,S.R.C.E.M.,GWALIOR,M.P.,INDIA      ");
puts("--------------------------------------------------------------------------------");
disk_status=biosdisk(_DISK_READ,drive,head,track,sector,1,buffer);
int chance_count=1;
disk_present__status:
if(disk_status==0X01)
{
gotoxy(30,20);
printf("\n\n\t\t\tDISKETTE NOT READY YET.\n\n\t\t\tPRESS ANY KEY TO CONTINUE...");
getch();
if(chance_count>=4)
{
exit(0);
}
printf("\n\n\t           %d ATTEMPT TO SENSE FLOPPY DISK FAILED",chance_count);
chance_count++;
goto disk_present__status;
}
else
{
clrscr();
puts("--------------------------------------------------------------------------------");
textcolor(7);
cprintf("                   3.5 INCH,1.44 MB FLOPPY DISK FORMATTIING TOOL");
textcolor(11);
cprintf("\r\n\n     DEVELOPED BY HEMENDRA SINGH & SURYA RAJ,S.R.C.E.M.,GWALIOR,M.P.,INDIA      ");
puts("--------------------------------------------------------------------------------");
puts("\n\n\nFORMATTING STARTED...");
//FORMAT FIRST SIDE
for(i=0;i<=79;i++)
{
biosdisk(_DISK_FORMAT,drive,head,track+i,sector,no_of_sectors,buffer);
completed_percent=((count*100)/160);
gotoxy(1,13);
printf("STATUS:%d% COMPLETED",completed_percent);
count++;
}
//FORMAT SECOND SIDE
head=1;
count=1;
for(i=0;i<=79;i++)
{
biosdisk(_DISK_FORMAT,drive,head,track+i,sector,no_of_sectors,buffer);
completed_percent=((count*100)/160);
gotoxy(1,13);
printf("STATUS:%d% COMPLETED",completed_percent+50);
count++;
}
puts("\n\nFORMATTING COMPLETED.THE FILE SYSTEM IS RAW");
getch();
}
}