#define sWidth 128      // screen width
#define sHeight 64      // screen Height
#define sXOffset 2      // x offset


// Funcoes Internas
//void sendCmd(unsigned char);     // write a command to display
//void sendData(unsigned char) ;   // write data to display

// Funcoes de controles gerais
void J3_OLED_onDisplay(void);
void J3_OLED_offDisplay(void);
void J3_OLED_setDisplayLine(void);
void J3_OLED_setContrast(unsigned char contr);
void J3_OLED_setNormal(void);
void J3_OLED_setReverse(void);
void J3_OLED_clsDisplay(void);
void J3_OLED_setDisplayClock(void);
void J3_OLED_cursorX(unsigned char add);
void J3_OLED_cursorY(unsigned char add);
void J3_OLED_cursorXY(unsigned char _x, unsigned char _y);
void J3_OLED_setPixelXY(unsigned char x, unsigned char y);

/* Graficas */
/* Limpa o buffer */
 void J3_OLED_clearBuffer(void);

/* Plota uma pixel no buffer; Retorna o byte para ser enviado pra memoria RAM  do display */
unsigned char J3_OLED_putPixelBuffer(unsigned char _x, unsigned char _y);
/* Desenha uma linha na Horizontal */
/* y <= 0 ate 63;                  */
void J3_OLED_lineHBuffer(unsigned char _y);
/* Desenha uma linha na Vertical   */
/* x <= 0 ate 127;                  */
void J3_OLED_lineVBuffer(unsigned char _x);

/* Desenha um retangulo */
/* x1 tem que ser menor q x2 e idem parao y1 */
void J3_OLED_rectangleBuffer(unsigned char _x1, unsigned char _y1, unsigned char _x2, unsigned char _y2);

/* Escreve uma char font5 no Buffer */
unsigned char J3_OLED_putCharBuffer(unsigned char character);

/*Transfere o buffer para a RAM */
void J3_OLED_setBuffer(void);


void charFont5(unsigned char character);
void strFont5(unsigned char s[]);