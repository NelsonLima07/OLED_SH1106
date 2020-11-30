#include "font5.h"
#include "J3_OLED_SH1106.h"

#define OLED_I2C_ADDRESS    0x78

unsigned char oled_buffer[128][8];     /* Buffer */
unsigned char cursorX;                 /* Armazena o cursor X */
unsigned char cursorY;                 /* Armazena o cursos Y */

/* Funcoes internas  */
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

/* Ler da mem. RAM */ // Ainda nao está funcionando
unsigned char readData(){
 unsigned char aux;
 Soft_I2C_Start();
 Soft_I2C_Write(OLED_I2C_ADDRESS);
 Soft_I2C_Write(0x00);
 aux = Soft_I2C_Read(0);
 Soft_I2C_Stop();
 return aux;
}

/* Teste com porta de hardware */
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
/*----------------------------------------*/


void J3_OLED_clearBuffer(void){
  unsigned short iY, iX;
  for(iY=0;iY<=7;iY++){
    J3_OLED_cursorY(iY);
    for(iX=0;iX<=127;iX++){
      J3_OLED_cursorX(iX);
      oled_buffer[iX][iY] = 0x00;
    }
  }
}

unsigned char J3_OLED_putPixelBuffer(unsigned char _x, unsigned char _y){
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

void J3_OLED_lineHBuffer(unsigned char _y){
  unsigned short iX;
  unsigned char auxDado;
  unsigned char auxPage;
  unsigned char auxResto;
  auxPage = _y / 8;
  auxResto = _y % 8;
  for(iX=0; iX<=127; iX++){
    auxDado = oled_buffer[iX][auxPage];
    auxDado = auxDado | (0b00000001 << auxResto);
    oled_buffer[iX][auxPage] = auxDado;
  }
}

void J3_OLED_lineVBuffer(unsigned char _x){
  unsigned short iY;
  for(iY=0; iY<=63; iY++){
    J3_OLED_putPixelBuffer(_x,iY);
  }
}

void J3_OLED_rectangleBuffer(unsigned char _x1, unsigned char _y1, unsigned char _x2, unsigned char _y2){
  unsigned short iX;
  unsigned short iY;
  for(iY=_y1; iY<=_y2; iY++){
    J3_OLED_putPixelBuffer(_x1,iY);
    J3_OLED_putPixelBuffer(_x2,iY);
  }
  for(iX=_x1; iX<=_x2; iX++){
    J3_OLED_putPixelBuffer(iX,_y1);
    J3_OLED_putPixelBuffer(iX,_y2);
  }
}

void J3_OLED_setBuffer(void){
  unsigned short iY, iX;
  for(iY=0;iY<=7;iY++){
    J3_OLED_cursorY(iY);
    J3_OLED_cursorX(0);
    for(iX=0;iX<=127;iX++){
      sendData(oled_buffer[iX][iY]);
    }
  }
}

void J3_OLED_onDisplay(void){
  sendCmd(0xAF) ;                     // turn on OLED panel
}
void J3_OLED_offDisplay(void){
  sendCmd(0xAE) ;                     // turn off OLED panel
}
void J3_OLED_setContrast(unsigned char contr){// set contrast control register
  sendCmd(0x81);
  sendCmd(contr);
}
void J3_OLED_setDisplayLine(void) {
  sendCmd(0x40) ;
}
void J3_OLED_setNormal(void){// set
  sendCmd(0xA6);
}
void J3_OLED_setReverse(void){// set
  sendCmd(0xA7);
}

void J3_OLED_setDisplayClock(void){// set
  sendCmd(0xD5);
  sendCmd(0x00);
}

void J3_OLED_cursorY(unsigned char add) { //Set page address for Page Addressing Mode
  sendCmd(0xB0 | add) ;
}

void J3_OLED_cursorX(unsigned char add){ //Set column adress for Page Addressing Mode
  add = add+sXOffset ;
  sendCmd(0x10 | (add>>4)) ; //  shift high 4
  sendCmd(0x0F & add) ;      // low 4
}
void J3_OLED_cursorXY(unsigned char x, unsigned char y){ // Position cursor to column, line
  J3_OLED_cursorY(y) ; // Y axis = line 0-7
  J3_OLED_cursorX(x) ; // X axis = column 0 - (sWidth - 1)
}
void J3_OLED_clLnDisplay(unsigned char yline){ // Clear single line 0-7 on display, cursor to line start
  unsigned char ram ;
  J3_OLED_cursorXY(0, yline)    ;            // Cursor Home
  for (ram=sWidth ; ram>0 ; ram--)   // sWidth DDRAM addresses in each line
  { sendData(0); }                   // clear RAM
  J3_OLED_cursorXY(0, yline) ;               // Cursor Home
}
void J3_OLED_clsDisplay(void){ // Erase the entire display DDRAM and set cursor home (0,0)
  unsigned char line;
  J3_OLED_offDisplay() ;                      // turn off OLED panel
  for (line = 8 ; line > 0 ; line--)  // 8 lines of Display DDRAM
  { J3_OLED_clLnDisplay(8 - line) ; }         // erase each in turn, home cursor to line
  J3_OLED_onDisplay() ;                       // turn on OLED panel
}

void J3_OLED_setPixelXY(unsigned char _x, unsigned char _y){
  unsigned char auxPage;
  unsigned char auxDado;
  auxPage = _y / 8;
  J3_OLED_cursorX(_x);
  J3_OLED_cursorY(auxPage);
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
  J3_OLED_cursorXY(0, 7) ;
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