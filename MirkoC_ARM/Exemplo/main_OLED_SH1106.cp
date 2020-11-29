#line 1 "C:/NelsonLima/Eletronica/Componentes/OLED_SH1106/MirkoC_ARM/Exemplo/main_OLED_SH1106.c"
#line 1 "c:/nelsonlima/eletronica/componentes/oled_sh1106/mirkoc_arm/exemplo/../j3_oled_sh1106.h"










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



 void J3_OLED_clearBuffer(void);


unsigned char J3_OLED_putPixelBuffer(unsigned char _x, unsigned char _y);


void J3_OLED_setBuffer(void);


void charFont5(unsigned char character);
void strFont5(unsigned char s[]);
#line 4 "C:/NelsonLima/Eletronica/Componentes/OLED_SH1106/MirkoC_ARM/Exemplo/main_OLED_SH1106.c"
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
 offDisplay();
 clsDisplay();
 setNormal();
 setContrast(255);
 onDisplay();
 setDisplayClock();

 while(1){
 GPIOC_ODR.B13 = 1;
 Delay_ms(1000);
 GPIOC_ODR.B13 = 0;
 Delay_ms(1000);
 cursorXY(0,0);
 strFont5("Nelson Lima! Teste.");
 continue;







 J3_OLED_clearBuffer();

 for(auxX=0;auxX<=127;auxX++){
 J3_OLED_putPixelBuffer(auxX,0);
 J3_OLED_putPixelBuffer(auxX,63);
 }
 for(auxY=0;auxY<=63;auxY++){
 J3_OLED_putPixelBuffer(0,auxY);
 J3_OLED_putPixelBuffer(127,auxY);
 }

 J3_OLED_setBuffer();

 for(auxX=0;auxX<=127;auxX++){
 J3_OLED_putPixelBuffer(auxX,1);
 J3_OLED_putPixelBuffer(auxX,62);
 }
 for(auxY=0;auxY<=63;auxY++){
 J3_OLED_putPixelBuffer(1,auxY);
 J3_OLED_putPixelBuffer(126,auxY);
 }


 J3_OLED_setBuffer();





 }
}
