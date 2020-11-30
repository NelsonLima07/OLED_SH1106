#include "..\J3_OLED_SH1106.h"


sbit Soft_I2C_Scl_Output   at GPIOB_ODR.B8;
sbit Soft_I2C_Scl_Input    at GPIOB_IDR.B8;
sbit Soft_I2C_Sda_Output   at GPIOB_ODR.B9;
sbit Soft_I2C_Sda_Input    at GPIOB_IDR.B9;


void main() {
  unsigned char auxX = 0;
  unsigned char auxY = 0;
   
  GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_13);    // LED da placa

  Soft_I2C_Init();
  //I2C1_Init_Advanced(400000, &_GPIO_MODULE_I2C1_PB89);
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
/*
    J3_OLED_cursorXY(0,0);
    strFont5("Linha 0");

    J3_OLED_cursorXY(0,1);
    strFont5("Linha 1");

    J3_OLED_cursorXY(0,2);
    strFont5("Linha 2");

    J3_OLED_cursorXY(0,3);
    strFont5("Linha 3");

    J3_OLED_cursorXY(0,4);
    strFont5("Linha 4");

    J3_OLED_cursorXY(0,5);
    strFont5("Linha 5");

    J3_OLED_cursorXY(0,6);
    strFont5("Linha 6");

    J3_OLED_cursorXY(0,7);
    strFont5("Linha 7");
     */
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

  }// fim do while principal
}