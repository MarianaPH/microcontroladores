#include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)     

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program

i equ 0x60
j equ 0x61
k equ 0x62
r equ 0x63


START              ;inicio global del programa


    MOVLW 0x07         ;Apagar comparadores para trabajar en modo digital
    MOVWF CMCON    
    BCF STATUS, RP1    ;Cambiar al banco 1 apagando el RP1
    BSF STATUS, RP0    ;Y encendiendo el RP0
    MOVLW b'00000000'  ;Establecer puerto B como salida (los 8 bits del puerto)
    MOVWF TRISB 
    BCF STATUS, RP0    ;Regresar al banco 0 apagando el RP0

INICIO

    ;Ejercicio nombres
    MOVLW 'M'
    MOVWF 0X20
    MOVLW 'A'
    MOVWF 0X21
    MOVLW 'R'
    MOVWF 0X22
    MOVLW 'I'
    MOVWF 0X23
    MOVLW 'A'
    MOVWF 0X24
    MOVLW 'N'
    MOVWF 0X25
    MOVLW 'A'
    MOVWF 0X26
    
    MOVLW 'P'
    MOVWF 0X30
    MOVLW 'E'
    MOVWF 0X31
    MOVLW 'N'
    MOVWF 0X32
    MOVLW 'A'
    MOVWF 0X33
    
    
    MOVLW 'H'
    MOVWF 0X40
    MOVLW 'E'
    MOVWF 0X41
    MOVLW 'R'
    MOVWF 0X42
    MOVLW 'N'
    MOVWF 0X43
    MOVLW 'A'
    MOVWF 0X44
    MOVLW 'N'
    MOVWF 0X45
    MOVLW 'D'
    MOVWF 0X46
    MOVLW 'E'
    MOVWF 0X47
    MOVLW 'Z'
    MOVWF 0X48
    
    
    
    ;Ejercicio suma
    MOVLW 7 ; MARIANA
    MOVWF i
    MOVLW 4 ; PENA
    MOVWF j
    MOVLW 9 ; HERNANDEZ
    MOVWF k
    
    CLRF r
    MOVFW i
    ADDWF r, f
    MOVFW j
    ADDWF r, f
    MOVFW k
    ADDWF r, f
    
    
    GOTO INICIO
    
END
