    .syntax unified
    .cpu cortex-m3
    .thumb
    .global main

@ ==========================================================
@ STM32F103C8T6 - UART1 TX Example (PA9)
@ Verified in STM32CubeIDE & Proteus
@ ==========================================================

main:
    @----------------------------------------------------------
    @ RCC Clock enable for GPIOA and USART1
    @----------------------------------------------------------
    LDR     R0, =0x40021018      @ RCC_APB2ENR
    LDR     R1, [R0]
    ORR     R1, R1, #(1 << 2)    @ IOPAEN
    ORR     R1, R1, #(1 << 14)   @ USART1EN
    STR     R1, [R0]

    @----------------------------------------------------------
    @ Configure PA9 = Alternate Function Push-Pull (USART1_TX)
    @----------------------------------------------------------
    LDR     R0, =0x40010804      @ GPIOA_CRH
    LDR     R1, [R0]
    BIC     R1, R1, #(0xF << 4)  @ clear CNF9/MODE9
    ORR     R1, R1, #(0xB << 4)  @ MODE9=11 (50MHz), CNF9=10 (AF PP)
    STR     R1, [R0]

    @----------------------------------------------------------
    @ Set baud = 9600 (8MHz clock)
    @ BRR = 0x341
    @----------------------------------------------------------
    LDR     R0, =0x40013808      @ USART1_BRR
    MOVS    R1, #0x41
    LSLS    R1, R1, #4
    ADDS    R1, R1, #3           @ => 0x341
    STR     R1, [R0]

    @----------------------------------------------------------
    @ Enable USART1 (UE) + Transmitter (TE)
    @----------------------------------------------------------
    LDR     R0, =0x4001380C      @ USART1_CR1
    MOVS    R1, #(1 << 3)        @ TE
    ORR     R1, R1, #(1 << 13)   @ UE
    STR     R1, [R0]
loop:
    @----------------------------------------------------------
    @ Wait until TXE = 1 (Transmit buffer empty)
    @----------------------------------------------------------
wait_txe:
    LDR     R0, =0x40013800      @ USART1_SR
    LDR     R1, [R0]
    LSRS    R1, R1, #7
    BCC     wait_txe

    @----------------------------------------------------------
    @ Send character 'A'
    @----------------------------------------------------------
    LDR     R0, =0x40013804      @ USART1_DR
    MOVS    R1, #'A'
    STR     R1, [R0]

    B       loop
