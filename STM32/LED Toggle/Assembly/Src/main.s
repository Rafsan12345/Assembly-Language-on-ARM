.syntax unified
.cpu cortex-m3
.thumb
.global main

@ ============================================================
@ STM32F103C8T6 Blue Pill - LED Blink (PC13)
@ ============================================================

.equ RCC_BASE, 0x40021000
.equ RCC_APB2ENR, 0x18
.equ IOPCEN, 4

.equ GPIOC_BASE, 0x40011000
.equ GPIOC_CRH, 0x04
.equ GPIOC_ODR, 0x0C
.equ PC13, 13

main:
    @ Enable GPIOC Clock
    LDR R0, =RCC_BASE
    LDR R1, [R0, #RCC_APB2ENR]
    ORR R1, R1, #(1 << IOPCEN)
    STR R1, [R0, #RCC_APB2ENR]

    @ Configure PC13 as output
    LDR R0, =GPIOC_BASE
    LDR R1, [R0, #GPIOC_CRH]
    BIC R1, R1, #(0xF << 20)
    ORR R1, R1, #(0x1 << 20)
    STR R1, [R0, #GPIOC_CRH]

loop:
    LDR R1, [R0, #GPIOC_ODR]
    EOR R1, R1, #(1 << PC13)
    STR R1, [R0, #GPIOC_ODR]
    BL delay
    B loop

delay:
    MOV R2, #0xFF
outer_loop:
    MOV R3, #0xFF
inner_loop:
    SUBS R3, R3, #1
    BNE inner_loop
    SUBS R2, R2, #1
    BNE outer_loop
    BX LR
