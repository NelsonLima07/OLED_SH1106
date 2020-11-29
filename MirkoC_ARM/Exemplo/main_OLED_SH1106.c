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

   //clsDisplay();
//   setPixelXY(0,0);
//   setPixelXY(1,1);
//   setPixelXY(2,2);
//   setPixelXY(3,3);

    J3_OLED_clearBuffer();
   //setPixelXY(0,0);
    for(auxX=0;auxX<=127;auxX++){
      J3_OLED_putPixelBuffer(auxX,0);
      J3_OLED_putPixelBuffer(auxX,63);
    }
    for(auxY=0;auxY<=63;auxY++){
      J3_OLED_putPixelBuffer(0,auxY);
      J3_OLED_putPixelBuffer(127,auxY);
    }
    //offDisplay();
    J3_OLED_setBuffer();
    
    for(auxX=0;auxX<=127;auxX++){
      J3_OLED_putPixelBuffer(auxX,1);
      J3_OLED_putPixelBuffer(auxX,62);
    }
    for(auxY=0;auxY<=63;auxY++){
      J3_OLED_putPixelBuffer(1,auxY);
      J3_OLED_putPixelBuffer(126,auxY);
    }
    
    //offDisplay();
    J3_OLED_setBuffer();


    //onDisplay();

    //onDisplay();
  }// fim do while principal
}