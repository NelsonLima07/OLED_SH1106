_sendCmd:
;J3_OLED_SH1106.c,11 :: 		void sendCmd(unsigned char cmd){
; cmd start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
; cmd end address is: 0 (R0)
; cmd start address is: 16 (R4)
;J3_OLED_SH1106.c,12 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;J3_OLED_SH1106.c,13 :: 		Soft_I2C_Write(OLED_I2C_ADDRESS);
MOVS	R0, #120
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,14 :: 		Soft_I2C_Write(0x00);
MOVS	R0, #0
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,15 :: 		Soft_I2C_Write(cmd);
UXTB	R0, R4
; cmd end address is: 16 (R4)
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,16 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;J3_OLED_SH1106.c,17 :: 		}
L_end_sendCmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _sendCmd
_sendData:
;J3_OLED_SH1106.c,18 :: 		void sendData(unsigned char dat){
; dat start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
; dat end address is: 0 (R0)
; dat start address is: 16 (R4)
;J3_OLED_SH1106.c,19 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;J3_OLED_SH1106.c,20 :: 		Soft_I2C_Write(OLED_I2C_ADDRESS);
MOVS	R0, #120
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,21 :: 		Soft_I2C_Write(0x40);
MOVS	R0, #64
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,22 :: 		Soft_I2C_Write(dat);
UXTB	R0, R4
; dat end address is: 16 (R4)
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,23 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;J3_OLED_SH1106.c,24 :: 		}
L_end_sendData:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _sendData
_readData:
;J3_OLED_SH1106.c,27 :: 		unsigned char readData(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,29 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;J3_OLED_SH1106.c,30 :: 		Soft_I2C_Write(OLED_I2C_ADDRESS);
MOVS	R0, #120
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,31 :: 		Soft_I2C_Write(0x00);
MOVS	R0, #0
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,32 :: 		aux = Soft_I2C_Read(0);
MOVS	R0, #0
BL	_Soft_I2C_Read+0
; aux start address is: 8 (R2)
UXTB	R2, R0
;J3_OLED_SH1106.c,33 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;J3_OLED_SH1106.c,34 :: 		return aux;
UXTB	R0, R2
; aux end address is: 8 (R2)
;J3_OLED_SH1106.c,35 :: 		}
L_end_readData:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _readData
_J3_OLED_clearBuffer:
;J3_OLED_SH1106.c,62 :: 		void J3_OLED_clearBuffer(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,64 :: 		for(iY=0;iY<=7;iY++){
; iY start address is: 32 (R8)
MOVW	R8, #0
; iY end address is: 32 (R8)
L_J3_OLED_clearBuffer0:
; iY start address is: 32 (R8)
CMP	R8, #7
IT	HI
BHI	L_J3_OLED_clearBuffer1
;J3_OLED_SH1106.c,65 :: 		J3_OLED_cursorY(iY);
UXTB	R0, R8
BL	_J3_OLED_cursorY+0
;J3_OLED_SH1106.c,66 :: 		for(iX=0;iX<=127;iX++){
; iX start address is: 24 (R6)
MOVS	R6, #0
; iX end address is: 24 (R6)
; iY end address is: 32 (R8)
L_J3_OLED_clearBuffer3:
; iX start address is: 24 (R6)
; iY start address is: 32 (R8)
CMP	R6, #127
IT	HI
BHI	L_J3_OLED_clearBuffer4
;J3_OLED_SH1106.c,67 :: 		J3_OLED_cursorX(iX);
UXTB	R0, R6
BL	_J3_OLED_cursorX+0
;J3_OLED_SH1106.c,68 :: 		oled_buffer[iX][iY] = 0x00;
LSLS	R1, R6, #3
MOVW	R0, #lo_addr(_oled_buffer+0)
MOVT	R0, #hi_addr(_oled_buffer+0)
ADDS	R0, R0, R1
ADD	R1, R0, R8, LSL #0
MOVS	R0, #0
STRB	R0, [R1, #0]
;J3_OLED_SH1106.c,66 :: 		for(iX=0;iX<=127;iX++){
ADDS	R6, R6, #1
UXTB	R6, R6
;J3_OLED_SH1106.c,69 :: 		}
; iX end address is: 24 (R6)
IT	AL
BAL	L_J3_OLED_clearBuffer3
L_J3_OLED_clearBuffer4:
;J3_OLED_SH1106.c,64 :: 		for(iY=0;iY<=7;iY++){
ADD	R8, R8, #1
UXTB	R8, R8
;J3_OLED_SH1106.c,70 :: 		}
; iY end address is: 32 (R8)
IT	AL
BAL	L_J3_OLED_clearBuffer0
L_J3_OLED_clearBuffer1:
;J3_OLED_SH1106.c,71 :: 		}
L_end_J3_OLED_clearBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_clearBuffer
_J3_OLED_putPixelBuffer:
;J3_OLED_SH1106.c,73 :: 		unsigned char J3_OLED_putPixelBuffer(unsigned char _x, unsigned char _y){
; _y start address is: 4 (R1)
; _x start address is: 0 (R0)
; _y end address is: 4 (R1)
; _x end address is: 0 (R0)
; _x start address is: 0 (R0)
; _y start address is: 4 (R1)
;J3_OLED_SH1106.c,77 :: 		auxPage = _y / 8;
LSRS	R4, R1, #3
UXTB	R4, R4
;J3_OLED_SH1106.c,78 :: 		auxResto = _y % 8;
AND	R5, R1, #7
UXTB	R5, R5
; _y end address is: 4 (R1)
;J3_OLED_SH1106.c,79 :: 		auxDado = oled_buffer[_x][auxPage];
LSLS	R3, R0, #3
; _x end address is: 0 (R0)
MOVW	R2, #lo_addr(_oled_buffer+0)
MOVT	R2, #hi_addr(_oled_buffer+0)
ADDS	R2, R2, R3
ADDS	R4, R2, R4
LDRB	R3, [R4, #0]
;J3_OLED_SH1106.c,80 :: 		auxDado = auxDado | (0b00000001 << auxResto);
MOVS	R2, #1
SXTH	R2, R2
LSLS	R2, R5
SXTH	R2, R2
ORR	R2, R3, R2, LSL #0
; auxDado start address is: 0 (R0)
UXTB	R0, R2
;J3_OLED_SH1106.c,81 :: 		oled_buffer[_x][auxPage] = auxDado;
UXTB	R2, R2
STRB	R2, [R4, #0]
;J3_OLED_SH1106.c,82 :: 		return auxDado;
; auxDado end address is: 0 (R0)
;J3_OLED_SH1106.c,83 :: 		}
L_end_J3_OLED_putPixelBuffer:
BX	LR
; end of _J3_OLED_putPixelBuffer
_J3_OLED_lineHBuffer:
;J3_OLED_SH1106.c,85 :: 		void J3_OLED_lineHBuffer(unsigned char _y){
; _y start address is: 0 (R0)
; _y end address is: 0 (R0)
; _y start address is: 0 (R0)
;J3_OLED_SH1106.c,90 :: 		auxPage = _y / 8;
LSRS	R4, R0, #3
UXTB	R4, R4
; auxPage start address is: 16 (R4)
;J3_OLED_SH1106.c,91 :: 		auxResto = _y % 8;
AND	R0, R0, #7
UXTB	R0, R0
; _y end address is: 0 (R0)
; auxResto start address is: 0 (R0)
;J3_OLED_SH1106.c,92 :: 		for(iX=0; iX<=127; iX++){
; iX start address is: 20 (R5)
MOVS	R5, #0
; iX end address is: 20 (R5)
L_J3_OLED_lineHBuffer6:
; iX start address is: 20 (R5)
; auxResto start address is: 0 (R0)
; auxResto end address is: 0 (R0)
; auxPage start address is: 16 (R4)
; auxPage end address is: 16 (R4)
CMP	R5, #127
IT	HI
BHI	L_J3_OLED_lineHBuffer7
; auxResto end address is: 0 (R0)
; auxPage end address is: 16 (R4)
;J3_OLED_SH1106.c,93 :: 		auxDado = oled_buffer[iX][auxPage];
; auxPage start address is: 16 (R4)
; auxResto start address is: 0 (R0)
LSLS	R2, R5, #3
MOVW	R1, #lo_addr(_oled_buffer+0)
MOVT	R1, #hi_addr(_oled_buffer+0)
ADDS	R1, R1, R2
ADDS	R3, R1, R4
LDRB	R2, [R3, #0]
;J3_OLED_SH1106.c,94 :: 		auxDado = auxDado | (0b00000001 << auxResto);
MOVS	R1, #1
SXTH	R1, R1
LSLS	R1, R0
SXTH	R1, R1
ORR	R1, R2, R1, LSL #0
;J3_OLED_SH1106.c,95 :: 		oled_buffer[iX][auxPage] = auxDado;
UXTB	R1, R1
STRB	R1, [R3, #0]
;J3_OLED_SH1106.c,92 :: 		for(iX=0; iX<=127; iX++){
ADDS	R5, R5, #1
UXTB	R5, R5
;J3_OLED_SH1106.c,96 :: 		}
; auxResto end address is: 0 (R0)
; auxPage end address is: 16 (R4)
; iX end address is: 20 (R5)
IT	AL
BAL	L_J3_OLED_lineHBuffer6
L_J3_OLED_lineHBuffer7:
;J3_OLED_SH1106.c,97 :: 		}
L_end_J3_OLED_lineHBuffer:
BX	LR
; end of _J3_OLED_lineHBuffer
_J3_OLED_lineVBuffer:
;J3_OLED_SH1106.c,99 :: 		void J3_OLED_lineVBuffer(unsigned char _x){
; _x start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; _x end address is: 0 (R0)
; _x start address is: 0 (R0)
;J3_OLED_SH1106.c,101 :: 		for(iY=0; iY<=63; iY++){
; iY start address is: 28 (R7)
MOVS	R7, #0
; _x end address is: 0 (R0)
; iY end address is: 28 (R7)
UXTB	R6, R0
L_J3_OLED_lineVBuffer9:
; iY start address is: 28 (R7)
; _x start address is: 24 (R6)
; _x start address is: 24 (R6)
; _x end address is: 24 (R6)
CMP	R7, #63
IT	HI
BHI	L_J3_OLED_lineVBuffer10
; _x end address is: 24 (R6)
;J3_OLED_SH1106.c,102 :: 		J3_OLED_putPixelBuffer(_x,iY);
; _x start address is: 24 (R6)
UXTB	R1, R7
UXTB	R0, R6
BL	_J3_OLED_putPixelBuffer+0
;J3_OLED_SH1106.c,101 :: 		for(iY=0; iY<=63; iY++){
ADDS	R7, R7, #1
UXTB	R7, R7
;J3_OLED_SH1106.c,103 :: 		}
; _x end address is: 24 (R6)
; iY end address is: 28 (R7)
IT	AL
BAL	L_J3_OLED_lineVBuffer9
L_J3_OLED_lineVBuffer10:
;J3_OLED_SH1106.c,104 :: 		}
L_end_J3_OLED_lineVBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_lineVBuffer
_J3_OLED_rectangleBuffer:
;J3_OLED_SH1106.c,106 :: 		void J3_OLED_rectangleBuffer(unsigned char _x1, unsigned char _y1, unsigned char _x2, unsigned char _y2){
; _y2 start address is: 12 (R3)
; _x2 start address is: 8 (R2)
; _y1 start address is: 4 (R1)
; _x1 start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; _y2 end address is: 12 (R3)
; _x2 end address is: 8 (R2)
; _y1 end address is: 4 (R1)
; _x1 end address is: 0 (R0)
; _x1 start address is: 0 (R0)
; _y1 start address is: 4 (R1)
; _x2 start address is: 8 (R2)
; _y2 start address is: 12 (R3)
;J3_OLED_SH1106.c,109 :: 		for(iY=_y1; iY<=_y2; iY++){
; iY start address is: 40 (R10)
UXTB	R10, R1
; _x1 end address is: 0 (R0)
; _y1 end address is: 4 (R1)
; _x2 end address is: 8 (R2)
; _y2 end address is: 12 (R3)
; iY end address is: 40 (R10)
UXTB	R9, R0
UXTB	R8, R1
UXTB	R7, R2
UXTB	R6, R3
L_J3_OLED_rectangleBuffer12:
; iY start address is: 40 (R10)
; _y2 start address is: 24 (R6)
; _x2 start address is: 28 (R7)
; _y1 start address is: 32 (R8)
; _x1 start address is: 36 (R9)
CMP	R10, R6
IT	HI
BHI	L_J3_OLED_rectangleBuffer13
;J3_OLED_SH1106.c,110 :: 		J3_OLED_putPixelBuffer(_x1,iY);
UXTB	R1, R10
UXTB	R0, R9
BL	_J3_OLED_putPixelBuffer+0
;J3_OLED_SH1106.c,111 :: 		J3_OLED_putPixelBuffer(_x2,iY);
UXTB	R1, R10
UXTB	R0, R7
BL	_J3_OLED_putPixelBuffer+0
;J3_OLED_SH1106.c,109 :: 		for(iY=_y1; iY<=_y2; iY++){
ADD	R10, R10, #1
UXTB	R10, R10
;J3_OLED_SH1106.c,112 :: 		}
; iY end address is: 40 (R10)
IT	AL
BAL	L_J3_OLED_rectangleBuffer12
L_J3_OLED_rectangleBuffer13:
;J3_OLED_SH1106.c,113 :: 		for(iX=_x1; iX<=_x2; iX++){
; iX start address is: 0 (R0)
UXTB	R0, R9
; _y2 end address is: 24 (R6)
; _y1 end address is: 32 (R8)
; _x1 end address is: 36 (R9)
; iX end address is: 0 (R0)
; _x2 end address is: 28 (R7)
STRB	R8, [SP, #4]
UXTB	R8, R6
UXTB	R9, R0
LDRB	R6, [SP, #4]
L_J3_OLED_rectangleBuffer15:
; iX start address is: 36 (R9)
; _y2 start address is: 32 (R8)
; _y1 start address is: 24 (R6)
; _y1 start address is: 24 (R6)
; _y1 end address is: 24 (R6)
; _x2 start address is: 28 (R7)
; _y2 start address is: 32 (R8)
; _y2 end address is: 32 (R8)
CMP	R9, R7
IT	HI
BHI	L_J3_OLED_rectangleBuffer16
; _y1 end address is: 24 (R6)
; _y2 end address is: 32 (R8)
;J3_OLED_SH1106.c,114 :: 		J3_OLED_putPixelBuffer(iX,_y1);
; _y2 start address is: 32 (R8)
; _y1 start address is: 24 (R6)
UXTB	R1, R6
UXTB	R0, R9
BL	_J3_OLED_putPixelBuffer+0
;J3_OLED_SH1106.c,115 :: 		J3_OLED_putPixelBuffer(iX,_y2);
UXTB	R1, R8
UXTB	R0, R9
BL	_J3_OLED_putPixelBuffer+0
;J3_OLED_SH1106.c,113 :: 		for(iX=_x1; iX<=_x2; iX++){
ADD	R9, R9, #1
UXTB	R9, R9
;J3_OLED_SH1106.c,116 :: 		}
; _y1 end address is: 24 (R6)
; _x2 end address is: 28 (R7)
; _y2 end address is: 32 (R8)
; iX end address is: 36 (R9)
IT	AL
BAL	L_J3_OLED_rectangleBuffer15
L_J3_OLED_rectangleBuffer16:
;J3_OLED_SH1106.c,117 :: 		}
L_end_J3_OLED_rectangleBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _J3_OLED_rectangleBuffer
_J3_OLED_setBuffer:
;J3_OLED_SH1106.c,119 :: 		void J3_OLED_setBuffer(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,121 :: 		for(iY=0;iY<=7;iY++){
; iY start address is: 24 (R6)
MOVS	R6, #0
; iY end address is: 24 (R6)
L_J3_OLED_setBuffer18:
; iY start address is: 24 (R6)
CMP	R6, #7
IT	HI
BHI	L_J3_OLED_setBuffer19
;J3_OLED_SH1106.c,122 :: 		J3_OLED_cursorY(iY);
UXTB	R0, R6
BL	_J3_OLED_cursorY+0
;J3_OLED_SH1106.c,123 :: 		J3_OLED_cursorX(0);
MOVS	R0, #0
BL	_J3_OLED_cursorX+0
;J3_OLED_SH1106.c,124 :: 		for(iX=0;iX<=127;iX++){
; iX start address is: 20 (R5)
MOVS	R5, #0
; iX end address is: 20 (R5)
; iY end address is: 24 (R6)
L_J3_OLED_setBuffer21:
; iX start address is: 20 (R5)
; iY start address is: 24 (R6)
CMP	R5, #127
IT	HI
BHI	L_J3_OLED_setBuffer22
;J3_OLED_SH1106.c,125 :: 		sendData(oled_buffer[iX][iY]);
LSLS	R1, R5, #3
MOVW	R0, #lo_addr(_oled_buffer+0)
MOVT	R0, #hi_addr(_oled_buffer+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R6
LDRB	R0, [R0, #0]
BL	_sendData+0
;J3_OLED_SH1106.c,124 :: 		for(iX=0;iX<=127;iX++){
ADDS	R5, R5, #1
UXTB	R5, R5
;J3_OLED_SH1106.c,126 :: 		}
; iX end address is: 20 (R5)
IT	AL
BAL	L_J3_OLED_setBuffer21
L_J3_OLED_setBuffer22:
;J3_OLED_SH1106.c,121 :: 		for(iY=0;iY<=7;iY++){
ADDS	R6, R6, #1
UXTB	R6, R6
;J3_OLED_SH1106.c,127 :: 		}
; iY end address is: 24 (R6)
IT	AL
BAL	L_J3_OLED_setBuffer18
L_J3_OLED_setBuffer19:
;J3_OLED_SH1106.c,128 :: 		}
L_end_J3_OLED_setBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_setBuffer
_J3_OLED_onDisplay:
;J3_OLED_SH1106.c,130 :: 		void J3_OLED_onDisplay(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,131 :: 		sendCmd(0xAF) ;                     // turn on OLED panel
MOVS	R0, #175
BL	_sendCmd+0
;J3_OLED_SH1106.c,132 :: 		}
L_end_J3_OLED_onDisplay:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_onDisplay
_J3_OLED_offDisplay:
;J3_OLED_SH1106.c,133 :: 		void J3_OLED_offDisplay(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,134 :: 		sendCmd(0xAE) ;                     // turn off OLED panel
MOVS	R0, #174
BL	_sendCmd+0
;J3_OLED_SH1106.c,135 :: 		}
L_end_J3_OLED_offDisplay:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_offDisplay
_J3_OLED_setContrast:
;J3_OLED_SH1106.c,136 :: 		void J3_OLED_setContrast(unsigned char contr){// set contrast control register
; contr start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R5, R0
; contr end address is: 0 (R0)
; contr start address is: 20 (R5)
;J3_OLED_SH1106.c,137 :: 		sendCmd(0x81);
MOVS	R0, #129
BL	_sendCmd+0
;J3_OLED_SH1106.c,138 :: 		sendCmd(contr);
UXTB	R0, R5
; contr end address is: 20 (R5)
BL	_sendCmd+0
;J3_OLED_SH1106.c,139 :: 		}
L_end_J3_OLED_setContrast:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_setContrast
_J3_OLED_setDisplayLine:
;J3_OLED_SH1106.c,140 :: 		void J3_OLED_setDisplayLine(void) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,141 :: 		sendCmd(0x40) ;
MOVS	R0, #64
BL	_sendCmd+0
;J3_OLED_SH1106.c,142 :: 		}
L_end_J3_OLED_setDisplayLine:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_setDisplayLine
_J3_OLED_setNormal:
;J3_OLED_SH1106.c,143 :: 		void J3_OLED_setNormal(void){// set
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,144 :: 		sendCmd(0xA6);
MOVS	R0, #166
BL	_sendCmd+0
;J3_OLED_SH1106.c,145 :: 		}
L_end_J3_OLED_setNormal:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_setNormal
_J3_OLED_setReverse:
;J3_OLED_SH1106.c,146 :: 		void J3_OLED_setReverse(void){// set
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,147 :: 		sendCmd(0xA7);
MOVS	R0, #167
BL	_sendCmd+0
;J3_OLED_SH1106.c,148 :: 		}
L_end_J3_OLED_setReverse:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_setReverse
_J3_OLED_setDisplayClock:
;J3_OLED_SH1106.c,150 :: 		void J3_OLED_setDisplayClock(void){// set
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,151 :: 		sendCmd(0xD5);
MOVS	R0, #213
BL	_sendCmd+0
;J3_OLED_SH1106.c,152 :: 		sendCmd(0x00);
MOVS	R0, #0
BL	_sendCmd+0
;J3_OLED_SH1106.c,153 :: 		}
L_end_J3_OLED_setDisplayClock:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_setDisplayClock
_J3_OLED_cursorY:
;J3_OLED_SH1106.c,155 :: 		void J3_OLED_cursorY(unsigned char add) { //Set page address for Page Addressing Mode
; add start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; add end address is: 0 (R0)
; add start address is: 0 (R0)
;J3_OLED_SH1106.c,156 :: 		sendCmd(0xB0 | add) ;
ORR	R1, R0, #176
; add end address is: 0 (R0)
UXTB	R0, R1
BL	_sendCmd+0
;J3_OLED_SH1106.c,157 :: 		}
L_end_J3_OLED_cursorY:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_cursorY
_J3_OLED_cursorX:
;J3_OLED_SH1106.c,159 :: 		void J3_OLED_cursorX(unsigned char add){ //Set column adress for Page Addressing Mode
; add start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; add end address is: 0 (R0)
; add start address is: 0 (R0)
;J3_OLED_SH1106.c,160 :: 		add = add+sXOffset ;
ADDS	R1, R0, #2
; add end address is: 0 (R0)
; add start address is: 20 (R5)
UXTB	R5, R1
;J3_OLED_SH1106.c,161 :: 		sendCmd(0x10 | (add>>4)) ; //  shift high 4
UXTB	R1, R1
LSRS	R1, R1, #4
UXTB	R1, R1
ORR	R1, R1, #16
UXTB	R0, R1
BL	_sendCmd+0
;J3_OLED_SH1106.c,162 :: 		sendCmd(0x0F & add) ;      // low 4
AND	R1, R5, #15
; add end address is: 20 (R5)
UXTB	R0, R1
BL	_sendCmd+0
;J3_OLED_SH1106.c,163 :: 		}
L_end_J3_OLED_cursorX:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_cursorX
_J3_OLED_cursorXY:
;J3_OLED_SH1106.c,164 :: 		void J3_OLED_cursorXY(unsigned char x, unsigned char y){ // Position cursor to column, line
; y start address is: 4 (R1)
; x start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R5, R0
; y end address is: 4 (R1)
; x end address is: 0 (R0)
; x start address is: 20 (R5)
; y start address is: 4 (R1)
;J3_OLED_SH1106.c,165 :: 		J3_OLED_cursorY(y) ; // Y axis = line 0-7
UXTB	R0, R1
; y end address is: 4 (R1)
BL	_J3_OLED_cursorY+0
;J3_OLED_SH1106.c,166 :: 		J3_OLED_cursorX(x) ; // X axis = column 0 - (sWidth - 1)
UXTB	R0, R5
; x end address is: 20 (R5)
BL	_J3_OLED_cursorX+0
;J3_OLED_SH1106.c,167 :: 		}
L_end_J3_OLED_cursorXY:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_cursorXY
_J3_OLED_clLnDisplay:
;J3_OLED_SH1106.c,168 :: 		void J3_OLED_clLnDisplay(unsigned char yline){ // Clear single line 0-7 on display, cursor to line start
; yline start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R6, R0
; yline end address is: 0 (R0)
; yline start address is: 24 (R6)
;J3_OLED_SH1106.c,170 :: 		J3_OLED_cursorXY(0, yline)    ;            // Cursor Home
UXTB	R1, R6
MOVS	R0, #0
BL	_J3_OLED_cursorXY+0
;J3_OLED_SH1106.c,171 :: 		for (ram=sWidth ; ram>0 ; ram--)   // sWidth DDRAM addresses in each line
; ram start address is: 20 (R5)
MOVS	R5, #128
; yline end address is: 24 (R6)
; ram end address is: 20 (R5)
L_J3_OLED_clLnDisplay24:
; ram start address is: 20 (R5)
; yline start address is: 24 (R6)
CMP	R5, #0
IT	LS
BLS	L_J3_OLED_clLnDisplay25
;J3_OLED_SH1106.c,172 :: 		{ sendData(0); }                   // clear RAM
MOVS	R0, #0
BL	_sendData+0
;J3_OLED_SH1106.c,171 :: 		for (ram=sWidth ; ram>0 ; ram--)   // sWidth DDRAM addresses in each line
SUBS	R5, R5, #1
UXTB	R5, R5
;J3_OLED_SH1106.c,172 :: 		{ sendData(0); }                   // clear RAM
; ram end address is: 20 (R5)
IT	AL
BAL	L_J3_OLED_clLnDisplay24
L_J3_OLED_clLnDisplay25:
;J3_OLED_SH1106.c,173 :: 		J3_OLED_cursorXY(0, yline) ;               // Cursor Home
UXTB	R1, R6
; yline end address is: 24 (R6)
MOVS	R0, #0
BL	_J3_OLED_cursorXY+0
;J3_OLED_SH1106.c,174 :: 		}
L_end_J3_OLED_clLnDisplay:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_clLnDisplay
_J3_OLED_clsDisplay:
;J3_OLED_SH1106.c,175 :: 		void J3_OLED_clsDisplay(void){ // Erase the entire display DDRAM and set cursor home (0,0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,177 :: 		J3_OLED_offDisplay() ;                      // turn off OLED panel
BL	_J3_OLED_offDisplay+0
;J3_OLED_SH1106.c,178 :: 		for (line = 8 ; line > 0 ; line--)  // 8 lines of Display DDRAM
; line start address is: 32 (R8)
MOVW	R8, #8
; line end address is: 32 (R8)
L_J3_OLED_clsDisplay27:
; line start address is: 32 (R8)
CMP	R8, #0
IT	LS
BLS	L_J3_OLED_clsDisplay28
;J3_OLED_SH1106.c,179 :: 		{ J3_OLED_clLnDisplay(8 - line) ; }         // erase each in turn, home cursor to line
RSB	R0, R8, #8
UXTB	R0, R0
BL	_J3_OLED_clLnDisplay+0
;J3_OLED_SH1106.c,178 :: 		for (line = 8 ; line > 0 ; line--)  // 8 lines of Display DDRAM
SUB	R8, R8, #1
UXTB	R8, R8
;J3_OLED_SH1106.c,179 :: 		{ J3_OLED_clLnDisplay(8 - line) ; }         // erase each in turn, home cursor to line
; line end address is: 32 (R8)
IT	AL
BAL	L_J3_OLED_clsDisplay27
L_J3_OLED_clsDisplay28:
;J3_OLED_SH1106.c,180 :: 		J3_OLED_onDisplay() ;                       // turn on OLED panel
BL	_J3_OLED_onDisplay+0
;J3_OLED_SH1106.c,181 :: 		}
L_end_J3_OLED_clsDisplay:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_clsDisplay
_J3_OLED_setPixelXY:
;J3_OLED_SH1106.c,183 :: 		void J3_OLED_setPixelXY(unsigned char _x, unsigned char _y){
; _y start address is: 4 (R1)
; _x start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R6, R0
UXTB	R8, R1
; _y end address is: 4 (R1)
; _x end address is: 0 (R0)
; _x start address is: 24 (R6)
; _y start address is: 32 (R8)
;J3_OLED_SH1106.c,186 :: 		auxPage = _y / 8;
LSR	R2, R8, #3
; auxPage start address is: 36 (R9)
UXTB	R9, R2
;J3_OLED_SH1106.c,187 :: 		J3_OLED_cursorX(_x);
UXTB	R0, R6
BL	_J3_OLED_cursorX+0
;J3_OLED_SH1106.c,188 :: 		J3_OLED_cursorY(auxPage);
UXTB	R0, R9
; auxPage end address is: 36 (R9)
BL	_J3_OLED_cursorY+0
;J3_OLED_SH1106.c,189 :: 		auxDado = J3_OLED_putPixelBuffer(_x, _y);
UXTB	R1, R8
; _y end address is: 32 (R8)
UXTB	R0, R6
; _x end address is: 24 (R6)
BL	_J3_OLED_putPixelBuffer+0
;J3_OLED_SH1106.c,190 :: 		sendData(auxDado);
BL	_sendData+0
;J3_OLED_SH1106.c,191 :: 		}
L_end_J3_OLED_setPixelXY:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_setPixelXY
_rptPix:
;J3_OLED_SH1106.c,193 :: 		void rptPix(unsigned char pix, unsigned char blank, unsigned char percent){ // repeat pixel across Display for percent - show bar graph
; percent start address is: 8 (R2)
; blank start address is: 4 (R1)
; pix start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; percent end address is: 8 (R2)
; blank end address is: 4 (R1)
; pix end address is: 0 (R0)
; pix start address is: 0 (R0)
; blank start address is: 4 (R1)
; percent start address is: 8 (R2)
;J3_OLED_SH1106.c,196 :: 		width = (sWidth*percent)/100 ; // screen width x fill level
LSLS	R5, R2, #7
SXTH	R5, R5
; percent end address is: 8 (R2)
MOVS	R3, #100
SXTH	R3, R3
SDIV	R5, R5, R3
SXTH	R5, R5
; width start address is: 20 (R5)
;J3_OLED_SH1106.c,197 :: 		for (count=0; count<sWidth; count++)  // loop for width
; count start address is: 36 (R9)
MOVW	R9, #0
; pix end address is: 0 (R0)
; blank end address is: 4 (R1)
; count end address is: 36 (R9)
UXTB	R8, R0
UXTB	R6, R1
L_rptPix30:
; count start address is: 36 (R9)
; pix start address is: 32 (R8)
; blank start address is: 24 (R6)
; width start address is: 20 (R5)
; width end address is: 20 (R5)
; blank start address is: 24 (R6)
; blank end address is: 24 (R6)
; pix start address is: 32 (R8)
; pix end address is: 32 (R8)
CMP	R9, #128
IT	CS
BCS	L_rptPix31
; width end address is: 20 (R5)
; blank end address is: 24 (R6)
; pix end address is: 32 (R8)
;J3_OLED_SH1106.c,199 :: 		if ((count <= width)||(count > (sWidth - 2)))
; pix start address is: 32 (R8)
; blank start address is: 24 (R6)
; width start address is: 20 (R5)
CMP	R9, R5
IT	LE
BLE	L__rptPix45
CMP	R9, #126
IT	GT
BGT	L__rptPix44
IT	AL
BAL	L_rptPix35
L__rptPix45:
L__rptPix44:
;J3_OLED_SH1106.c,200 :: 		{  sendData(pix) ; }  // send 'pix' glyph to display
UXTB	R0, R8
BL	_sendData+0
IT	AL
BAL	L_rptPix36
L_rptPix35:
;J3_OLED_SH1106.c,202 :: 		{  sendData(blank) ;} // send 'blank' glyph to display
UXTB	R0, R6
BL	_sendData+0
L_rptPix36:
;J3_OLED_SH1106.c,197 :: 		for (count=0; count<sWidth; count++)  // loop for width
ADD	R9, R9, #1
UXTB	R9, R9
;J3_OLED_SH1106.c,203 :: 		}
; width end address is: 20 (R5)
; blank end address is: 24 (R6)
; pix end address is: 32 (R8)
; count end address is: 36 (R9)
IT	AL
BAL	L_rptPix30
L_rptPix31:
;J3_OLED_SH1106.c,204 :: 		}
L_end_rptPix:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _rptPix
_barDisplay:
;J3_OLED_SH1106.c,206 :: 		void barDisplay(unsigned char barG){// water bargraph on line 7
; barG start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R6, R0
; barG end address is: 0 (R0)
; barG start address is: 24 (R6)
;J3_OLED_SH1106.c,207 :: 		J3_OLED_cursorXY(0, 7) ;
MOVS	R1, #7
MOVS	R0, #0
BL	_J3_OLED_cursorXY+0
;J3_OLED_SH1106.c,208 :: 		rptPix(0b11111111, 0b10000001, barG);  // Draw line, then blanks
UXTB	R2, R6
; barG end address is: 24 (R6)
MOVS	R1, #129
MOVS	R0, #255
BL	_rptPix+0
;J3_OLED_SH1106.c,209 :: 		}
L_end_barDisplay:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _barDisplay
_sendGlyphs:
;J3_OLED_SH1106.c,210 :: 		void sendGlyphs(const unsigned char *pRow, unsigned char size){ //Send any font row to print character
; size start address is: 4 (R1)
; pRow start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; size end address is: 4 (R1)
; pRow end address is: 0 (R0)
; pRow start address is: 0 (R0)
; size start address is: 4 (R1)
;J3_OLED_SH1106.c,212 :: 		for (count = 0 ; count < size ; count++)  // Send row to print the character
; count start address is: 32 (R8)
MOVW	R8, #0
; pRow end address is: 0 (R0)
; size end address is: 4 (R1)
; count end address is: 32 (R8)
MOV	R6, R0
UXTB	R5, R1
L_sendGlyphs37:
; count start address is: 32 (R8)
; pRow start address is: 24 (R6)
; size start address is: 20 (R5)
; pRow start address is: 24 (R6)
; pRow end address is: 24 (R6)
CMP	R8, R5
IT	CS
BCS	L_sendGlyphs38
; pRow end address is: 24 (R6)
;J3_OLED_SH1106.c,214 :: 		sendData(pRow[count]);
; pRow start address is: 24 (R6)
ADD	R2, R6, R8, LSL #0
LDRB	R2, [R2, #0]
UXTB	R0, R2
BL	_sendData+0
;J3_OLED_SH1106.c,212 :: 		for (count = 0 ; count < size ; count++)  // Send row to print the character
ADD	R8, R8, #1
UXTB	R8, R8
;J3_OLED_SH1106.c,215 :: 		}
; size end address is: 20 (R5)
; pRow end address is: 24 (R6)
; count end address is: 32 (R8)
IT	AL
BAL	L_sendGlyphs37
L_sendGlyphs38:
;J3_OLED_SH1106.c,216 :: 		sendData(0x00);  // 1 pixel horizontal space after character
MOVS	R0, #0
BL	_sendData+0
;J3_OLED_SH1106.c,217 :: 		}
L_end_sendGlyphs:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _sendGlyphs
_charFont5:
;J3_OLED_SH1106.c,218 :: 		void charFont5(unsigned char character){ // MODIFY IF FONT RANGE CHANGED
; character start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; character end address is: 0 (R0)
; character start address is: 0 (R0)
;J3_OLED_SH1106.c,220 :: 		if (character == ' ')  // munge ' ' to empty ';' character
CMP	R0, #32
IT	NE
BNE	L__charFont546
;J3_OLED_SH1106.c,221 :: 		{ character = ';' ; }
MOVS	R0, #59
; character end address is: 0 (R0)
IT	AL
BAL	L_charFont540
L__charFont546:
;J3_OLED_SH1106.c,220 :: 		if (character == ' ')  // munge ' ' to empty ';' character
;J3_OLED_SH1106.c,221 :: 		{ character = ';' ; }
L_charFont540:
;J3_OLED_SH1106.c,225 :: 		sendGlyphs(font5[character - '.'], sizeof font5[0]);
; character start address is: 0 (R0)
SUBW	R2, R0, #46
SXTH	R2, R2
; character end address is: 0 (R0)
MOVS	R1, #5
MULS	R2, R1, R2
MOVW	R1, #lo_addr(_font5+0)
MOVT	R1, #hi_addr(_font5+0)
ADDS	R1, R1, R2
MOV	R0, R1
MOVS	R1, #5
BL	_sendGlyphs+0
;J3_OLED_SH1106.c,226 :: 		}
L_end_charFont5:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _charFont5
_strFont5:
;J3_OLED_SH1106.c,228 :: 		void strFont5(unsigned char s[])
; s start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; s end address is: 0 (R0)
; s start address is: 0 (R0)
MOV	R9, R0
; s end address is: 0 (R0)
;J3_OLED_SH1106.c,230 :: 		while(*s) {charFont5(*s++);} // Points to character, or terminator
L_strFont541:
; s start address is: 36 (R9)
LDRB	R1, [R9, #0]
CMP	R1, #0
IT	EQ
BEQ	L_strFont542
LDRB	R1, [R9, #0]
UXTB	R0, R1
BL	_charFont5+0
ADD	R9, R9, #1
; s end address is: 36 (R9)
IT	AL
BAL	L_strFont541
L_strFont542:
;J3_OLED_SH1106.c,231 :: 		}
L_end_strFont5:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _strFont5
