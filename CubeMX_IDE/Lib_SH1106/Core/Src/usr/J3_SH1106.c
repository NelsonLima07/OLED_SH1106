/*
 * J3_SH1106.c
 *
 *  Created on: Apr 29, 2021
 *      Author: Nelson Lima
 */

#include "stdlib.h"
#include "string.h"

#include "usr/J3_SH1106.h"

#define sWidth 128      // screen width
#define sHeight 64      // screen Height
#define sXOffset 2      // x offset

struct TOLED{
  I2C_HandleTypeDef* i2c;
  uint8_t address;
  uint8_t* buffer;
  uint8_t* font;

};

typedef struct TOLED TOLED;

/* Enviar comando para o display */
void j3_sh1106_sendCmd(TOLED* _oled, uint8_t _cmd){
  if (_oled->i2c != NULL){
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
}

/* Enviar dados para o display */
void j3_sh1106_sendDado(TOLED* _oled, uint8_t _dado){
  if (_oled->i2c != NULL){
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
}

/* Retorna i de X e Y */
uint16_t j3_sh1106_getIndexBuffer(uint8_t _x, uint8_t _y){
  return (_y * 128) + _x;
}
/* Retorna X de i */
uint8_t j3_sh1106_getXBuffer(uint16_t _i){
  return (_i % 128);
}
/* Retorna Y de i */
uint8_t j3_sh1106_getYBuffer(uint16_t _i){
  return (_i / 128);
}


/*
uint8_t j3_sh1106_calcByte(TOLED* _oled, uint8_t _x, uint8_t _y){
  uint16_t auxIndex;
  uint8_t page;
  uint8_t resto;
  page = _y / 8;
  auxIndex = j3_sh1106_getIndexBuffer(_x,page);
  resto = _y % 8;
  _oled->buffer[auxIndex]  = _oled->buffer[auxIndex] | (0x01 << resto);
  return _oled->buffer[auxIndex];
}
*/
/*
uint8_t j3_sh1106_calcByteCls(TOLED* _oled, uint8_t _x, uint8_t _y){
  uint16_t auxIndex;
  uint8_t page;
  uint8_t resto;
  page = _y / 8;
  auxIndex = j3_sh1106_getIndexBuffer(_x,page);
  resto = _y % 8;
  _oled->buffer[auxIndex]  = _oled->buffer[auxIndex] & (~(0x01 << resto));             //(0xFE << resto);
  return _oled->buffer[auxIndex];
}
*/



TOLED* J3_SH1106_new(I2C_HandleTypeDef* _i2c, uint8_t _i2c_address){
  TOLED* auxOLED;

  auxOLED = malloc(sizeof(TOLED));
  auxOLED->address = _i2c_address;
  auxOLED->i2c = _i2c;
  auxOLED->buffer = malloc(128 * 8 * sizeof(uint8_t));
  memset(auxOLED->buffer, 0x00, 128 * 8 * sizeof(uint8_t));

  auxOLED->font = NULL;

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

void J3_SH1106_clrDisplay(TOLED* _oled){
  J3_SH1106_offDisplay(_oled);
  for (uint8_t line = 0 ; line <= 7; line++){
    J3_SH1106_cursorY(_oled, line);
	for (uint8_t x = 0 ; x <= 127; x++){
	  J3_SH1106_cursorX(_oled, x);
	  j3_sh1106_sendDado(_oled,0x00);
	}
  }
  J3_SH1106_onDisplay(_oled);
}

void J3_SH1106_clrBuffer(TOLED* _oled){
  memset(_oled->buffer, 0x00, 128 * 8 * sizeof(uint8_t));
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


void J3_SH1106_copyBuffer(TOLED* _oled, TOLED* _oledBuffer){
  for(uint16_t i = 0; i < 1024; i++){
    _oled->buffer[i] = _oledBuffer->buffer[i];
  }
}

void J3_SH1106_plotBuffer(TOLED* _oled){
  for(uint8_t y = 0; y <= 7; y++){
	J3_SH1106_cursorY(_oled, y);
	for(uint8_t x = 0; x <= 127; x++){
	  J3_SH1106_cursorX(_oled, x);
	  j3_sh1106_sendDado(_oled, _oled->buffer[j3_sh1106_getIndexBuffer(x, y)]);
    }
  }
}

void J3_SH1106_fillBuffer(TOLED* _oled, TOLED* _oledBuffer){
  uint16_t i;
  for(uint8_t y = 0; y <= 7; y++){
	for(uint8_t x = 0; x <= 127; x++){
		i = j3_sh1106_getIndexBuffer(x, y);
		if(_oled->buffer[i] != _oledBuffer->buffer[i]){
		  J3_SH1106_cursorXY(_oled, x, y);
		  _oled->buffer[i] = _oledBuffer->buffer[i];
	      j3_sh1106_sendDado(_oled, _oled->buffer[i]);
	  }
    }
  }
}

void J3_SH1106_fillBuffer2(TOLED* _oled, TOLED* _oledBuffer){
  uint8_t y = 0, x = 0;
  for(uint16_t i = 0; i < 1024; i++){
    if(_oled->buffer[i] != _oledBuffer->buffer[i]){
      x = j3_sh1106_getXBuffer(i);
      y = j3_sh1106_getYBuffer(i);
      J3_SH1106_cursorXY(_oled, x, y);
      _oled->buffer[i] = _oledBuffer->buffer[i];
      j3_sh1106_sendDado(_oled, _oled->buffer[i]);
    }
  }
}




void J3_SH1106_cursorX(TOLED* _oled, uint8_t _address){ //Set column address for Page Addressing Mode
  if(_address <= 127){
	_address = _address + sXOffset ;
    j3_sh1106_sendCmd(_oled, 0x10 | (_address>>4)) ; //  shift high 4
    j3_sh1106_sendCmd(_oled, 0x0F & _address) ;      // low 4
  }
}

void J3_SH1106_cursorY(TOLED* _oled, uint8_t _page) { //Set page 0..7 Addressing Mode
  if (_page <= 7){
    j3_sh1106_sendCmd(_oled, 0xB0 | _page);
  }
}


void J3_SH1106_cursorXY(TOLED* _oled, uint8_t x, uint8_t y){ // Position cursor to column, line
  J3_SH1106_cursorY(_oled, y) ; // Y axis = line 0-7
  J3_SH1106_cursorX(_oled, x) ; // X axis = column 0 - (sWidth - 1)
}

void J3_SH1106_cursorLine(TOLED* _oled){
  J3_SH1106_cursorX(_oled, 0);
  for (uint8_t x = 0 ; x <= 127; x++){
	j3_sh1106_sendDado(_oled,0xFF);
  }
}

void J3_SH1106_cursorClsLine(TOLED* _oled){
  J3_SH1106_cursorX(_oled, 0);
  for (uint8_t x = 0 ; x <= 127; x++){
	j3_sh1106_sendDado(_oled,0x00);
  }
}

void J3_SH1106_setPixel(TOLED* _oled,  uint8_t _x, uint8_t _y){
  if ((_x < 128) && (_y < 64)){
    uint8_t page = _y / 8;
    //uint8_t dado;

    uint16_t auxIndex;
    uint8_t resto;

    auxIndex = j3_sh1106_getIndexBuffer(_x,page);
    resto = _y % 8;
    if( _oled->buffer[auxIndex]  != (_oled->buffer[auxIndex] | (0x01 << resto)) ){ /* Verifica se o byte esta diferente no buffer */
      _oled->buffer[auxIndex]  = (_oled->buffer[auxIndex] | (0x01 << resto));
      J3_SH1106_cursorX(_oled, _x);
      J3_SH1106_cursorY(_oled, page);
      j3_sh1106_sendDado(_oled, _oled->buffer[auxIndex]);
    }
  }
}


void J3_SH1106_setClsPixel(TOLED* _oled,  uint8_t _x, uint8_t _y){
  if ((_x < 128) && (_y < 64)){
    uint8_t page = _y / 8;
    //uint8_t dado;
    uint16_t auxIndex;
    uint8_t resto;

    auxIndex = j3_sh1106_getIndexBuffer(_x,page);
    resto = _y % 8;

    if( _oled->buffer[auxIndex]  != (_oled->buffer[auxIndex] & (~(0x01 << resto)) ) ){
      _oled->buffer[auxIndex]  = _oled->buffer[auxIndex] & (~(0x01 << resto));
      J3_SH1106_cursorX(_oled, _x);
      J3_SH1106_cursorY(_oled, page);
      j3_sh1106_sendDado(_oled, _oled->buffer[auxIndex]);
    }
  }
}

void J3_SH1106_setChar(TOLED*_oled, unsigned char _c){

}

void J3_SH1106_clrDisplayByBuffer(TOLED* _oled){
  uint16_t auxIndex;
  for (uint8_t line = 0 ; line <= 7; line++){
	for (uint8_t x = 0 ; x <= 127; x++){
	  auxIndex = j3_sh1106_getIndexBuffer(x,line);
	  if( _oled->buffer[auxIndex] != 0x00){
	    _oled->buffer[auxIndex] = 0x00;
    	J3_SH1106_cursorY(_oled, line);
		J3_SH1106_cursorX(_oled, x);
		j3_sh1106_sendDado(_oled,0x00);
	  }
	}
  }
}

void J3_SH1106_line(TOLED* _oled, uint8_t _x0, uint8_t _y0, uint8_t _x1, uint8_t _y1){
  if (_x0 == _x1 && _y0 == _y1) {
	  J3_SH1106_setPixel(_oled, _x0, _y0);
    return;
  }
  int8_t dx, dy, sx, sy;

  dx = _x1 - _x0;
  sx = (dx < 0) ? -1 : 1;
  dy = _y1 - _y0;
  sy = (dy < 0) ? -1 : 1;

  if (abs(dy) < abs(dx)){
    float m = (float) dy / dx;
    float b = _y0 - m * _x0;

    while (_x0 != _x1){
      J3_SH1106_setPixel(_oled, _x0, (uint8_t)(m * _x0 + b) );
      _x0 += sx;
    }
  }
  else {
    float m = (float) dx / dy;
    float b = _x0 - m * _y0;

    while (_y0 != _y1){
      J3_SH1106_setPixel(_oled, (uint8_t)(m * _y0 + b), _y0);
          _y0 += sy;
    }
  }

  J3_SH1106_setPixel(_oled, _x1, _y1);
}

void J3_SH1106_lineDash(TOLED* _oled, uint8_t _x0, uint8_t _y0, uint8_t _x1, uint8_t _y1){
  if (_x0 == _x1 && _y0 == _y1) {
 	  J3_SH1106_setPixel(_oled, _x0, _y0);
     return;
   }
   int8_t dx, dy, sx, sy;
   int8_t p = 1;

   dx = _x1 - _x0;
   sx = (dx < 0) ? -1 : 1;
   dy = _y1 - _y0;
   sy = (dy < 0) ? -1 : 1;

   if (abs(dy) < abs(dx)){
     float m = (float) dy / dx;
     float b = _y0 - m * _x0;

     while (_x0 != _x1){
       if(p){
         J3_SH1106_setPixel(_oled, _x0, (uint8_t)(m * _x0 + b) );
         p = 0;
       }
       else{
    	 J3_SH1106_setClsPixel(_oled, _x0, (uint8_t)(m * _x0 + b) );
    	 p = 1;
       }

       _x0 += sx;
     }
   }
   else {
     float m = (float) dx / dy;
     float b = _x0 - m * _y0;

     while (_y0 != _y1){
       if(p){
         J3_SH1106_setPixel(_oled, (uint8_t)(m * _y0 + b), _y0);
         p = 0;
       }
       else{
    	 J3_SH1106_setClsPixel(_oled, (uint8_t)(m * _y0 + b), _y0);
    	 p = 1;
       }
       _y0 += sy;
     }
   }

   J3_SH1106_setPixel(_oled, _x1, _y1);
}

void J3_SH1106_plotByteX(TOLED* _oled, uint8_t _x, uint8_t _y, uint8_t _b){
  uint8_t aux = 0x80;

  for(uint8_t i=0; i<=7;i++){
	  if( _b & (aux >> i) )
		J3_SH1106_setPixel(_oled, _x + i, _y);
	  else
		J3_SH1106_setClsPixel(_oled, _x + i, _y);
  }
}

void J3_SH1106_plotByteY(TOLED* _oled, uint8_t _x, uint8_t _y, uint8_t _b){
  uint8_t aux = 0x80;

  for(uint8_t i=0; i<=7;i++){
	  if( _b & (aux >> i) )
		J3_SH1106_setPixel(_oled, _x, _y + i);
	  else
		J3_SH1106_setClsPixel(_oled, _x, _y + i);
  }
}

void J3_SH1106_draw(TOLED* _oled, uint8_t* _draw, uint8_t _x, uint8_t _y, uint8_t _w, uint8_t _h){
  uint16_t tam = _w * _h;
  uint16_t contX = 0;
  uint8_t aux = 0x80;

  for(uint16_t i = 0; i<tam; i++){
	if(_draw[i/8] & (aux >> (i % 8)) ){
	  J3_SH1106_setPixel(_oled, _x + contX, _y);
	}
    else{
    	J3_SH1106_setClsPixel(_oled, _x + contX, _y);
	}
    contX++;
    if(contX == _w){
      _y++;
	  contX = 0;
    }
  }
}

void J3_SH1106_setFont(TOLED* _oled, uint8_t* _font){
  _oled->font = _font;
}


void J3_SH1106_drawString(TOLED* _oled, uint8_t _x, uint8_t _y, char *_text){

}

void J3_SH1106_setBox(TOLED* _oled, uint8_t _x, uint8_t _y, uint8_t _w, uint8_t _h,  uint8_t _fill){
  J3_SH1106_line(_oled, _x, _y, _x + _w, _y);
  J3_SH1106_line(_oled, _x, _y, _x, _y + _h);
  J3_SH1106_line(_oled, _x +_w, _y, _x + _w, _y + _h);
  J3_SH1106_line(_oled, _x, _y + _h, _x + _w, _y + _h);
}






