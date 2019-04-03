;
; Project1-1.asm
;
; Created: 3/24/2019 6:06:13 PM
; Author : warho
;


; Replace with your application code



.org 0

	LDI R26, HIGH(RAMEND)
	OUT SPH, R26
	LDI R26, LOW(RAMEND)
	OUT SPL, R26
    LDI R16, 0xFF
	OUT DDRC, R16
	OUT DDRD, R16
	OUT DDRE, R16
	CBI DDRA, 0
	SBI PORTA, 0
	CBI DDRA, 1
	SBI PORTA, 1
	CBI DDRA, 2
	SBI PORTA, 2
	CBI DDRA, 3
	SBI PORTA, 3
	CBI DDRA, 4
	SBI PORTA, 4
	CBI DDRA, 5
	SBI PORTA, 5


	LDI R20, 0x00
	LDI R21, 0x00
	LDI R22, 0x00
	LDI R27, 0x00
	LDI R28, 0x00
	LDI R31, 0x00

START:
	SBIC PINA, 0
	RJMP INCREMENT_PRESS
	SBIC PINA, 1
	RJMP DECREMENT_PRESS
	SBIC PINA, 2
	RCALL BUZZ
	SBIC PINA, 3
	RJMP SPIN_WHEEL_PRESS
	SBIC PINA, 4
	RJMP PLAY_A_SONG
	SBIC PINA, 5
	RJMP MINICOUNT
	RJMP START

INCREMENT_PRESS:
	SBIS PINA, 0
	RJMP INCREMENT
	RJMP INCREMENT_PRESS

INCREMENT:
	INC R20
	BRHS BUZZ
	OUT PORTD, R20
	RCALL DELAY1
	OUT PORTD, R31
	RJMP START

DECREMENT_PRESS:
	SBIS PINA, 1
	RJMP DECREMENT
	RJMP DECREMENT_PRESS

DECREMENT:
	DEC R20
	BRHS BUZZ 
	OUT PORTD, R20
	RCALL DELAY1
	OUT PORTD, R31
	RJMP START

BUZZ:
	SBI PORTE, 4
	RCALL DELAY1
	NOP
	NOP
	CBI PORTE, 4
	RCALL DELAY1
	SBIC PINA, 2
	RJMP BUZZ
	RET

MINICOUNT:
	LDI R29, 0x0A
	LDI R30, 0x00
LOOPX:
	CALL SEVSEG
	INC R30
	DEC R29
	BRNE START
	RJMP LOOPX 

SPIN_WHEEL_PRESS:
	OUT PORTD, R16
	LDI R22, 0x01
	SBIS PINA, 3
	RJMP SPIN_WHEEL
	INC R21
	RJMP SPIN_WHEEL_PRESS

SPIN_WHEEL:
	ROR R21
	BRCC SKIP_MULT1
	LSL R22
SKIP_MULT1:
	ROR R21
	BRCC SKIP_MULT2
	LSL R22
	LSL R22
SKIP_MULT2:
	ROR R21
	BRCC SKIP_MULT3
	LSL R22
	LSL R22
	LSL R22
	LSL R22
SKIP_MULT3:
	OUT PORTD, R22
	RCALL DELAY2
	LSL R22
	BRCC FULL_SPIN1
	LDI R22, 0x01
FULL_SPIN1:
	OUT PORTD, R22
	RCALL DELAY2
	LSL R22
	BRCC FULL_SPIN2
	LDI R22, 0x01
FULL_SPIN2:
	OUT PORTD, R22
	RCALL DELAY2
	RCALL DELAY2
	LSL R22
	BRCC FULL_SPIN3
	LDI R22, 0x01
FULL_SPIN3:
	OUT PORTD, R22
	RCALL DELAY2
	RCALL DELAY2
	RCALL DELAY2
	LSL R22
	BRCC FULL_SPIN4
	LDI R22, 0x01
FULL_SPIN4:
	OUT PORTD, R22
	RCALL DELAY2
	RCALL DELAY2
	RCALL DELAY2
	RCALL DELAY2
	RCALL DELAY2
	RJMP START

DELAY1:
	LDI R17, 100
LOOP12:
	LDI R18, 13
LOOP11:
	DEC R18
	BRNE LOOP11
	DEC R17
	BRNE LOOP12
	RET

DELAY2:
	LDI R17, 90
LOOP23:
	LDI R18, 100
LOOP22:
	LDI R19, 100
LOOP21:
	DEC R19
	BRNE LOOP21
	DEC R18
	BRNE LOOP22
	DEC R17
	BRNE LOOP23
	RET

SEVSEG:
	CP R27, R30
	BRNE NOT_0
	CALL NUM_0
NOT_0:	CP R27, R30
	BRNE NOT_1
	CALL NUM_1
NOT_1:	CP R27, R30
	BRNE NOT_2
	CALL NUM_2
NOT_2:	CP R27, R30
	BRNE NOT_3
	CALL NUM_3
NOT_3:	CP R27, R30
	BRNE NOT_4
	CALL NUM_4
NOT_4:	CP R27, R30
	BRNE NOT_5
	CALL NUM_5
NOT_5:	CP R27, R30
	BRNE NOT_6
	CALL NUM_6
NOT_6:	CP R27, R30
	BRNE NOT_7
	CALL NUM_7
NOT_7:	CP R27, R30
	BRNE NOT_8
	CALL NUM_8
NOT_8:	CALL NUM_9
	RET		

PLAY_A_SONG:
	SBIS PINA, 4
	RCALL QUARTERE
	RCALL QUARTERE
	RCALL QUARTERF
	RCALL QUARTERG
	RCALL QUARTERG
	RCALL QUARTERF
	RCALL QUARTERE
	RCALL QUARTERD
	RCALL QUARTERC
	RCALL QUARTERC
	RCALL QUARTERD
	RCALL QUARTERE
	RCALL QUARTERE
	RCALL QUARTERD
	RCALL HALFD
	RJMP LINE2_4
	RCALL QUARTERD
	RCALL QUARTERD
	RCALL QUARTERE
	RCALL QUARTERC
	RCALL QUARTERD
	RCALL QUARTERF
	RCALL QUARTERE
	RCALL QUARTERC
	RCALL QUARTERD
	RCALL QUARTERF
	RCALL QUARTERE
	RCALL QUARTERD
	RCALL QUARTERC
	RCALL QUARTERD
	RCALL HALFG
	RJMP LINE2_4
	RJMP START

LINE2_4:
	RCALL QUARTERE
	RCALL QUARTERE
	RCALL QUARTERF
	RCALL QUARTERG
	RCALL QUARTERG
	RCALL QUARTERF
	RCALL QUARTERE
	RCALL QUARTERD
	RCALL QUARTERC
	RCALL QUARTERC
	RCALL QUARTERD
	RCALL QUARTERE
	RCALL QUARTERD
	RCALL QUARTERC
	RCALL HALFC

QUARTERG:
	LDI R23, 0xE1
LOOP3G:
	LDI R24, 0xED
LOOP2G:
	LDI R25, 0x31
LOOP1G:
	SBI PORTA, 4
	RCALL DELAYG
	CBI PORTA, 4
	RCALL DELAYG
	DEC R25
	BRNE LOOP1G
	DEC R24
	BRNE LOOP2G
	DEC R23
	BRNE LOOP3G
	RET

DELAYG:
	LDI R23, 0x04
LOOP2Ga:
	LDI R24, 0xD3
LOOP1Ga:
	DEC R24
	BRNE LOOP1Ga
	DEC R23
	BRNE LOOP2Ga
	RET

QUARTERF:
	LDI R23, 0xE1
LOOP3F:
	LDI R24, 0xED
LOOP2F:
	LDI R25, 0x31
LOOP1F:
	SBI PORTA, 4
	RCALL DELAYF
	CBI PORTA, 4
	RCALL DELAYF
	DEC R25
	BRNE LOOP1F
	DEC R24
	BRNE LOOP2F
	DEC R23
	BRNE LOOP3F
	RET

DELAYF:
	LDI R23, 0x04
LOOP2Fa:
	LDI R24, 0xED
LOOP1Fa:
	DEC R24
	BRNE LOOP1Fa
	DEC R23
	BRNE LOOP2Fa
	RET

QUARTERE:
	LDI R23, 0xE1
LOOP3E:
	LDI R24, 0xED
LOOP2E:
	LDI R25, 0x31
LOOP1E:
	SBI PORTA, 4
	RCALL DELAYE
	CBI PORTA, 4
	RCALL DELAYE
	DEC R25
	BRNE LOOP1E
	DEC R24
	BRNE LOOP2E
	DEC R23
	BRNE LOOP3E
	RET

DELAYE:
	LDI R23, 0x04
LOOP2Ea:
	LDI R24, 0xFB
LOOP1Ea:
	DEC R24
	BRNE LOOP1Ea
	DEC R23
	BRNE LOOP2Ea
	RET

QUARTERD:
	LDI R23, 0xE1
LOOP3D:
	LDI R24, 0xED
LOOP2D:
	LDI R25, 0x31
LOOP1D:
	SBI PORTA, 4
	RCALL DELAYD
	CBI PORTA, 4
	RCALL DELAYD
	DEC R25
	BRNE LOOP1D
	DEC R24
	BRNE LOOP2D
	DEC R23
	BRNE LOOP3D
	RET

DELAYD:
	LDI R23, 0x0D
LOOP2Da:
	LDI R24, 0x56
LOOP1Da:
	DEC R24
	BRNE LOOP1Da
	DEC R23
	BRNE LOOP2Da
	RET

QUARTERC:
	LDI R23, 0xE1
LOOP3C:
	LDI R24, 0xED
LOOP2C:
	LDI R25, 0x31
LOOP1C:
	SBI PORTA, 4
	RCALL DELAYC
	CBI PORTA, 4
	RCALL DELAYC
	DEC R25
	BRNE LOOP1C
	DEC R24
	BRNE LOOP2C
	DEC R23
	BRNE LOOP3C
	RET

DELAYC:
	LDI R23, 0x09
LOOP2Ca:
	LDI R24, 0x8C
LOOP1Ca:
	DEC R24
	BRNE LOOP1Ca
	DEC R23
	BRNE LOOP2Ca
	RET

HALFG:
	LDI R23, 0xF5
LOOP3GH:
	LDI R24, 0xF2
LOOP2GH:
	LDI R25, 0x59
LOOP1GH:
	SBI PORTA, 4
	RCALL DELAYG
	CBI PORTA, 4
	RCALL DELAYG
	DEC R25
	BRNE LOOP1GH
	DEC R24
	BRNE LOOP2GH
	DEC R23
	BRNE LOOP3GH
	RET

HALFD:
	LDI R23, 0xF5
LOOP3DH:
	LDI R24, 0xF2
LOOP2DH:
	LDI R25, 0x59
LOOP1DH:
	SBI PORTA, 4
	RCALL DELAYD
	CBI PORTA, 4
	RCALL DELAYD
	DEC R25
	BRNE LOOP1DH
	DEC R24
	BRNE LOOP2DH
	DEC R23
	BRNE LOOP3DH
	RET


HALFC:
	LDI R23, 0xF5
LOOP3CH:
	LDI R24, 0xF2
LOOP2CH:
	LDI R25, 0x59
LOOP1CH:
	SBI PORTA, 4
	RCALL DELAYC
	CBI PORTA, 4
	RCALL DELAYC
	DEC R25
	BRNE LOOP1CH
	DEC R24
	BRNE LOOP2CH
	DEC R23
	BRNE LOOP3CH
	RET

NUM_0:	
	SBI PORTD, 0	; Turns on necessary LEDs, waits some time, then
	SBI PORTD, 1	; turns them off
	SBI PORTD, 2
	SBI PORTD, 3
	SBI PORTD, 5
	SBI PORTD, 4
	SBI PORTD, 6
	SBI PORTD, 7
	CALL DELAY1
	CBI PORTD, 0
	CBI PORTD, 1
	CBI PORTD, 2
	CBI PORTD, 3
	CBI PORTD, 5
	CBI PORTD, 4
	CBI PORTD, 6
	CBI PORTD, 7
	RET

NUM_1:	
	SBI PORTD, 3
	SBI PORTD, 6
	SBI PORTD, 7
	CALL DELAY1
	CBI PORTD, 3
	CBI PORTD, 6
	CBI PORTD, 7
	RET	

NUM_2:	
	SBI PORTD, 0
	SBI PORTD, 7
	CALL DELAY1
	CBI PORTD, 0
	CBI PORTD, 7
	RET

NUM_3:	
	SBI PORTD, 0
	SBI PORTD, 1
	SBI PORTD, 2
	SBI PORTE, 5
	SBI PORTD, 4
	SBI PORTD, 5
	SBI PORTD, 6
	SBI PORTD, 7
	CALL DELAY1
	CBI PORTD, 0
	CBI PORTD, 1
	CBI PORTD, 2
	CBI PORTE, 5
	CBI PORTD, 4
	CBI PORTD, 5
	CBI PORTD, 6
	CBI PORTD, 7
	RET

NUM_4:	
	SBI PORTD, 0
	SBI PORTD, 2
	SBI PORTD, 3
	SBI PORTE, 5
	SBI PORTD, 4
	SBI PORTD, 7
	CALL DELAY1
	CBI PORTD, 0
	CBI PORTD, 2
	CBI PORTD, 3
	CBI PORTE, 5
	CBI PORTD, 4
	CBI PORTD, 7
	RET

NUM_5:	
	SBI PORTD, 0
	SBI PORTD, 2
	SBI PORTE, 5
	SBI PORTD, 5
	SBI PORTD, 7
	CALL DELAY1
	CBI PORTD, 0
	CBI PORTD, 2
	CBI PORTE, 5
	CBI PORTD, 5
	CBI PORTD, 7
	RET

NUM_6:	
	SBI PORTD, 0
	SBI PORTD, 2
	SBI PORTD, 3
	SBI PORTD, 4
	SBI PORTD, 5
	SBI PORTD, 7
	CALL DELAY1
	CBI PORTD, 0
	CBI PORTD, 2
	CBI PORTD, 3
	CBI PORTD, 4
	CBI PORTD, 5
	CBI PORTD, 7
	RET

NUM_7:	
	SBI PORTD, 0
	SBI PORTD, 1
	SBI PORTD, 2
	SBI PORTD, 4
	SBI PORTD, 7
	CALL DELAY1
	CBI PORTD, 0
	CBI PORTD, 1
	CBI PORTD, 2
	CBI PORTD, 4
	CBI PORTD, 7
	RET

NUM_8:	
	SBI PORTD, 0
	SBI PORTD, 1
	SBI PORTD, 2
	SBI PORTD, 3
	SBI PORTE, 5
	SBI PORTD, 4
	SBI PORTD, 5
	SBI PORTD, 6
	SBI PORTD, 7
	CALL DELAY1
	CBI PORTD, 0
	CBI PORTD, 1
	CBI PORTD, 2
	CBI PORTD, 3
	CBI PORTE, 5
	CBI PORTD, 4
	CBI PORTD, 5
	CBI PORTD, 6
	CBI PORTD, 7
	RET

NUM_9:
	SBI PORTD, 1
	SBI PORTD, 2
	SBI PORTE, 5
	SBI PORTD, 4
	SBI PORTD, 7
	CALL DELAY1
	CBI PORTD, 1
	CBI PORTD, 2
	CBI PORTE, 5
	CBI PORTD, 4
	CBI PORTD, 7
	RET