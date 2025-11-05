.syntax unified
.cpu cortex-m3
.thumb
.global main2
.global adc_result

	.equ RCC_BASE, 0x40021000
	.equ RCC_APB2ENR, 0x18
	.equ RCC_APB2ENR_ADC1EN, (1<<9)   @ ADC1 clock enable bit

	.equ ADC1_BASE, 0x40012400
	.equ ADC1_SR,   0x00
	.equ ADC1_CR2,  0x08
	.equ ADC1_SMPR2,0x10
	.equ ADC1_SQR3, 0x34
	.equ ADC1_DR,   0x4C

	.equ ADC_SR_EOC,      (1<<1)
	.equ ADC_CR2_ADON,   (1<<0)
	.equ ADC_CR2_SWSTART,(1<<22)

.data
adc_result: .word 0

.text
main2:
    @ -------- Enable ADC1 clock (APB2ENR) --------
    LDR  R0, =RCC_BASE + RCC_APB2ENR
    LDR  R1, [R0]
    ORR  R1, R1, #RCC_APB2ENR_ADC1EN
    STR  R1, [R0]

    @ -------- Enable ADC --------
    LDR  R0, =ADC1_BASE + ADC1_CR2
    LDR  R1, [R0]
    ORR  R1, R1, #ADC_CR2_ADON
    STR  R1, [R0]

    @ -------- Set sampling time for channel 0 --------
    LDR  R0, =ADC1_BASE + ADC1_SMPR2
    LDR  R1, [R0]
    BIC  R1, R1, #0x7       @ clear bits 2:0
    ORR  R1, R1, #0x2       @ example: 55.5 cycles
    STR  R1, [R0]

    @ -------- Select channel 0 in SQR3 --------
    LDR  R0, =ADC1_BASE + ADC1_SQR3
    MOV  R1, #0
    STR  R1, [R0]

    @ -------- Start conversion --------
    LDR  R0, =ADC1_BASE + ADC1_CR2
    LDR  R1, [R0]
    ORR  R1, R1, #ADC_CR2_SWSTART
    STR  R1, [R0]

wait_eoc:
    @ -------- Wait for conversion to finish --------
    LDR  R0, =ADC1_BASE + ADC1_SR
    LDR  R1, [R0]
    TST  R1, #ADC_SR_EOC
    BEQ  wait_eoc

    @ -------- Read ADC data register --------
    LDR  R0, =ADC1_BASE + ADC1_DR
    LDR  R1, [R0]

    @ -------- Store result in global variable --------
    LDR  R0, =adc_result
    STR  R1, [R0]

    @BX LR
    B wait_eoc
