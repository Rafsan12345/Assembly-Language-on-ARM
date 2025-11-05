.syntax unified
.cpu cortex-m3
.thumb

.data
.global simple_result
simple_result: .word 0

.text
.global simple_op
.type simple_op, %function

simple_op:
    push {r4, lr}        @ save r4 and return address

    mov r0, #10
    mov r1, #5
    add r2, r0, r1       @ r2 = 15

    ldr r4, =simple_result
    str r2, [r4]         @ store result in global variable

    mov r0, r2           @ return value
    pop {r4, lr}         @ restore registers
    bx lr
