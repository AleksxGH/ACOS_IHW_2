# Тестирование макроса CALC_COSH на наборе значений x_list
.include "macros.asm"
.include "math.asm"

.data
msg_x:     .string "x = "
msg_chx:   .string "   ch(x) = "

# тестовые значения
x_list:    .double 0.0, 1.0, 2.0, 3.0, 0.2, 5.6, -0.5
n_values:  .word 7

.text
.globl main
main:
    la t0, x_list          # адрес начала массива x_list
    lw t1, n_values        # количество элементов
    li t2, 0               # i = 0

TEST_LOOP:
    bge t2, t1, END_TESTS  # если i >= n, конец тестов

    # загрузить x из массива
    fld f2, 0(t0)          # f2 = x_i

    # вычислить ch(x)
    CALC_COSH f2, f12      # f12 = ch(x)

    # вывести "x = "
    li a7, 4
    la a0, msg_x
    ecall

    # вывести значение x
    fmv.d fa0, f2
    li a7, 3               # print double
    ecall

    # вывести "   ch(x) = "
    li a7, 4
    la a0, msg_chx
    ecall

    # вывести значение cosh(x)
    fmv.d fa0, f12
    li a7, 3
    ecall

    # перевод строки
    li a7, 4
    la a0, new_line
    ecall

    # переход к следующему x
    addi t2, t2, 1
    addi t0, t0, 8         # double занимает 8 байт
    j TEST_LOOP

END_TESTS:
    EXIT_PROGRAM
