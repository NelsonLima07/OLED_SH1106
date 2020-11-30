_main:
;main_OLED_SH1106.c,10 :: 		void main() {
SUB	SP, SP, #4
;main_OLED_SH1106.c,11 :: 		unsigned char auxX = 0;
MOVS	R0, #0
STRB	R0, [SP, #0]
;main_OLED_SH1106.c,12 :: 		unsigned char auxY = 0;
;main_OLED_SH1106.c,14 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_13);    // LED da placa
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;main_OLED_SH1106.c,16 :: 		Soft_I2C_Init();
BL	_Soft_I2C_Init+0
;main_OLED_SH1106.c,18 :: 		Delay_ms(1000);
MOVW	R7, #45225
MOVT	R7, #40
NOP
NOP
L_main0:
SUBS	R7, R7, #1
BNE	L_main0
NOP
NOP
;main_OLED_SH1106.c,19 :: 		J3_OLED_offDisplay();
BL	_J3_OLED_offDisplay+0
;main_OLED_SH1106.c,20 :: 		J3_OLED_clsDisplay();
BL	_J3_OLED_clsDisplay+0
;main_OLED_SH1106.c,21 :: 		J3_OLED_setNormal();
BL	_J3_OLED_setNormal+0
;main_OLED_SH1106.c,22 :: 		J3_OLED_setContrast(255);
MOVS	R0, #255
BL	_J3_OLED_setContrast+0
;main_OLED_SH1106.c,23 :: 		J3_OLED_onDisplay();
BL	_J3_OLED_onDisplay+0
;main_OLED_SH1106.c,24 :: 		J3_OLED_setDisplayClock();
BL	_J3_OLED_setDisplayClock+0
;main_OLED_SH1106.c,26 :: 		while(1){
L_main2:
;main_OLED_SH1106.c,27 :: 		GPIOC_ODR.B13 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;main_OLED_SH1106.c,28 :: 		Delay_ms(10);
MOVW	R7, #26665
MOVT	R7, #0
NOP
NOP
L_main4:
SUBS	R7, R7, #1
BNE	L_main4
NOP
NOP
;main_OLED_SH1106.c,29 :: 		GPIOC_ODR.B13 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;main_OLED_SH1106.c,30 :: 		Delay_ms(10);
MOVW	R7, #26665
MOVT	R7, #0
NOP
NOP
L_main6:
SUBS	R7, R7, #1
BNE	L_main6
NOP
NOP
;main_OLED_SH1106.c,56 :: 		J3_OLED_clearBuffer();
BL	_J3_OLED_clearBuffer+0
;main_OLED_SH1106.c,58 :: 		J3_OLED_lineHBuffer(0);
MOVS	R0, #0
BL	_J3_OLED_lineHBuffer+0
;main_OLED_SH1106.c,59 :: 		J3_OLED_lineHBuffer(63);
MOVS	R0, #63
BL	_J3_OLED_lineHBuffer+0
;main_OLED_SH1106.c,61 :: 		J3_OLED_lineVBuffer(0);
MOVS	R0, #0
BL	_J3_OLED_lineVBuffer+0
;main_OLED_SH1106.c,62 :: 		J3_OLED_lineVBuffer(127);
MOVS	R0, #127
BL	_J3_OLED_lineVBuffer+0
;main_OLED_SH1106.c,64 :: 		J3_OLED_rectangleBuffer(auxX,5,auxX+30,10);
LDRB	R0, [SP, #0]
ADDS	R0, #30
MOVS	R3, #10
UXTB	R2, R0
MOVS	R1, #5
LDRB	R0, [SP, #0]
BL	_J3_OLED_rectangleBuffer+0
;main_OLED_SH1106.c,66 :: 		J3_OLED_rectangleBuffer(30,11,50,20);
MOVS	R3, #20
MOVS	R2, #50
MOVS	R1, #11
MOVS	R0, #30
BL	_J3_OLED_rectangleBuffer+0
;main_OLED_SH1106.c,69 :: 		J3_OLED_setBuffer();
BL	_J3_OLED_setBuffer+0
;main_OLED_SH1106.c,71 :: 		auxX++;
LDRB	R0, [SP, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [SP, #0]
;main_OLED_SH1106.c,72 :: 		if(auxX+30 >= 128)
ADDS	R0, #30
SXTH	R0, R0
CMP	R0, #128
IT	LT
BLT	L_main8
;main_OLED_SH1106.c,74 :: 		auxX = 0;
MOVS	R0, #0
STRB	R0, [SP, #0]
;main_OLED_SH1106.c,75 :: 		}
L_main8:
;main_OLED_SH1106.c,77 :: 		}// fim do while principal
IT	AL
BAL	L_main2
;main_OLED_SH1106.c,78 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
