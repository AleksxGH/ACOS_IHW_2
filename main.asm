.include "macros.asm"

.data
msg_in:  .string "Введите x: "
msg_out: .string "Вы ввели: "

.text
.globl main
main:
    # выводим приглашение
    li a7, 4
    la a0, msg_in
    ecall

    # читаем double
    INPUT_DOUBLE(f2)
    
    # выводим пояснение
    li a7, 4
    la a0, msg_out
    ecall

    # выводим введённое значение
    PRINT_DOUBLE(f2)

    # завершение программы
	EXIT_PROGRAM
