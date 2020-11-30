#line 1 "C:/NelsonLima/Eletronica/Componentes/OLED_SH1106.git/trunk/MirkoC_ARM/Exemplo/main_OLED_SH1106.c"
#line 1 "c:/nelsonlima/eletronica/componentes/oled_sh1106.git/trunk/mirkoc_arm/exemplo/../j3_oled_sh1106.h"










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



 void J3_OLED_clearBuffer(void);


unsigned char J3_OLED_putPixelBuffer(unsigned char _x, unsigned char _y);


void J3_OLED_lineHBuffer(unsigned char _y);


void J3_OLED_lineVBuffer(unsigned char _x);



void J3_OLED_rectangleBuffer(unsigned char _x1, unsigned char _y1, unsigned char _x2, unsigned char _y2);


unsigned char J3_OLED_putCharBuffer(unsigned char character);


void J3_OLED_setBuffer(void);


void charFont5(unsigned char character);
void strFont5(unsigned char s[]);
#line 4 "C:/NelsonLima/Eletronica/Componentes/OLED_SH1106.git/trunk/MirkoC_ARM/Exemplo/main_OLED_SH1106.c"
sbit Soft_I2C_Scl_Output at GPIOB_ODR.B8;
sbit Soft_I2C_Scl_Input at GPIOB_IDR.B8;
sbit Soft_I2C_Sda_Output at GPIOB_ODR.B9;
sbit Soft_I2C_Sda_Input at GPIOB_IDR.B9;


void main() {
 unsigned char auxX = 0;
 unsigned char auxY = 0;

 GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_13);

 Soft_I2C_Init();

 Delay_ms(1000);
 J3_OLED_offDisplay();
 J3_OLED_clsDisplay();
 J3_OLED_setNormal();
 J3_OLED_setContrast(255);
 J3_OLED_onDisplay();
 J3_OLED_setDisplayClock();

 while(1){
 GPIOC_ODR.B13 = 1;
 Delay_ms(10);
 GPIOC_ODR.B13 = 0;
 Delay_ms(10);
#line 56 "C:/NelsonLima/Eletronica/Componentes/OLED_SH1106.git/trunk/MirkoC_ARM/Exemplo/main_OLED_SH1106.c"
 J3_OLED_clearBuffer();

 J3_OLED_lineHBuffer(0);
 J3_OLED_lineHBuffer(63);

 J3_OLED_lineVBuffer(0);
 J3_OLED_lineVBuffer(127);

 J3_OLED_rectangleBuffer(auxX,5,auxX+30,10);

 J3_OLED_rectangleBuffer(30,11,50,20);


 J3_OLED_setBuffer();

 auxX++;
 if(auxX+30 >= 128)
 {
 auxX = 0;
 }

 }
}
