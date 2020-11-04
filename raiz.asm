include "p16F628a.inc"    ;incluir librerias relacionadas con el dispositivo
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
;configuración del dispositivotodo en OFF y la frecuencia de oscilador
;es la del "reloj del oscilador interno" (INTOSCCLK)

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
; TODO ADD INTERRUPTS HERE IF USED
MAIN_PROG CODE                      ; let linker place main program
 
 
i equ 0x30
j equ 0x31
k equ 0x32
l equ 0x33 
m equ 0x34 
aux equ 0x35


START              ;inicio global del programa

    MOVLW 0x07         ;Apagar comparadores para trabajar en modo digital
    MOVWF CMCON
    BCF STATUS, RP1    ;Cambiar al banco 1 apagando el RP1
    BSF STATUS, RP0 
    MOVLW b'00000000'  ;Establecer puerto B como salida (los 8 bits del puerto)
    MOVWF TRISB 
    MOVLW b'11111111'
    MOVWF TRISA
    BCF STATUS, RP0    ;Regresar al banco 0 apagando el RP0
 
Codigo
    CLRW 
    MOVFW PORTA
    MOVWF i
    MOVWF m

    MOVLW b'10000000'
    MOVWF l
    MOVWF j
    MOVWF aux
    DECFSZ aux

Ciclo
    BCF STATUS, C
    ADDWF j,0
    BTFSC STATUS, C
    GOTO Raiz

    DECFSZ aux
    GOTO Ciclo

    SUBWF m,1
    BTFSC STATUS,Z
    GOTO Mostrar

    BTFSS STATUS,C 
    GOTO Raiz
    GOTO Almacena

Almacena
    MOVFW l
    ADDWF k,1
    GOTO Raiz

Raiz
    BCF STATUS, C
    RRF l,1

    MOVLW d'0'
    SUBWF l,0
    BTFSC STATUS,Z
    GOTO Codigo

    CLRW
    MOVFW i
    MOVWF m

    MOVFW l
    ADDWF k,0
    MOVWF j
    MOVWF aux
    DECFSZ aux
    GOTO Ciclo

Mostrar
    MOVFW l
    ADDWF k,1
    MOVFW k
    MOVWF PORTB
    GOTO Codigo
END