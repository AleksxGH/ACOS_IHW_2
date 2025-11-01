#Макрос для ввода вещественного числа
.macro INPUT_DOUBLE(%freg)
    li a7, 7              # syscall: ввод double
    ecall
    fmv.d %freg, fa0      # сохраняем введённое значение из регистра fa0 в %freg
.end_macro

#Макрос для вывода вещественного числа
.macro PRINT_DOUBLE(%freg)
    fmv.d fa0, %freg      # поместить значение в fa0 для вывода
    li a7, 3              # syscall: print double
    ecall
.end_macro

#Макрос для переноса строки
.macro NEW_LINE
    li a7, 4				# syscall: print string
    la a0, new_line
    ecall
.end_macro


#Макрос для выхода из программы
.macro EXIT_PROGRAM
	li a7, 10   # 10 — код системного вызова "exit"
	ecall       # вызываем системный вызов
.end_macro

.data 
	new_line: .string "\n"