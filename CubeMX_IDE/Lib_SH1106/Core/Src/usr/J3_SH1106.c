/*
 * J3_SH1106.c
 *
 *  Created on: Apr 29, 2021
 *      Author: Nelson Lima
 */

#include "stdlib.h"

#include "usr/J3_SH1106.h"

#define sWidth 128      // screen width
#define sHeight 64      // screen Height
#define sXOffset 2      // x offset

struct TOLED{
  I2C_HandleTypeDef* i2c;
  uint8_t address;
  uint8_t* buffer;
};

typedef struct TOLED TOLED;

void j3_sh1106_sendCmd(TOLED* _oled, uint8_t _cmd){
  HAL_StatusTypeDef ret;
  uint8_t buf[2];

  buf[0] = 0x00;
  buf[1] = _cmd;
  ret = HAL_I2C_Master_Transmit(_oled->i2c, _oled->address, buf, 2, HAL_MAX_DELAY);
  if (ret == HAL_OK) {
  }
  else {
  }
}

void j3_sh1106_sendDado(TOLED* _oled, uint8_t _dado){
  HAL_StatusTypeDef ret;
  uint8_t buf[2];

  buf[0] = 0x40;
  buf[1] = _dado;
  ret = HAL_I2C_Master_Transmit(_oled->i2c, _oled->address, buf, 2, HAL_MAX_DELAY);
  if (ret == HAL_OK) {
  }
  else {
  }
}

TOLED* J3_SH1106_new(I2C_HandleTypeDef* _i2c, uint8_t _i2c_address){
  TOLED* auxOLED;

  auxOLED = malloc(sizeof(TOLED));
  auxOLED->address = _i2c_address;
  auxOLED->i2c = _i2c;
  auxOLED->buffer = malloc(128 * 8 * sizeof(uiny8_t));
  return auxOLED;
}

void J3_SH1106_onDisplay(TOLED* _oled){
  j3_sh1106_sendCmd(_oled,0xAF);                     // turn on OLED panel
}

void J3_SH1106_offDisplay(TOLED* _oled){
  j3_sh1106_sendCmd(_oled,0xAE) ;                     // turn off OLED panel
}

void J3_SH1106_setContrast(TOLED* _oled, uint8_t _valContraste){// set contrast control register
  j3_sh1106_sendCmd(_oled,0x81);
  j3_sh1106_sendCmd(_oled,_valContraste);
}

void J3_SH1106_setDisplayLine(TOLED* _oled) {
  j3_sh1106_sendCmd(_oled, 0x40) ;
}

void J3_SH1106_setNormal(TOLED* _oled){// set
  j3_sh1106_sendCmd(_oled, 0xA6);
}

void J3_SH1106_setReverse(TOLED* _oled){// set
  j3_sh1106_sendCmd(_oled, 0xA7);
}

void J3_SH1106_setDisplayClock(TOLED* _oled){// set
  j3_sh1106_sendCmd(_oled, 0xD5);
  //j3_sh1106_sendCmd(_oled, 0xF0);
  j3_sh1106_sendCmd(_oled, 0x00);
}


void J3_SH1106_cursorY(TOLED* _oled, uint8_t _page) { //Set page 0..7 Addressing Mode
  if (_page <= 7){
    j3_sh1106_sendCmd(_oled, 0xB0 | _page);
  }
}

void J3_SH1106_cursorX(TOLED* _oled, uint8_t _address){ //Set column address for Page Addressing Mode
  if(_address <= 127){
	_address = _address + sXOffset ;
    j3_sh1106_sendCmd(_oled, 0x10 | (_address>>4)) ; //  shift high 4
    j3_sh1106_sendCmd(_oled, 0x0F & _address) ;      // low 4
  }
}

void J3_SH1106_cursorXY(TOLED* _oled, uint8_t x, uint8_t y){ // Position cursor to column, line
  J3_SH1106_cursorY(_oled, y) ; // Y axis = line 0-7
  J3_SH1106_cursorX(_oled, x) ; // X axis = column 0 - (sWidth - 1)
}

void J3_SH1106_clLnDisplay(TOLED* _oled, uint8_t yline){ // Clear single line 0-7 on display, cursor to line start
  uint8_t ram ;
  J3_SH1106_cursorXY(_oled, 0, yline)    ;            // Cursor Home
  for (ram=sWidth ; ram>0 ; ram--)   // sWidth DDRAM addresses in each line
  { j3_sh1106_sendDado(_oled, 0); }                   // clear RAM
  J3_SH1106_cursorXY(_oled, 0, yline) ;               // Cursor Home
}

void J3_SH1106_clsDisplay(TOLED* _oled){ // Erase the entire display DDRAM and set cursor home (0,0)
  uint8_t line;
  J3_SH1106_offDisplay(_oled);                      // turn off OLED panel
  for (line = 8 ; line > 0 ; line--)  // 8 lines of Display DDRAM
  { J3_SH1106_clLnDisplay(_oled, 8 - line) ; }         // erase each in turn, home cursor to line
  J3_SH1106_onDisplay(_oled);                       // turn on OLED panel
}

void J3_SH1106_clsDisplay2(TOLED* _oled){ // Erase the entire display DDRAM and set cursor home (0,0)
  //J3_SH1106_offDisplay(_oled);
  for (uint8_t line = 0 ; line <= 7; line++){
    J3_SH1106_cursorY(_oled, line);
    J3_SH1106_cursorX(_oled, 0);
	for (uint8_t x = 0 ; x <= 127; x++){
	  j3_sh1106_sendDado(_oled,0);
	}
  }
}

void J3_SH1106_setPixel(TOLED* _oled,  uint8_t _x, uint8_t _y){
  J3_SH1106_cursorX(_oled, _x);
  J3_SH1106_cursorY(_oled, _y);
  j3_sh1106_sendDado(_oled, 0xFF);
}
void J3_SH1106_setPixel2(TOLED* _oled,  uint8_t _x, uint8_t _y){
  J3_SH1106_cursorX(_oled, _x);
  J3_SH1106_cursorY(_oled, _y);
  j3_sh1106_sendDado(_oled, 0x00);
}

void J3_SH1106_writeBuffer(TOLED* _oled){
  for(uint8_t y = 0; y < 7; y++){
	J3_SH1106_cursorY(_oled, _y);
	J3_SH1106_cursorX(_oled, 0);
	for(uint8_t x = 0; x < 127; x++){
	  j3_sh1106_sendDado(_oled, _oled->buffer[y*x]);
    }
  }
}


