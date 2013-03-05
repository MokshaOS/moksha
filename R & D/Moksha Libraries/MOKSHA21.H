#ifndef MOKSHA21_H
#define MOKSHA21_H
void putchar(char character)
{
out.h.ah=0x09;//INTERRUPT FUNCTION FOR DISPLAYING ASCII CHARACTERS
	      //BITWISE
in.x.dx=character;
int86(0x21,&in,&out);
}
void lfeed()
{
in.x.dx=0x0A;//LINE FEED[ENTER KEY OPERATION-CARRIAGE RETURN]
int86(0x21,&in,&out);
}
void creturn()
{
in.x.dx=0x0D;//CARRIAGE RETURN[SET CURSOR TO STARTING OF
	     //THE CURRENT ROW
int86(0x21,&in,&out);
}
void spacebar()
{
out.h.ah=0x09;
in.x.dx=0x00;//SPACEBAR HEX VALUE=00H
int86(0x21,&in,&out);
}
void backspace()
{
out.h.ah=0x09;
in.x.dx=0x08;//BACKSPACE HEX VALUE=08H
int86(0x21,&in,&out);
}
void beep()
{
out.h.ah=0x09;
in.x.dx=0x07;//BEEP HEX VALUE=07H
int86(0x21,&in,&out);
}
void hold()
{
in.h.ah=0x08;
int86(0x21,&in,&out);
}
void print(int size,char string[])
{
int loop;
out.h.ah=0x02;//FUNCTION FOR DISPLAYING
in.x.cx=size;//SIZE OF THE STRING
in.x.di=(char)&string;//ADDRESS OF THE STRING
for(loop=0;loop<=size;loop++)
{
in.h.dl=string[loop];//DISPLAY STRING
int86(0x21,&in,&out);//INT 21H
}
}
int remove(char pathname[])
{
int size=0;
int loop;
in.h.ah=0x41;//REMOVE/DELETE FILE FUNCTION
for(loop=0;loop<=size;loop++)
{
in.x.dx=(unsigned int)&pathname[loop];
int86(0x21,&in,&out);//INT 21H
}
return out.x.ax;
//ON SUCCESS CLEARS THE CARRY FLAG
//ON ERROR RETURN 03 OR 05 TO AX
}
int getattrib(char pathname[])
{
int size=0;
int loop;
int getattribute=00;
in.h.ah=0x43;//FUNCTION FOR GETIING THE ATTRIBUTES OF A FILE
in.h.al=getattribute;
for(loop=0;loop<=size;loop++)
{
in.x.dx=(unsigned int)&pathname[loop];
int86(0x21,&in,&out);//INT 21H
}
return out.h.cl;
/*BIT     ATTRIBUTE
   0      Read-only File
   1      Hidden File
   2      System File
   3      Volume Label
   4      Subdirectory
   5      Archive File

ON SUCCESS IT CLEARS THE CARRY FLAG,CLEARS CH
AND RETURNS THE CURRENT FILE ATTRIBUTE TO CL

ON ERROR RETURNS 02 0R 03 TO AX
*/
}
int setattrib(char pathname[],int mode)
{
int size=0;
int loop;
in.h.ah=0x43;//SET FILE ATTRIBUTE FUNCTION
in.h.al=01;
in.x.cx=mode;
for(loop=0;loop<=size;loop++)
{
in.x.dx=(unsigned int)&pathname[loop];
int86(0x21,&in,&out);//INT 21H
}
//ON SUCCESS IT CLEARS THE CARRY FLAG
//ON ERROR RETURNS 02,03 OR 05 TO AX
return out.x.ax;
}
int searchfile(char pathname[],int attribute)
{
int size=0;
int loop;
in.h.ah=0x4E;
in.x.cx=attribute;
for(loop=0;loop<=size;loop++)
{
in.x.dx=(unsigned int)&pathname[loop];
int86(0x21,&in,&out);//INT 21H
}
return out.x.ax;
/*ON SUCCESS IT CLEARS THE CARRY FLAG AND FILLS DTA[DISK TRANSFER ADDRESS],
  43-BYTE(2BH) WITH THE FOLLOWING SPECIFICATIONS:-

/* FILEDATA   TYPE     BYTE             FUNCTION
	      char     reserved[21];    RESERVED FOR SUBSIQUENT SEARCH
   FILEATT    char     attrib;          FILE ATTRIBUTE FOR MATCHED FILE
   FILETIME   unsigned wr_time;         FILE TIME OF LAST WRITE TO FILE
   FILEDATE   unsigned wr_date;         FILE DATE OF LAST WRITE TO FILE
   FILE SIZE  long     size;            SIZE OF FILE IN BYTES
   ASCII NAME char     name[13];        ASCII NAME OF THE MATCHED FILE

ON ERROR SETS THE CARRY FLAG AND RETURNS 02,03 OR 12H TO AX
*/
}
int continuetosearch()
{
in.h.ah=0x4F;
int86(0x21,&in,&out);//INT 21H
return out.x.ax;
}
int rename(char oldfile[],char newfile[])
{
/*
oldfile=OLD NAME OF THE EXISTING FILE WHICH HAS TO BE RENAMED
newfile=NEW NAME OF THE EXISTING FILE WHICH HAS TO BE RENAMED
*/
int loop,size=0;//DECLARE VARIABLES
in.h.ah=0x56;//FUNCTION FOR RENAMING FILE/DIRECTORY
for(loop=0;loop<=size;loop++)//START LOOP FOR STRING HANDLING
{
in.x.dx=(unsigned int)&oldfile[loop];
int86(0x21,&in,&out);//EXECUTE INT 21H
}
for(loop=0;loop<=size;loop++)
{
in.x.di=(unsigned int)&newfile[loop];
int86(0x21,&in,&out);//EXECUTE INT 21H
}
int86(0x21,&in,&out);//EXECUTE INT 21H
return out.x.ax;
//ON SUCCESS IT CLEARS THE CARRY FLAG ANS SETS IT TO ZERO
//ON ERROR IT RETURNS 02,03,05 OR 11H AND SETS CARRY FLAG TO 1
}
void createfile(char pathname[],int attribute,char record[])
{
//pathname=IS THE FILE PATH
//record  =IS THE FILE DATA TO BE WRIITEN INTO VARIABLE pathname
	   //i.e. INTO THE SPECIFIED OR ENTERED FILE PATH
int loop;//LOOP VARIABLE
int size=0;//SET VALUE OF SIZE=0[FOR STRING HANDLING]
int filehandle;//SAVES THE FILEHANDLE OF THE SPECIFIED FILE FOR WRITING
	       // RECORD.IT IS A MAX 4 BYTE[32 BIT] VALUE OR DUAL WORD.
in.h.ah=0x3C;//FUNCTION FOR CREATING A FILE
in.x.cx=attribute;//STORE THE ATTRIBUTE IN CX REGISTER[16 BIT]
for(loop=0;loop<=size;loop++)//FOR STRING OPEATION
{
in.x.dx=(unsigned int)&pathname[loop];//STORE THE STARTING ADDRESS
/*VALUE OF IP IS INCREMENTED AT MEMORY LEVEL FOR THE ARRAY
THE ARRAY IS ALWAYS STORED IN CONTINUOUS MEMORY LOCATIONS
THEREFORE THE STRING IS ACCEPTED AND STORED IN DX[16 BIT] OR
2 BYTE REGISTER.
*/
int86(0x21,&in,&out);//EXECUTE INT 21H
}
/*ON SUCCESS IT CLEARS THE CARRY FLAG TO 0 AND SYSTEM CREATES A DIRECTORY
  ENTRY WITH THE SPECIFIED ATTRIBUTE AND RETURNS THE HANDLE IN AX.

  ON ERROR IT SETS THE CARRY FLAG TO 1 AND RESTURNS 03,04 OR 05.
  05 MEANS THAT EITHER THE DIRECTORY IS FULL OR THE REFERENCED FILENAME
  HAS THE READ-ONLY ATTRIBUTE.

   MODE          ATTRIB                   EXTRA ATTRIBUTES
    0            NORMAL FILE              EVERY FEATURE ENABLED
    1		 READ ONLY FILE           READ ONLY CHECKED,CAN BE HIDDEN
    2            HIDDEN FILE              READ ONLY ENABLED
    3		 READ ONLY & HIDDEN FILE  READ ONLY AND HIDDEN ENABLED
    4            ARCHIVING SYSTEM FILE    HIDDEN FEATURE IS DISABLED
    5            READ ONLY SYSTEM FILE    HIDDEN FEATURE IS DISABLED
*/
//START RECORD WRITING OPERATION
filehandle=out.x.ax;//STORE FILEHANDLE IN VARIABLE filehandle
/*out.x.ax HAS THE FILEHANDLE STORED IN IT FROM THE LAST RECORD
WRITING DISK OPEARTION WHICH HAD OCCURED JUST BEFORE THIS OPERATION
OF RECORD WRITING.*/
in.h.ah=0x40;//FUNCTION FOR CREATING A RECORD
in.x.bx=filehandle;/*STORE THE FILEHANDLE IN BX REGISTER
HERE  BX REGISTER HAS BEEN USED FOR EXTENDED ADDRESSING
BX OR BASE ADDRESS REGISTER IS A 16 BIT OR 2 BYTE REGISTER.
*/
/*
THE LOOP MAX VALUE IS MAXLEN-1 TO SET THE FILE POINTER TO THE
LAST ASCII CHARACTER SINCE THE ARRAY STATRS FROM 0 DUE TO ZERO
BASED INDEXING.
*/
for(loop=0;loop<=strlen(record)-1;loop++)//MAX LEN=(STRLEN -1)
/*strlen() FUNCTION IS DECLARED IN STRING.H AND GIVES THE MAXIMUM LENGTH
OF THE STRING*/
{
in.x.dx=(unsigned int)&record[loop];//WRITE RECORD
/*dx OR DATA SEGMENT REGISTER IS A 16 BIT OR 2 BYTES REGISTER
FOR HANDLING THE DATA*/
int86(0x21,&in,&out);//EXECUTE INT 21H
}
//START FILE CLOSING OPERATION
in.h.ah=0X3E;
in.x.bx=filehandle;
int86(0x21,&in,&out);
//FILE CLOSED
/*
A SUCCESSFUL CLOSE OPERATION CLOSES THE FILE AND CLEARS REMAINING RECORDS IN
THE BUFFER[FLUSH OPEARTION] AND UPDATES THE FAT[FILE ALLOCATION TABLE] AND
DIRECTORY WITH ATTRIBUTES WITH THE FOLLOWING DPB.

   FILEDATA   TYPE     BYTE             FUNCTION
   FILE SIZE  long     size;            SIZE OF FILE IN BYTES
   ASCII NAME char     name[13];        ASCII NAME OF THE MATCHED FILE

ON ERROR SETS THE CARRY FLAG AND RETURNS 06 IN AX i.e
THE ERROR CODE FOR INVALID HANDLE.
*/
}
int closefile(int filehandle)
{
in.h.ah=0X3E;
in.x.bx=filehandle;
int86(0x21,&in,&out);
return out.x.ax;
/*
ON ERROR SETS THE CARRY FLAG AND RETURNS 06 IN AX i.e
THE ERROR CODE FOR INVALID HANDLE.
*/
}
void resetdisk()
{
in.h.ah=0x0D;//RESET DISK FUNCTION
in.h.dl=0x80;
int86(0x13,&in,&out);//INT 21H
//# 1:ALL BUFFERS CLEARED
//# 2:DISK RESETTED TO CYLINDER 0
}
void setdisk(int driveno)
{
in.h.ah=0x0E;//SET CURRENT DISK/DRIVE FUNCTION
in.h.dl=driveno;//LOAD DRIVENO INTO dl REGISTER
int86(0x21,&in,&out);//INT 21H
}
void chkdskon()
{
in.h.ah=0x2E;
in.h.al=01;
int86(0x21,&in,&out);
//IT INITIATES CYCLICAL REDUNDANCY CHECK(CRC) TO ON STATE
}
void chkdskoff()
{
in.h.ah=0x2E;
in.h.al=00;
int86(0x21,&in,&out);
//IT INITIATES CYCLICAL REDUNDANCY CHECK(CRC) TO OFF STATE
}
double bytespersector(int driveno)
{
in.h.ah=0x36;
in.h.dl=driveno;
int86(0x21,&in,&out);
return out.x.cx;
}
double totalclusters(int driveno)
{
in.h.ah=0x36;
in.h.dl=driveno;
int86(0x21,&in,&out);
return out.x.dx;
}
double sectorspercluster(int driveno)
{
in.h.ah=0x36;
in.h.dl=driveno;
int86(0x21,&in,&out);
return out.x.ax;
}
double availableclusters(int driveno)
{
in.h.ah=0x36;
in.h.dl=driveno;
int86(0x21,&in,&out);
return out.x.bx;
}

/////////////////////////////INT 21H FUNCTIONS////////////////////////////////
#endif