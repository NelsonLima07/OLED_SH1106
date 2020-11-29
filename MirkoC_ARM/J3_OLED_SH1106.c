#include "font5.h"
#include "J3_OLED_SH1106.h"
#include "string.h"

#define OLED_I2C_ADDRESS    0x78
#define OLED_I2C_ADDRESS_READ    0x7B

unsigned char oled_buffer[128][8];

void sendData(unsigned char dat);

void J3_OLED_clearBuffer(void){
  //memset(oled_buffer, 0, sizeof(oled_buffer));
  unsigned short iY, iX;
  for(iY=0;iY<=7;iY++){
    cursorY(iY);
    for(iX=0;iX<=127;iX++){
      cursorX(iX);
      oled_buffer[iX][iY] = 0x00;
    }
  }
}

unsigned char J3_OLED_putPixelBuffer(unsigned char _x, unsigned char _y){
//  unsigned int index;
  unsigned char auxDado;
  unsigned char auxPage;
  unsigned char auxResto;
  auxPage = _y / 8;
  auxResto = _y % 8;
  auxDado = oled_buffer[_x][auxPage];
  auxDado = auxDado | (0b00000001 << auxResto);
  oled_buffer[_x][auxPage] = auxDado;
  return auxDado;
}

void J3_OLED_setBuffer(void){
  unsigned short iY, iX;
  for(iY=0;iY<=7;iY++){
    cursorY(iY);
    cursorX(0);
    for(iX=0;iX<=127;iX++){
      sendData(oled_buffer[iX][iY]);
    }
  }
}


void sendCmd(unsigned char cmd){
 Soft_I2C_Start();
 Soft_I2C_Write(OLED_I2C_ADDRESS);
 Soft_I2C_Write(0x00);
 Soft_I2C_Write(cmd);
 Soft_I2C_Stop();
}
void sendData(unsigned char dat){
 Soft_I2C_Start();
 Soft_I2C_Write(OLED_I2C_ADDRESS);
 Soft_I2C_Write(0x40);
 Soft_I2C_Write(dat);
 Soft_I2C_Stop();
}


/*
void sendCmd(unsigned char _cmd){
 unsigned char auxDado[2];
 I2C1_Start();
 Delay_ms(10);
 auxDado[0] = 0x00; // Control byte setado para comando;
 auxDado[1] = _cmd; // Comando a ser enviado
// I2C2_Write(OLED_I2C_ADDRESS, auxDado, 1, END_MODE_RESTART);
 I2C1_Write(OLED_I2C_ADDRESS, auxDado, 2, END_MODE_STOP);
}
void sendData(unsigned char _dat){
 unsigned char auxDado[2];
 I2C1_Start();
 Delay_ms(10);
 auxDado[0] = 0x40; // Control byte setado para dado;
 auxDado[1] = _dat; // Dado a ser enviado
// I2C2_Write(OLED_12C_ADDRESS, auxDado, 2, END_MODE_STOP);
// I2C2_Write(OLED_I2C_ADDRESS, 0x40, 1, END_MODE_RESTART);
 I2C1_Write(OLED_I2C_ADDRESS, auxDado, 2, END_MODE_STOP);
}
*/

unsigned char readData(){
 unsigned char aux;
 Soft_I2C_Start();
 Soft_I2C_Write(OLED_I2C_ADDRESS_READ);
 Soft_I2C_Write(0x00);
 aux = Soft_I2C_Read(0);
 Soft_I2C_Stop();
 return aux;
}


void onDisplay(void){
  sendCmd(0xAF) ;                     // turn on OLED panel
}
void offDisplay(void){
  sendCmd(0xAE) ;                     // turn off OLED panel
}
void setContrast(unsigned char contr){// set contrast control register
  sendCmd(0x81);
  sendCmd(contr);
}
void setDisplayLine(void) {
  sendCmd(0x40) ;
}
void setNormal(void){// set
  sendCmd(0xA6);
}
void setReverse(void){// set
  sendCmd(0xA7);
}

void setDisplayClock(void){// set
  sendCmd(0xD5);
  sendCmd(0x00);
}

void cursorY(unsigned char add) { //Set page address for Page Addressing Mode
  sendCmd(0xB0 | add) ;
}

void cursorX(unsigned char add){ //Set column adress for Page Addressing Mode
  add = add+sXOffset ;
  sendCmd(0x10 | (add>>4)) ; //  shift high 4
  sendCmd(0x0F & add) ;      // low 4
}
void cursorXY(unsigned char x, unsigned char y){ // Position cursor to column, line
  cursorY(y) ; // Y axis = line 0-7
  cursorX(x) ; // X axis = column 0 - (sWidth - 1)
}
void clLnDisplay(unsigned char yline){ // Clear single line 0-7 on display, cursor to line start
  unsigned char ram ;
  cursorXY(0, yline)    ;            // Cursor Home
  for (ram=sWidth ; ram>0 ; ram--)   // sWidth DDRAM addresses in each line
  { sendData(0); }                   // clear RAM
  cursorXY(0, yline) ;               // Cursor Home
}
void clsDisplay(void){ // Erase the entire display DDRAM and set cursor home (0,0)
  unsigned char line;
  offDisplay() ;                      // turn off OLED panel
  for (line = 8 ; line > 0 ; line--)  // 8 lines of Display DDRAM
  { clLnDisplay(8 - line) ; }         // erase each in turn, home cursor to line
  onDisplay() ;                       // turn on OLED panel
}

void setPixelXY(unsigned char _x, unsigned char _y){
  unsigned char auxPage;
  unsigned char auxDado;
  auxPage = _y / 8;
  cursorX(_x);
  cursorY(auxPage);
  auxDado = J3_OLED_putPixelBuffer(_x, _y);
  sendData(auxDado);
}

void rptPix(unsigned char pix, unsigned char blank, unsigned char percent){ // repeat pixel across Display for percent - show bar graph
  unsigned char count ;
  int width ;
  width = (sWidth*percent)/100 ; // screen width x fill level
  for (count=0; count<sWidth; count++)  // loop for width
  {
   if ((count <= width)||(count > (sWidth - 2)))
   {  sendData(pix) ; }  // send 'pix' glyph to display
   else
   {  sendData(blank) ;} // send 'blank' glyph to display
  }
}

void barDisplay(unsigned char barG){// water bargraph on line 7
  cursorXY(0, 7) ;
  rptPix(0b11111111, 0b10000001, barG);  // Draw line, then blanks
}
void sendGlyphs(const unsigned char *pRow, unsigned char size){ //Send any font row to print character
  unsigned char count ;
  for (count = 0 ; count < size ; count++)  // Send row to print the character
  {
    sendData(pRow[count]);
  }
  sendData(0x00);  // 1 pixel horizontal space after character
}
void charFont5(unsigned char character){ // MODIFY IF FONT RANGE CHANGED
 // Prepare to write byte to Font5, via sendGlyphs
  if (character == ' ')  // munge ' ' to empty ';' character
   { character = ';' ; }
  //if ((character<'.')||(character>'Z')) // reduced font5 table, CAPS only
   //{ return ; }    // Exit function if character out of ASCII range
  //Index to row of the character in font5 table, then send glyphs
  sendGlyphs(font5[character - '.'], sizeof font5[0]);
}

void strFont5(unsigned char s[])
{ // Write Variable or Contatant string to Font5
  while(*s) {charFont5(*s++);} // Points to character, or terminator
}