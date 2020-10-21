#include "p16F628a.inc"
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF

RES_VECT CODE 0x0000 ; processor reset vector
GOTO START ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE ; let linker place main program

i equ 0x30
j equ 0x31
k equ 0x32
m equ 0x33

START
    MOVLW 0x07
    MOVWF CMCON
    BCF STATUS, RP1
    BSF STATUS, RP0
    MOVLW b'00000000'
    MOVWF TRISB
    BCF STATUS, RP0
    
inicio:
    MOVLW d'10'
    MOVWF m
    clrf PORTB
    BSF PORTB, 0
    BSF PORTB, 5
    loop: call time 
    DECFSZ m
    goto loop 
    BCF PORTB, 5
    BSF PORTB, 4
    call time 
    nop 
    nop
    nop
    call time 
    nop
    BCF PORTB, 4
    BCF PORTB, 0
    
    MOVLW d'10'
    MOVWF m
    BSF PORTB, 2
    BSF PORTB, 3
    loop2: call time 
    DECFSZ m
    goto loop2
    BCF PORTB, 2
    BSF PORTB, 1
    call time
    nop
    nop
    call time
    nop
    BCF PORTB, 3
    BCF PORTB, 1
    nop
    nop
    GOTO inicio 
    
    
time 
      MOVLW d'54'
      MOVWF i
      nop
      nop
      nop
      nop
      nop
      nop
      loopj: MOVLW d'68' 
	     MOVWF j
	      nop
	      nop
	      nop
	      nop
	      nop
	      nop
	      nop
      loopk: MOVLW d'44'
	     MOVWF k
	     DECFSZ k
	     GOTO $-1
	     DECFSZ j
	     GOTO loopk
	     DECFSZ i
	     GOTO loopj
      return
  
END
      