.include "macros.asm"
.include "math.asm"

.data
msg_in:  .string "Введите x: "
msg_out: .string "ch(x)≈ "

.text
.globl main
main:
    # выводим приглашение
    li a7, 4
    la a0, msg_in
    ecall

    # читаем double
    INPUT_DOUBLE(f2) 			# f2=x
    
    # считаем значение ch(x)
    CALC_COSH(f2, f12) 		#f2=x, f12 = ch(x)
	
	# выводим пояснение
	li a7, 4
    la a0, msg_out
    ecall
    
    # выводим значение ch(x)
    PRINT_DOUBLE(f12)

    # завершение программы
	EXIT_PROGRAM