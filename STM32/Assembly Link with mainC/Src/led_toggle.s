.syntax unified
.cpu cortex-m3
.thumb
.global led_toggle_asm

.equ RCC_BASE,       0x40021000
.equ RCC_APB2ENR,    0x18
.equ RCC_FULL,       (RCC_BASE + RCC_APB2ENR)

@ Correct bit for enabling GPIOC clock = bit 4
.equ IOPCEN,         (1 << 4)         @ 0x10

.equ GPIOC_BASE,     0x40011000
.equ GPIOC_CRH,      0x04
.equ GPIOC_FULL,     (GPIOC_BASE + GPIOC_CRH)

.equ GPIOC_ODR,      0x0C
.equ GPIOC_FULL_ODR, (GPIOC_BASE + GPIOC_ODR)

.equ PC13,           13

@ MODE = 0b0010 -> MODE13[1:0] = 10 (output 2 MHz), CNF13[1:0]=00 (push-pull)
.equ MODER,          (0b0010 << 20)   @ bits for pin13 in CRH (pins 8..15 start at bit 0 -> pin13 is bits 20..23)

@ Simple delay count (tune as needed)
.equ DELAY_COUNT,    300000

@ ------------------------------------------------------------
@ main
@ ------------------------------------------------------------
led_toggle_asm:
    @ --- enable GPIOC clock
    LDR   R0, =RCC_FULL
    LDR   R1, [R0]           @ read APB2ENR
    ORR   R1, R1, #IOPCEN
    STR   R1, [R0]           @ write back

    @ small nop-ish wait so peripheral clock is stable (optional)

    @ --- configure PC13 as output push-pull, 2MHz (modify CRH)
    LDR   R0, =GPIOC_FULL
    LDR   R1, [R0]           @ read CRH
    BIC   R1, R1, #(0xF << 20) @ clear bits 23..20 (for pin13)
    ORR   R1, R1, #MODER
    STR   R1, [R0]           @ write back CRH

    @ Optionally set ODR initial state (turn LED off -> set bit = 1 for PC13 since LED active-low)
    LDR   R0, =GPIOC_FULL_ODR
    LDR   R1, [R0]
    ORR   R1, R1, #(1 << PC13)
    STR   R1, [R0]

loop_toggle:
    LDR   R0, =GPIOC_FULL_ODR
    LDR   R1, [R0]                @ read ODR
    EOR   R1, R1, #(1 << PC13)    @ toggle bit13
    STR   R1, [R0]                @ write back
    B     loop_toggle
