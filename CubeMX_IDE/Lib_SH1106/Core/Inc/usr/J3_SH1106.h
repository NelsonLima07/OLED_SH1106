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

void J3_SH1106_onDisplay(TOLED* _oled);  /* Liga o display */
void J3_SH1106_offDisplay(TOLED* _oled); /* Desliga o display */
void J3_SH1106_setContrast(TOLED* _oled, uint8_t _valContraste); /* Set o valor de contraste. Maior mais branco */
void J3_SH1106_clrDisplay(TOLED* _oled); /* Limpa o todas as posições do display. Não limpa o buffer */
void J3_SH1106_clrBuffer(TOLED* _oled); /* Limpa o todas as posições do buffer. Não limpa o display */
void J3_SH1106_clrDisplayBuffer(TOLED* _oled); /* Limpa o display e o buffer  */
void J3_SH1106_clrDisplayByBuffer(TOLED* _oled); /* Limpa o display e o buffer baseado no buffer so limpa o q precisar */

void J3_SH1106_setNormal(TOLED* _oled); /* Fundo escuro e pixel branco */
void J3_SH1106_setReverse(TOLED* _oled); /* Fundo branco e pixel preto */
void J3_SH1106_setDisplayClock(TOLED* _oled); /* Frequencia do display */

void J3_SH1106_copyBuffer(TOLED* _oled, TOLED* _oledBuffer); /* Somente copia o buffer */
void J3_SH1106_plotBuffer(TOLED* _oled); /* Plotar o buffer no display */
void J3_SH1106_fillBuffer(TOLED* _oled, TOLED* _oledBuffer); /* Copia o buffer e plota no display   */
void J3_SH1106_fillBuffer2(TOLED* _oled, TOLED* _oledBuffer); /* Copia o buffer e plota no display otimizado */



void J3_SH1106_cursorX(TOLED* _oled, uint8_t add);
void J3_SH1106_cursorY(TOLED* _oled, uint8_t add);
void J3_SH1106_cursorXY(TOLED* _oled, uint8_t x, uint8_t y);
void J3_SH1106_cursorLine(TOLED* _oled);
void J3_SH1106_cursorClsLine(TOLED* _oled);

void J3_SH1106_setPixel(TOLED* _oled,  uint8_t _x, uint8_t _y);    /* Set pixel na tela */
void J3_SH1106_setClsPixel(TOLED* _oled,  uint8_t _x, uint8_t _y); /* Limpa pixel na tela */
void J3_SH1106_clsDisplay2(TOLED* _oled); /* Limpa o display somente onde houver "sujeira" */
void J3_SH1106_line(TOLED* _oled, uint8_t _x0, uint8_t _y0, uint8_t _x1, uint8_t _y1);
void J3_SH1106_lineDash(TOLED* _oled, uint8_t _x0, uint8_t _y0, uint8_t _x1, uint8_t _y1);

void J3_SH1106_plotByteX(TOLED* _oled, uint8_t _x, uint8_t _y, uint8_t _b); /* Desenha o byte com orientacao horizontal */
void J3_SH1106_plotByteY(TOLED* _oled, uint8_t _x, uint8_t _y, uint8_t _b); /* Desenha o byte com orientacao vertical */
void J3_SH1106_draw(TOLED* _oled, uint8_t* _draw, uint8_t _x, uint8_t _y, uint8_t _w, uint8_t _h); /* Desenha uma imagem */

void J3_SH1106_setFont(TOLED* _oled, uint8_t* _font); /* Define uma font */
void J3_SH1106_drawString(TOLED* _oled, uint8_t _x, uint8_t _y, char *_text); /* Escreve um texto */


void J3_SH1106_setBox(TOLED* _oled, uint8_t _x, uint8_t _y, uint8_t _w, uint8_t _h,  uint8_t _fill); /* Desenha uma caixa */




#endif /* INC_J3_SH1106_H_ */
