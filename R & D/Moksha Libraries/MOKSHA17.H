//////////////////////////--- DEFINIG PRINTER INTERFACE ---///////////////////
#ifndef MOKSHA17_H
#define MOKSHA17_H
////////////////////////////// PRINTER FUNCTION /////////////////////////////
  void printchar(char ch)
  {
   in.h.ah=0x00;   // Request to print
   in.h.al=ch;     // charecter to be printed
   in.x.dx=0x00;   // selection of port of printer
   int86(0x17,&in,&out);   // interrupt service call
  }
  void initprinterport()
  {
   in.h.ah=0x01;   // Request to initialize port
   in.x.dx=0x00;   // selection of port of printer
   int86(0x17,&in,&out);   // interrupt service call
  }
  void printerstatus()
  {
   in.h.ah=0x02;   // Request to initialize printer port
   in.x.dx=0x00;   // selection of port of printer
   int86(0x17,&in,&out);   // interrupt service call
  }
  void dosprint(char ch)
  {
  in.h.ah=0x05;
  in.h.dl=ch;
  int86(0x21,&in,&out);
  }
#endif
//////////////////////////// END OF PRINTER_H ////////////////////////////////