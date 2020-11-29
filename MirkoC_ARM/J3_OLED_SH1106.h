#define sWidth 128      // screen width
#define sHeight 64      // screen Height
#define sXOffset 2      // x offset


// Funcoes Internas
//void sendCmd(unsigned char);     // write a command to display
//void sendData(unsigned char) ;   // write data to display

// Funcoes de controles gerais
void onDisplay(void);
void offDisplay(void);
void setDisplayLine(void);
void setContrast(unsigned char contr);
void setNormal(void);
void setReverse(void);
void clsDisplay(void);
void setDisplayClock(void);
void cursorX(unsigned char add);
void cursorY(unsigned char add);
void cursorXY(unsigned char _x, unsigned char _y);
void setPixelXY(unsigned char x, unsigned char y);

/* Graficas */
/* Limpa o buffer */
 void J3_OLED_clearBuffer(void);

/* Plota uma pixel no buffer; Retorna o byte para ser enviado pra memoria RAM  do display */
unsigned char J3_OLED_putPixelBuffer(unsigned char _x, unsigned char _y);

/*Transfere o buffer para a RAM */
void J3_OLED_setBuffer(void);


void charFont5(unsigned char character);
void strFont5(unsigned char s[]);