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

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */
void desenhaBola(TOLED* _oled, uint8_t _x, uint8_t _y);
void apagaBola(TOLED* _oled, uint8_t _x, uint8_t _y);
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
  oled = J3_SH1106_new(&hi2c2,0x78);

  J3_SH1106_offDisplay(oled);
  J3_SH1106_clsDisplay(oled);
  J3_SH1106_setNormal(oled);
  J3_SH1106_setContrast(oled,255);
  J3_SH1106_onDisplay(oled);
  J3_SH1106_setDisplayClock(oled);

  uint8_t x = 1;
  uint8_t y = 31;
  uint16_t cont = 0;

  while (1)
  {
    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
	  //J3_SH1106_offDisplay(oled);
	  //J3_SH1106_clsDisplay2(oled);

      desenhaBola(oled,x,y);
      //J3_SH1106_setContrast(oled,255);
      HAL_Delay(55);
      //J3_SH1106_setContrast(oled,0);
      //J3_SH1106_clsDisplay2(oled);
      apagaBola(oled,x,y);

      if (cont == 0){
    	x++;
      }else{
        x--;
      }

      if(x==126){
        cont=1;
      }
      if(x==1){
    	cont=0;
      }


	  //if (cont > 2000){
	//	cont = 0;
	//	HAL_Delay(500);
	//  }


	  //cont++;
	  //J3_SH1106_onDisplay(oled);
	  //HAL_Delay(5);
	  //J3_SH1106_setPixel(oled,x,y);
	  /*
	  x++;
	  if(x>127){
		  y++;
		  x=0;
	  }
	  if(y>63){
	   y=0;
	   J3_SH1106_clsDisplay(oled);
	  }
      */



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

void apagaBola(TOLED* _oled, uint8_t _x, uint8_t _y){
  J3_SH1106_setClsPixel(_oled,_x-1,_y-1);
  J3_SH1106_setClsPixel(_oled,_x-1,_y);
  J3_SH1106_setClsPixel(_oled,_x-1,_y+1);

  J3_SH1106_setClsPixel(_oled,_x,_y-1);
  J3_SH1106_setClsPixel(_oled,_x,_y);
  J3_SH1106_setClsPixel(_oled,_x,_y+1);

  J3_SH1106_setClsPixel(_oled,_x+1,_y-1);
  J3_SH1106_setClsPixel(_oled,_x+1,_y);
  J3_SH1106_setClsPixel(_oled,_x+1,_y+1);
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
