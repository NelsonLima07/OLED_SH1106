_J3_OLED_clearBuffer:
;J3_OLED_SH1106.c,12 :: 		void J3_OLED_clearBuffer(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,15 :: 		for(iY=0;iY<=7;iY++){
; iY start address is: 32 (R8)
MOVW	R8, #0
; iY end address is: 32 (R8)
L_J3_OLED_clearBuffer0:
; iY start address is: 32 (R8)
CMP	R8, #7
IT	HI
BHI	L_J3_OLED_clearBuffer1
;J3_OLED_SH1106.c,16 :: 		cursorY(iY);
UXTB	R0, R8
BL	_cursorY+0
;J3_OLED_SH1106.c,17 :: 		for(iX=0;iX<=127;iX++){
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
;J3_OLED_SH1106.c,18 :: 		cursorX(iX);
UXTB	R0, R6
BL	_cursorX+0
;J3_OLED_SH1106.c,19 :: 		oled_buffer[iX][iY] = 0x00;
LSLS	R1, R6, #3
MOVW	R0, #lo_addr(_oled_buffer+0)
MOVT	R0, #hi_addr(_oled_buffer+0)
ADDS	R0, R0, R1
ADD	R1, R0, R8, LSL #0
MOVS	R0, #0
STRB	R0, [R1, #0]
;J3_OLED_SH1106.c,17 :: 		for(iX=0;iX<=127;iX++){
ADDS	R6, R6, #1
UXTB	R6, R6
;J3_OLED_SH1106.c,20 :: 		}
; iX end address is: 24 (R6)
IT	AL
BAL	L_J3_OLED_clearBuffer3
L_J3_OLED_clearBuffer4:
;J3_OLED_SH1106.c,15 :: 		for(iY=0;iY<=7;iY++){
ADD	R8, R8, #1
UXTB	R8, R8
;J3_OLED_SH1106.c,21 :: 		}
; iY end address is: 32 (R8)
IT	AL
BAL	L_J3_OLED_clearBuffer0
L_J3_OLED_clearBuffer1:
;J3_OLED_SH1106.c,22 :: 		}
L_end_J3_OLED_clearBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_clearBuffer
_J3_OLED_putPixelBuffer:
;J3_OLED_SH1106.c,24 :: 		unsigned char J3_OLED_putPixelBuffer(unsigned char _x, unsigned char _y){
; _y start address is: 4 (R1)
; _x start address is: 0 (R0)
; _y end address is: 4 (R1)
; _x end address is: 0 (R0)
; _x start address is: 0 (R0)
; _y start address is: 4 (R1)
;J3_OLED_SH1106.c,29 :: 		auxPage = _y / 8;
LSRS	R4, R1, #3
UXTB	R4, R4
;J3_OLED_SH1106.c,30 :: 		auxResto = _y % 8;
AND	R5, R1, #7
UXTB	R5, R5
; _y end address is: 4 (R1)
;J3_OLED_SH1106.c,31 :: 		auxDado = oled_buffer[_x][auxPage];
LSLS	R3, R0, #3
; _x end address is: 0 (R0)
MOVW	R2, #lo_addr(_oled_buffer+0)
MOVT	R2, #hi_addr(_oled_buffer+0)
ADDS	R2, R2, R3
ADDS	R4, R2, R4
LDRB	R3, [R4, #0]
;J3_OLED_SH1106.c,32 :: 		auxDado = auxDado | (0b00000001 << auxResto);
MOVS	R2, #1
SXTH	R2, R2
LSLS	R2, R5
SXTH	R2, R2
ORR	R2, R3, R2, LSL #0
; auxDado start address is: 0 (R0)
UXTB	R0, R2
;J3_OLED_SH1106.c,33 :: 		oled_buffer[_x][auxPage] = auxDado;
UXTB	R2, R2
STRB	R2, [R4, #0]
;J3_OLED_SH1106.c,34 :: 		return auxDado;
; auxDado end address is: 0 (R0)
;J3_OLED_SH1106.c,35 :: 		}
L_end_J3_OLED_putPixelBuffer:
BX	LR
; end of _J3_OLED_putPixelBuffer
_J3_OLED_setBuffer:
;J3_OLED_SH1106.c,37 :: 		void J3_OLED_setBuffer(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,39 :: 		for(iY=0;iY<=7;iY++){
; iY start address is: 24 (R6)
MOVS	R6, #0
; iY end address is: 24 (R6)
L_J3_OLED_setBuffer6:
; iY start address is: 24 (R6)
CMP	R6, #7
IT	HI
BHI	L_J3_OLED_setBuffer7
;J3_OLED_SH1106.c,40 :: 		cursorY(iY);
UXTB	R0, R6
BL	_cursorY+0
;J3_OLED_SH1106.c,41 :: 		cursorX(0);
MOVS	R0, #0
BL	_cursorX+0
;J3_OLED_SH1106.c,42 :: 		for(iX=0;iX<=127;iX++){
; iX start address is: 20 (R5)
MOVS	R5, #0
; iX end address is: 20 (R5)
; iY end address is: 24 (R6)
L_J3_OLED_setBuffer9:
; iX start address is: 20 (R5)
; iY start address is: 24 (R6)
CMP	R5, #127
IT	HI
BHI	L_J3_OLED_setBuffer10
;J3_OLED_SH1106.c,43 :: 		sendData(oled_buffer[iX][iY]);
LSLS	R1, R5, #3
MOVW	R0, #lo_addr(_oled_buffer+0)
MOVT	R0, #hi_addr(_oled_buffer+0)
ADDS	R0, R0, R1
ADDS	R0, R0, R6
LDRB	R0, [R0, #0]
BL	_sendData+0
;J3_OLED_SH1106.c,42 :: 		for(iX=0;iX<=127;iX++){
ADDS	R5, R5, #1
UXTB	R5, R5
;J3_OLED_SH1106.c,44 :: 		}
; iX end address is: 20 (R5)
IT	AL
BAL	L_J3_OLED_setBuffer9
L_J3_OLED_setBuffer10:
;J3_OLED_SH1106.c,39 :: 		for(iY=0;iY<=7;iY++){
ADDS	R6, R6, #1
UXTB	R6, R6
;J3_OLED_SH1106.c,45 :: 		}
; iY end address is: 24 (R6)
IT	AL
BAL	L_J3_OLED_setBuffer6
L_J3_OLED_setBuffer7:
;J3_OLED_SH1106.c,46 :: 		}
L_end_J3_OLED_setBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _J3_OLED_setBuffer
_sendCmd:
;J3_OLED_SH1106.c,49 :: 		void sendCmd(unsigned char cmd){
; cmd start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
; cmd end address is: 0 (R0)
; cmd start address is: 16 (R4)
;J3_OLED_SH1106.c,50 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;J3_OLED_SH1106.c,51 :: 		Soft_I2C_Write(OLED_I2C_ADDRESS);
MOVS	R0, #120
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,52 :: 		Soft_I2C_Write(0x00);
MOVS	R0, #0
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,53 :: 		Soft_I2C_Write(cmd);
UXTB	R0, R4
; cmd end address is: 16 (R4)
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,54 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;J3_OLED_SH1106.c,55 :: 		}
L_end_sendCmd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _sendCmd
_sendData:
;J3_OLED_SH1106.c,56 :: 		void sendData(unsigned char dat){
; dat start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R4, R0
; dat end address is: 0 (R0)
; dat start address is: 16 (R4)
;J3_OLED_SH1106.c,57 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;J3_OLED_SH1106.c,58 :: 		Soft_I2C_Write(OLED_I2C_ADDRESS);
MOVS	R0, #120
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,59 :: 		Soft_I2C_Write(0x40);
MOVS	R0, #64
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,60 :: 		Soft_I2C_Write(dat);
UXTB	R0, R4
; dat end address is: 16 (R4)
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,61 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;J3_OLED_SH1106.c,62 :: 		}
L_end_sendData:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _sendData
_readData:
;J3_OLED_SH1106.c,87 :: 		unsigned char readData(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,89 :: 		Soft_I2C_Start();
BL	_Soft_I2C_Start+0
;J3_OLED_SH1106.c,90 :: 		Soft_I2C_Write(OLED_I2C_ADDRESS_READ);
MOVS	R0, #123
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,91 :: 		Soft_I2C_Write(0x00);
MOVS	R0, #0
BL	_Soft_I2C_Write+0
;J3_OLED_SH1106.c,92 :: 		aux = Soft_I2C_Read(0);
MOVS	R0, #0
BL	_Soft_I2C_Read+0
; aux start address is: 8 (R2)
UXTB	R2, R0
;J3_OLED_SH1106.c,93 :: 		Soft_I2C_Stop();
BL	_Soft_I2C_Stop+0
;J3_OLED_SH1106.c,94 :: 		return aux;
UXTB	R0, R2
; aux end address is: 8 (R2)
;J3_OLED_SH1106.c,95 :: 		}
L_end_readData:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _readData
_onDisplay:
;J3_OLED_SH1106.c,98 :: 		void onDisplay(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,99 :: 		sendCmd(0xAF) ;                     // turn on OLED panel
MOVS	R0, #175
BL	_sendCmd+0
;J3_OLED_SH1106.c,100 :: 		}
L_end_onDisplay:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _onDisplay
_offDisplay:
;J3_OLED_SH1106.c,101 :: 		void offDisplay(void){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,102 :: 		sendCmd(0xAE) ;                     // turn off OLED panel
MOVS	R0, #174
BL	_sendCmd+0
;J3_OLED_SH1106.c,103 :: 		}
L_end_offDisplay:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _offDisplay
_setContrast:
;J3_OLED_SH1106.c,104 :: 		void setContrast(unsigned char contr){// set contrast control register
; contr start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R5, R0
; contr end address is: 0 (R0)
; contr start address is: 20 (R5)
;J3_OLED_SH1106.c,105 :: 		sendCmd(0x81);
MOVS	R0, #129
BL	_sendCmd+0
;J3_OLED_SH1106.c,106 :: 		sendCmd(contr);
UXTB	R0, R5
; contr end address is: 20 (R5)
BL	_sendCmd+0
;J3_OLED_SH1106.c,107 :: 		}
L_end_setContrast:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _setContrast
_setDisplayLine:
;J3_OLED_SH1106.c,108 :: 		void setDisplayLine(void) {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,109 :: 		sendCmd(0x40) ;
MOVS	R0, #64
BL	_sendCmd+0
;J3_OLED_SH1106.c,110 :: 		}
L_end_setDisplayLine:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _setDisplayLine
_setNormal:
;J3_OLED_SH1106.c,111 :: 		void setNormal(void){// set
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,112 :: 		sendCmd(0xA6);
MOVS	R0, #166
BL	_sendCmd+0
;J3_OLED_SH1106.c,113 :: 		}
L_end_setNormal:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _setNormal
_setReverse:
;J3_OLED_SH1106.c,114 :: 		void setReverse(void){// set
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,115 :: 		sendCmd(0xA7);
MOVS	R0, #167
BL	_sendCmd+0
;J3_OLED_SH1106.c,116 :: 		}
L_end_setReverse:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _setReverse
_setDisplayClock:
;J3_OLED_SH1106.c,118 :: 		void setDisplayClock(void){// set
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,119 :: 		sendCmd(0xD5);
MOVS	R0, #213
BL	_sendCmd+0
;J3_OLED_SH1106.c,120 :: 		sendCmd(0x00);
MOVS	R0, #0
BL	_sendCmd+0
;J3_OLED_SH1106.c,121 :: 		}
L_end_setDisplayClock:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _setDisplayClock
_cursorY:
;J3_OLED_SH1106.c,123 :: 		void cursorY(unsigned char add) { //Set page address for Page Addressing Mode
; add start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; add end address is: 0 (R0)
; add start address is: 0 (R0)
;J3_OLED_SH1106.c,124 :: 		sendCmd(0xB0 | add) ;
ORR	R1, R0, #176
; add end address is: 0 (R0)
UXTB	R0, R1
BL	_sendCmd+0
;J3_OLED_SH1106.c,125 :: 		}
L_end_cursorY:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _cursorY
_cursorX:
;J3_OLED_SH1106.c,127 :: 		void cursorX(unsigned char add){ //Set column adress for Page Addressing Mode
; add start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; add end address is: 0 (R0)
; add start address is: 0 (R0)
;J3_OLED_SH1106.c,128 :: 		add = add+sXOffset ;
ADDS	R1, R0, #2
; add end address is: 0 (R0)
; add start address is: 20 (R5)
UXTB	R5, R1
;J3_OLED_SH1106.c,129 :: 		sendCmd(0x10 | (add>>4)) ; //  shift high 4
UXTB	R1, R1
LSRS	R1, R1, #4
UXTB	R1, R1
ORR	R1, R1, #16
UXTB	R0, R1
BL	_sendCmd+0
;J3_OLED_SH1106.c,130 :: 		sendCmd(0x0F & add) ;      // low 4
AND	R1, R5, #15
; add end address is: 20 (R5)
UXTB	R0, R1
BL	_sendCmd+0
;J3_OLED_SH1106.c,131 :: 		}
L_end_cursorX:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _cursorX
_cursorXY:
;J3_OLED_SH1106.c,132 :: 		void cursorXY(unsigned char x, unsigned char y){ // Position cursor to column, line
; y start address is: 4 (R1)
; x start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R5, R0
; y end address is: 4 (R1)
; x end address is: 0 (R0)
; x start address is: 20 (R5)
; y start address is: 4 (R1)
;J3_OLED_SH1106.c,133 :: 		cursorY(y) ; // Y axis = line 0-7
UXTB	R0, R1
; y end address is: 4 (R1)
BL	_cursorY+0
;J3_OLED_SH1106.c,134 :: 		cursorX(x) ; // X axis = column 0 - (sWidth - 1)
UXTB	R0, R5
; x end address is: 20 (R5)
BL	_cursorX+0
;J3_OLED_SH1106.c,135 :: 		}
L_end_cursorXY:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _cursorXY
_clLnDisplay:
;J3_OLED_SH1106.c,136 :: 		void clLnDisplay(unsigned char yline){ // Clear single line 0-7 on display, cursor to line start
; yline start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R6, R0
; yline end address is: 0 (R0)
; yline start address is: 24 (R6)
;J3_OLED_SH1106.c,138 :: 		cursorXY(0, yline)    ;            // Cursor Home
UXTB	R1, R6
MOVS	R0, #0
BL	_cursorXY+0
;J3_OLED_SH1106.c,139 :: 		for (ram=sWidth ; ram>0 ; ram--)   // sWidth DDRAM addresses in each line
; ram start address is: 20 (R5)
MOVS	R5, #128
; yline end address is: 24 (R6)
; ram end address is: 20 (R5)
L_clLnDisplay12:
; ram start address is: 20 (R5)
; yline start address is: 24 (R6)
CMP	R5, #0
IT	LS
BLS	L_clLnDisplay13
;J3_OLED_SH1106.c,140 :: 		{ sendData(0); }                   // clear RAM
MOVS	R0, #0
BL	_sendData+0
;J3_OLED_SH1106.c,139 :: 		for (ram=sWidth ; ram>0 ; ram--)   // sWidth DDRAM addresses in each line
SUBS	R5, R5, #1
UXTB	R5, R5
;J3_OLED_SH1106.c,140 :: 		{ sendData(0); }                   // clear RAM
; ram end address is: 20 (R5)
IT	AL
BAL	L_clLnDisplay12
L_clLnDisplay13:
;J3_OLED_SH1106.c,141 :: 		cursorXY(0, yline) ;               // Cursor Home
UXTB	R1, R6
; yline end address is: 24 (R6)
MOVS	R0, #0
BL	_cursorXY+0
;J3_OLED_SH1106.c,142 :: 		}
L_end_clLnDisplay:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _clLnDisplay
_clsDisplay:
;J3_OLED_SH1106.c,143 :: 		void clsDisplay(void){ // Erase the entire display DDRAM and set cursor home (0,0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;J3_OLED_SH1106.c,145 :: 		offDisplay() ;                      // turn off OLED panel
BL	_offDisplay+0
;J3_OLED_SH1106.c,146 :: 		for (line = 8 ; line > 0 ; line--)  // 8 lines of Display DDRAM
; line start address is: 32 (R8)
MOVW	R8, #8
; line end address is: 32 (R8)
L_clsDisplay15:
; line start address is: 32 (R8)
CMP	R8, #0
IT	LS
BLS	L_clsDisplay16
;J3_OLED_SH1106.c,147 :: 		{ clLnDisplay(8 - line) ; }         // erase each in turn, home cursor to line
RSB	R0, R8, #8
UXTB	R0, R0
BL	_clLnDisplay+0
;J3_OLED_SH1106.c,146 :: 		for (line = 8 ; line > 0 ; line--)  // 8 lines of Display DDRAM
SUB	R8, R8, #1
UXTB	R8, R8
;J3_OLED_SH1106.c,147 :: 		{ clLnDisplay(8 - line) ; }         // erase each in turn, home cursor to line
; line end address is: 32 (R8)
IT	AL
BAL	L_clsDisplay15
L_clsDisplay16:
;J3_OLED_SH1106.c,148 :: 		onDisplay() ;                       // turn on OLED panel
BL	_onDisplay+0
;J3_OLED_SH1106.c,149 :: 		}
L_end_clsDisplay:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _clsDisplay
_setPixelXY:
;J3_OLED_SH1106.c,151 :: 		void setPixelXY(unsigned char _x, unsigned char _y){
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
;J3_OLED_SH1106.c,154 :: 		auxPage = _y / 8;
LSR	R2, R8, #3
; auxPage start address is: 36 (R9)
UXTB	R9, R2
;J3_OLED_SH1106.c,155 :: 		cursorX(_x);
UXTB	R0, R6
BL	_cursorX+0
;J3_OLED_SH1106.c,156 :: 		cursorY(auxPage);
UXTB	R0, R9
; auxPage end address is: 36 (R9)
BL	_cursorY+0
;J3_OLED_SH1106.c,157 :: 		auxDado = J3_OLED_putPixelBuffer(_x, _y);
UXTB	R1, R8
; _y end address is: 32 (R8)
UXTB	R0, R6
; _x end address is: 24 (R6)
BL	_J3_OLED_putPixelBuffer+0
;J3_OLED_SH1106.c,158 :: 		sendData(auxDado);
BL	_sendData+0
;J3_OLED_SH1106.c,159 :: 		}
L_end_setPixelXY:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _setPixelXY
_rptPix:
;J3_OLED_SH1106.c,161 :: 		void rptPix(unsigned char pix, unsigned char blank, unsigned char percent){ // repeat pixel across Display for percent - show bar graph
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
;J3_OLED_SH1106.c,164 :: 		width = (sWidth*percent)/100 ; // screen width x fill level
LSLS	R5, R2, #7
SXTH	R5, R5
; percent end address is: 8 (R2)
MOVS	R3, #100
SXTH	R3, R3
SDIV	R5, R5, R3
SXTH	R5, R5
; width start address is: 20 (R5)
;J3_OLED_SH1106.c,165 :: 		for (count=0; count<sWidth; count++)  // loop for width
; count start address is: 36 (R9)
MOVW	R9, #0
; pix end address is: 0 (R0)
; blank end address is: 4 (R1)
; count end address is: 36 (R9)
UXTB	R8, R0
UXTB	R6, R1
L_rptPix18:
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
BCS	L_rptPix19
; width end address is: 20 (R5)
; blank end address is: 24 (R6)
; pix end address is: 32 (R8)
;J3_OLED_SH1106.c,167 :: 		if ((count <= width)||(count > (sWidth - 2)))
; pix start address is: 32 (R8)
; blank start address is: 24 (R6)
; width start address is: 20 (R5)
CMP	R9, R5
IT	LE
BLE	L__rptPix33
CMP	R9, #126
IT	GT
BGT	L__rptPix32
IT	AL
BAL	L_rptPix23
L__rptPix33:
L__rptPix32:
;J3_OLED_SH1106.c,168 :: 		{  sendData(pix) ; }  // send 'pix' glyph to display
UXTB	R0, R8
BL	_sendData+0
IT	AL
BAL	L_rptPix24
L_rptPix23:
;J3_OLED_SH1106.c,170 :: 		{  sendData(blank) ;} // send 'blank' glyph to display
UXTB	R0, R6
BL	_sendData+0
L_rptPix24:
;J3_OLED_SH1106.c,165 :: 		for (count=0; count<sWidth; count++)  // loop for width
ADD	R9, R9, #1
UXTB	R9, R9
;J3_OLED_SH1106.c,171 :: 		}
; width end address is: 20 (R5)
; blank end address is: 24 (R6)
; pix end address is: 32 (R8)
; count end address is: 36 (R9)
IT	AL
BAL	L_rptPix18
L_rptPix19:
;J3_OLED_SH1106.c,172 :: 		}
L_end_rptPix:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _rptPix
_barDisplay:
;J3_OLED_SH1106.c,174 :: 		void barDisplay(unsigned char barG){// water bargraph on line 7
; barG start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R6, R0
; barG end address is: 0 (R0)
; barG start address is: 24 (R6)
;J3_OLED_SH1106.c,175 :: 		cursorXY(0, 7) ;
MOVS	R1, #7
MOVS	R0, #0
BL	_cursorXY+0
;J3_OLED_SH1106.c,176 :: 		rptPix(0b11111111, 0b10000001, barG);  // Draw line, then blanks
UXTB	R2, R6
; barG end address is: 24 (R6)
MOVS	R1, #129
MOVS	R0, #255
BL	_rptPix+0
;J3_OLED_SH1106.c,177 :: 		}
L_end_barDisplay:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _barDisplay
_sendGlyphs:
;J3_OLED_SH1106.c,178 :: 		void sendGlyphs(const unsigned char *pRow, unsigned char size){ //Send any font row to print character
; size start address is: 4 (R1)
; pRow start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; size end address is: 4 (R1)
; pRow end address is: 0 (R0)
; pRow start address is: 0 (R0)
; size start address is: 4 (R1)
;J3_OLED_SH1106.c,180 :: 		for (count = 0 ; count < size ; count++)  // Send row to print the character
; count start address is: 32 (R8)
MOVW	R8, #0
; pRow end address is: 0 (R0)
; size end address is: 4 (R1)
; count end address is: 32 (R8)
MOV	R6, R0
UXTB	R5, R1
L_sendGlyphs25:
; count start address is: 32 (R8)
; pRow start address is: 24 (R6)
; size start address is: 20 (R5)
; pRow start address is: 24 (R6)
; pRow end address is: 24 (R6)
CMP	R8, R5
IT	CS
BCS	L_sendGlyphs26
; pRow end address is: 24 (R6)
;J3_OLED_SH1106.c,182 :: 		sendData(pRow[count]);
; pRow start address is: 24 (R6)
ADD	R2, R6, R8, LSL #0
LDRB	R2, [R2, #0]
UXTB	R0, R2
BL	_sendData+0
;J3_OLED_SH1106.c,180 :: 		for (count = 0 ; count < size ; count++)  // Send row to print the character
ADD	R8, R8, #1
UXTB	R8, R8
;J3_OLED_SH1106.c,183 :: 		}
; size end address is: 20 (R5)
; pRow end address is: 24 (R6)
; count end address is: 32 (R8)
IT	AL
BAL	L_sendGlyphs25
L_sendGlyphs26:
;J3_OLED_SH1106.c,184 :: 		sendData(0x00);  // 1 pixel horizontal space after character
MOVS	R0, #0
BL	_sendData+0
;J3_OLED_SH1106.c,185 :: 		}
L_end_sendGlyphs:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _sendGlyphs
_charFont5:
;J3_OLED_SH1106.c,186 :: 		void charFont5(unsigned char character){ // MODIFY IF FONT RANGE CHANGED
; character start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; character end address is: 0 (R0)
; character start address is: 0 (R0)
;J3_OLED_SH1106.c,188 :: 		if (character == ' ')  // munge ' ' to empty ';' character
CMP	R0, #32
IT	NE
BNE	L__charFont534
;J3_OLED_SH1106.c,189 :: 		{ character = ';' ; }
MOVS	R0, #59
; character end address is: 0 (R0)
IT	AL
BAL	L_charFont528
L__charFont534:
;J3_OLED_SH1106.c,188 :: 		if (character == ' ')  // munge ' ' to empty ';' character
;J3_OLED_SH1106.c,189 :: 		{ character = ';' ; }
L_charFont528:
;J3_OLED_SH1106.c,193 :: 		sendGlyphs(font5[character - '.'], sizeof font5[0]);
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
;J3_OLED_SH1106.c,194 :: 		}
L_end_charFont5:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _charFont5
_strFont5:
;J3_OLED_SH1106.c,196 :: 		void strFont5(unsigned char s[])
; s start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
; s end address is: 0 (R0)
; s start address is: 0 (R0)
MOV	R9, R0
; s end address is: 0 (R0)
;J3_OLED_SH1106.c,198 :: 		while(*s) {charFont5(*s++);} // Points to character, or terminator
L_strFont529:
; s start address is: 36 (R9)
LDRB	R1, [R9, #0]
CMP	R1, #0
IT	EQ
BEQ	L_strFont530
LDRB	R1, [R9, #0]
UXTB	R0, R1
BL	_charFont5+0
ADD	R9, R9, #1
; s end address is: 36 (R9)
IT	AL
BAL	L_strFont529
L_strFont530:
;J3_OLED_SH1106.c,199 :: 		}
L_end_strFont5:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _strFont5
