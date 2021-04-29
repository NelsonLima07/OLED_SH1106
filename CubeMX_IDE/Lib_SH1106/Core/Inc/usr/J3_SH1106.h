/*
 * J3_SH1106.h
 *
 *  Created on: Apr 29, 2021
 *      Author: Nelson Lima
 */

#ifndef INC_J3_SH1106_H_
#define INC_J3_SH1106_H_

//#include "main.h"
#include "i2c.h"

typedef struct TOLED TOLED;

TOLED* J3_SH1106_new(I2C_HandleTypeDef* _i2c, uint8_t _i2c_address); /* Retorna um ponteiro para um um OLED */

void J3_SH1106_onDisplay(TOLED* _oled);
void J3_SH1106_offDisplay(TOLED* _oled);
void J3_SH1106_setContrast(TOLED* _oled, uint8_t _valContraste);
void J3_SH1106_clsDisplay(TOLED* _oled);
void J3_SH1106_clsDisplay2(TOLED* _oled);
void J3_SH1106_setDisplayLine(TOLED* _oled);
void J3_SH1106_setNormal(TOLED* _oled);
void J3_SH1106_setReverse(TOLED* _oled);
void J3_SH1106_setDisplayClock(TOLED* _oled);

void J3_SH1106_cursorY(TOLED* _oled, uint8_t add);
void J3_SH1106_cursorX(TOLED* _oled, uint8_t add);
void J3_SH1106_setPixel(TOLED* _oled,  uint8_t x, uint8_t y); /* Set pixel na tela */
void J3_SH1106_setPixel2(TOLED* _oled,  uint8_t x, uint8_t y);


#endif /* INC_J3_SH1106_H_ */
