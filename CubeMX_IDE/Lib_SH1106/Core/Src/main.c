/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2021 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "i2c.h"
#include "gpio.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include <stdlib.h>
#include <usr/J3_SH1106.h>
/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */
//------------------------------------------------------------------------------
// File generated by LCD Assistant
// http://en.radzio.dxp.pl/bitmap_converter/
//------------------------------------------------------------------------------

const uint8_t pong [] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x3F, 0xFF, 0xF0, 0x00, 0x1F, 0xFF, 0x80, 0x07, 0xFC, 0x07, 0xFE, 0x00, 0x1F, 0xFF, 0xF8, 0x00,
	0x7F, 0xFF, 0xF0, 0x00, 0x1F, 0xFF, 0x80, 0x0F, 0xFC, 0x07, 0xFF, 0x00, 0x3F, 0xFF, 0xF8, 0x00,
	0x40, 0x00, 0x10, 0x00, 0x10, 0x00, 0x00, 0x08, 0x00, 0x04, 0x01, 0x00, 0x20, 0x00, 0x08, 0x00,
	0x4F, 0xFF, 0xD0, 0x00, 0x17, 0xFE, 0x00, 0x09, 0xF0, 0x04, 0xF9, 0x00, 0x2F, 0xFF, 0xE8, 0x00,
	0x4F, 0xFF, 0xD0, 0x00, 0x17, 0xFE, 0x00, 0x09, 0xF0, 0x04, 0xF9, 0x00, 0x2F, 0xFF, 0xE8, 0x00,
	0x4F, 0xC0, 0xCF, 0x01, 0xF6, 0x06, 0x7C, 0x09, 0xF3, 0xE4, 0xF9, 0x03, 0xEC, 0x00, 0x08, 0x00,
	0x4F, 0xDE, 0xC1, 0x01, 0x06, 0xF6, 0x04, 0x09, 0xF0, 0x24, 0xF9, 0x02, 0x0C, 0xFF, 0xF8, 0x00,
	0x4F, 0xDE, 0xFD, 0x01, 0x7E, 0xF3, 0xE4, 0x09, 0xFF, 0xA4, 0xF9, 0x02, 0xFC, 0x80, 0x00, 0x00,
	0x4F, 0xDE, 0xFD, 0x01, 0x7E, 0xF3, 0xE4, 0x09, 0xFF, 0xA4, 0xF9, 0x02, 0xFC, 0x80, 0x00, 0x00,
	0x4F, 0xDE, 0xE1, 0x01, 0x7E, 0xF3, 0xE4, 0x09, 0xFF, 0xBC, 0xF9, 0x02, 0xFC, 0x9F, 0xF8, 0x00,
	0x4F, 0xC0, 0xDF, 0x01, 0x7E, 0xF3, 0xE4, 0x09, 0xFF, 0x81, 0xF9, 0x02, 0xFC, 0xB0, 0x08, 0x00,
	0x4F, 0xF3, 0xD0, 0x01, 0x7E, 0xF3, 0xE4, 0x09, 0xFF, 0xE7, 0xF9, 0x02, 0xFC, 0xB0, 0x08, 0x00,
	0x4F, 0xFF, 0xD0, 0x01, 0x7E, 0xF3, 0xE4, 0x09, 0xFF, 0xFF, 0xF9, 0x02, 0xFC, 0xB7, 0xE8, 0x00,
	0x4F, 0xFF, 0xD0, 0x01, 0x7E, 0xF3, 0xE4, 0x09, 0xFF, 0xFF, 0xF9, 0x02, 0xFC, 0xB7, 0xE8, 0x00,
	0x4F, 0xDF, 0xF0, 0x01, 0x7E, 0xF3, 0xE4, 0x09, 0xF3, 0xDF, 0xF9, 0x02, 0xFC, 0xB7, 0xE8, 0x00,
	0x4F, 0xD0, 0x00, 0x01, 0x7E, 0xF3, 0xE4, 0x09, 0xF0, 0x5F, 0xF9, 0x02, 0xFC, 0xB7, 0xE8, 0x00,
	0x4F, 0xD0, 0x00, 0x01, 0x7E, 0xF3, 0xE4, 0x09, 0xF0, 0x5F, 0xF9, 0x02, 0xFC, 0xB7, 0xE8, 0x00,
	0x4F, 0xD0, 0x00, 0x01, 0x7E, 0xF3, 0xE4, 0x09, 0xF0, 0x5F, 0xF9, 0x02, 0xFC, 0xB7, 0xE8, 0x00,
	0x4F, 0xD0, 0x00, 0x01, 0x06, 0xF6, 0x04, 0x09, 0xF0, 0x41, 0xF9, 0x02, 0x0C, 0xF6, 0x18, 0x00,
	0x4F, 0xD0, 0x00, 0x00, 0xF7, 0x0E, 0x78, 0x09, 0xF0, 0x3C, 0xF9, 0x01, 0xE7, 0x0E, 0xF0, 0x00,
	0x4F, 0xD0, 0x00, 0x00, 0x17, 0xFE, 0x00, 0x09, 0xF0, 0x04, 0xF9, 0x00, 0x6F, 0xFE, 0x80, 0x00,
	0x4F, 0xD0, 0x00, 0x00, 0x17, 0xFE, 0x00, 0x09, 0xF0, 0x04, 0xF9, 0x00, 0x2F, 0xFE, 0x80, 0x00,
	0x40, 0x10, 0x00, 0x00, 0x10, 0x00, 0x00, 0x08, 0x00, 0x04, 0x01, 0x00, 0x20, 0x00, 0x80, 0x00,
	0x3F, 0xE0, 0x00, 0x00, 0x1F, 0xFF, 0x80, 0x07, 0xFC, 0x07, 0xFE, 0x00, 0x1F, 0xFF, 0x80, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	};





/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */
void desenhaBola(TOLED* _oled, uint8_t _x, uint8_t _y);
void desenhaPlay(TOLED* _oled, uint8_t _x, uint8_t _y);


/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{
  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_I2C2_Init();
  /* USER CODE BEGIN 2 */

  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  TOLED* oled;
  TOLED* oledBuffer;

  oled = J3_SH1106_new(&hi2c2,0x78);
  oledBuffer = J3_SH1106_new(NULL,0x00);

  J3_SH1106_offDisplay(oled);
  J3_SH1106_setNormal(oled);
  J3_SH1106_setContrast(oled,255);
  //J3_SH1106_onDisplay(oled);
  J3_SH1106_setDisplayClock(oled);
  J3_SH1106_clrDisplay(oled);

  uint8_t x = 1;
  uint8_t y = 31;
  uint16_t cont = 0;

  uint8_t play1_x = 4;
  uint8_t play1_y = 30;

  uint8_t play2_x = 127-4;
  uint8_t play2_y = 30;


 // J3_SH1106_setBox(oled, 4,10,4,12,0);

 // J3_SH1106_setBox(oled, 120,10,4,12,0);


//  J3_SH1106_draw(oled, (uint8_t *)estrela, 10,10,48,48);
//  HAL_Delay(3000);
//  J3_SH1106_draw(oled, (uint8_t *)mario, 0,0,128,40);
//  HAL_Delay(3000);


  // J3_SH1106_setReverse(oled); /* Fundo branco e pixel preto */
 // HAL_Delay(3000);
 // J3_SH1106_setNormal(oled);

  //J3_SH1106_setPixel(oled,127,0);
  //J3_SH1106_setPixel(oled,127,63);
 // desenhaBola(oled,1,3);
  //HAL_Delay(2000);
  //apagaBola(oled,1,3);

  uint8_t bolaX = 63;
  uint8_t bolaY = 3;
  int8_t bolaX_vel = 2;
  int8_t bolaY_vel = 3;

  J3_SH1106_draw(oled, (uint8_t *)pong, 0,0,128,32);
  HAL_Delay(5000);
  J3_SH1106_clrDisplayByBuffer(oled);


  while (1)
  {
    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */

	//J3_SH1106_clrDisplay(oled);
	J3_SH1106_clrBuffer(oledBuffer);


	J3_SH1106_setBox(oledBuffer, 0,0,127,63,0);
	J3_SH1106_lineDash(oledBuffer, 63,0,63,127);
	J3_SH1106_lineDash(oledBuffer, 64,0,64,127);


	desenhaBola(oledBuffer, bolaX, bolaY);
	desenhaPlay(oledBuffer, play1_x, play1_y);
	desenhaPlay(oledBuffer, play2_x, play2_y);

	J3_SH1106_fillBuffer2(oled, oledBuffer);
	HAL_Delay(30);

	bolaX = bolaX + bolaX_vel;
	bolaY = bolaY + bolaY_vel;

	if(bolaX >= 120){
	  if(bolaY >= (play2_y-5) && bolaY <= (play2_y+5)){
	    bolaX_vel = bolaX_vel * (-1);
	    bolaY_vel = bolaY_vel * (-1);
	  }
	}else if(bolaX >= 124){
	  bolaX = 64;
	  bolaX_vel = 1;
    }

	if(bolaX <= 7){
	  if(bolaY >= (play1_y-5) && bolaY <= (play1_y+5)){
	    bolaX_vel = bolaX_vel * (-1);
	    bolaY_vel = bolaY_vel * (-1);
	  }
	}else if (bolaX <= 3){
	   bolaX = 63;
	   bolaX_vel = 1;
	}

	if(bolaY >= 61){
	  bolaY = 61;
	  bolaY_vel = bolaY_vel * (-1);
	}
	if(bolaY <= 2){
	  bolaY = 2;
	  bolaY_vel = bolaY_vel * (-1);
	}



  }
  /* USER CODE END 3 */
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL9;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }
  /** Initializes the CPU, AHB and APB buses clocks
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2) != HAL_OK)
  {
    Error_Handler();
  }
}

/* USER CODE BEGIN 4 */
void desenhaBola(TOLED* _oled, uint8_t _x, uint8_t _y){
  J3_SH1106_setPixel(_oled,_x-1,_y-1);
  J3_SH1106_setPixel(_oled,_x-1,_y);
  J3_SH1106_setPixel(_oled,_x-1,_y+1);

  J3_SH1106_setPixel(_oled,_x,_y-1);
  J3_SH1106_setPixel(_oled,_x,_y);
  J3_SH1106_setPixel(_oled,_x,_y+1);

  J3_SH1106_setPixel(_oled,_x+1,_y-1);
  J3_SH1106_setPixel(_oled,_x+1,_y);
  J3_SH1106_setPixel(_oled,_x+1,_y+1);
}

void desenhaPlay(TOLED* _oled, uint8_t _x, uint8_t _y){
  const play_altura = 5;
  const play_largura = 1;
  J3_SH1106_line(_oled, _x-play_largura,_y-play_altura,_x+play_largura,_y-play_altura);
  J3_SH1106_line(_oled, _x-play_largura,_y-play_altura,_x-play_largura,_y+play_altura);
  J3_SH1106_line(_oled, _x-play_largura,_y+play_altura,_x+play_largura,_y+play_altura);
  J3_SH1106_line(_oled, _x+play_largura,_y+play_altura,_x+play_largura,_y-play_altura);
}



/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  __disable_irq();
  while (1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
