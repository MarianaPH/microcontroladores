#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)     

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program

i equ 0x30        ;variable i en la localidad 0x30
dado equ 0x31


START              ;inicio global del programa


    MOVLW 0x07         ;Apagar comparadores para trabajar en modo digital
    MOVWF CMCON    
    BCF STATUS, RP1    ;Cambiar al banco 1 apagando el RP1//bit clear 
    BSF STATUS, RP0    ;Y encendiendo el RP0//bit set
    MOVLW b'00000001'  ;Establecer puerto A0 como entrada (los 8 bits del puerto)
    MOVWF TRISA 
    MOVLW b'00000000'  ;Establecer puerto B como salida (los 8 bits del puerto)
    MOVWF TRISB 
    BCF STATUS, RP0    ;Regresar al banco 0 apagando el RP0

INICIO
;Aquí va la rutina principal
    MOVLW d'255'
    MOVWF i    
    MOVLW d'6'
    MOVWF dado
    
DESPLEGAR
    
    MOVFW dado
    MOVWF PORTB
    
BOTON
    BTFSS PORTA,0
    GOTO BOTON
    
DELAY
    
    DECFSZ i
    GOTO DELAY
    MOVLW 255
    MOVWF i
    
    DECFSZ dado, f
    GOTO DESPLEGAR
    GOTO INICIO
    
    
    GOTO INICIO        ;loop inicio			
    END