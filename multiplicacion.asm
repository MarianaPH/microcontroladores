#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)     

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program

m equ 0x30
cont equ 0x31
resultado equ 0x32
n equ 0x33
 
START              ;inicio global del programa

    MOVLW 0x07         ;Apagar comparadores para trabajar en modo digital
    MOVWF CMCON    
    BCF STATUS, RP1    ;Cambiar al banco 1 apagando el RP1
    BSF STATUS, RP0    ;Y encendiendo el RP0
    MOVLW b'11111111'  ;Establecer puerto B como salida (los 8 bits del puerto)
    MOVWF TRISA
    MOVLW b'00000000'
    MOVWF TRISB
    BCF STATUS, RP0    ;Regresar al banco 0 apagando el RP0
    
inicio: 
    MOVLW b'00001111';Guarda binario a w
    MOVWF m;El contenido de w lo guardamos en 
    MOVFW PORTA  ;Guarda PortA en W  -->Es para una variable
    ANDWF m,1  ;Hace una operacion And entre w = PORTA y la variable que le pongamos     
    
    MOVLW b'11110000'
    MOVWF n
    MOVFW PORTA
    ANDWF n,1 
    SWAPF n,1
    
    CLRW
    
loop: 
    ADDWF n, 0 ;Sumar al registro w
    DECFSZ m   ;Reduce uno 
    GOTO loop
    MOVWF PORTB
    
GOTO inicio
    
END
    