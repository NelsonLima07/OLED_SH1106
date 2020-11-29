_main:
;main_OLED_SH1106.c,10 :: 		void main() {
;main_OLED_SH1106.c,11 :: 		unsigned char auxX = 0;
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
;main_OLED_SH1106.c,19 :: 		offDisplay();
BL	_offDisplay+0
;main_OLED_SH1106.c,20 :: 		clsDisplay();
BL	_clsDisplay+0
;main_OLED_SH1106.c,21 :: 		setNormal();
BL	_setNormal+0
;main_OLED_SH1106.c,22 :: 		setContrast(255);
MOVS	R0, #255
BL	_setContrast+0
;main_OLED_SH1106.c,23 :: 		onDisplay();
BL	_onDisplay+0
;main_OLED_SH1106.c,24 :: 		setDisplayClock();
BL	_setDisplayClock+0
;main_OLED_SH1106.c,26 :: 		while(1){
L_main2:
;main_OLED_SH1106.c,27 :: 		GPIOC_ODR.B13 = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
_SX	[R0, ByteOffset(GPIOC_ODR+0)]
;main_OLED_SH1106.c,28 :: 		Delay_ms(1000);
MOVW	R7, #45225
MOVT	R7, #40
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
;main_OLED_SH1106.c,30 :: 		Delay_ms(1000);
MOVW	R7, #45225
MOVT	R7, #40
NOP
NOP
L_main6:
SUBS	R7, R7, #1
BNE	L_main6
NOP
NOP
;main_OLED_SH1106.c,31 :: 		cursorXY(0,0);
MOVS	R1, #0
MOVS	R0, #0
BL	_cursorXY+0
;main_OLED_SH1106.c,32 :: 		strFont5("Nelson Lima! Teste.");
MOVW	R0, #lo_addr(?lstr1_main_OLED_SH1106+0)
MOVT	R0, #hi_addr(?lstr1_main_OLED_SH1106+0)
BL	_strFont5+0
;main_OLED_SH1106.c,33 :: 		continue;
IT	AL
BAL	L_main2
;main_OLED_SH1106.c,71 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
