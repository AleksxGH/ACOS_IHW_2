.data
	one:    .double 1.0
	eps:    .double 0.0005

.macro CALC_COSH %xreg, %resreg
    # f0=x, f1=sum, f2=term, f3=eps, f4=x^2, f5=denom, f6,temp, f7=ratio
    # t0=n, t1=2n, t2=2n-1, t3=cond, t4=limit, t5=addr

    fmv.d f0, %xreg          # сохраним x отдельно

    la t5, one
    fld f1, 0(t5)            # sum = 1.0
    fld f2, 0(t5)            # term = 1.0
    la t5, eps
    fld f3, 0(t5)            # eps = 0.0005

    # вычисляем x^2
    fmul.d f4, f0, f0

    li t0, 1
    li t4, 50

COSH_LOOP:
    # denom = (2n)*(2n-1)
    slli t1, t0, 1
    addi t2, t1, -1
    fcvt.d.w f5, t1
    fcvt.d.w f6, t2
    fmul.d f5, f5, f6

    # term *= x^2 / denom
    fdiv.d f6, f4, f5
    fmul.d f2, f2, f6

    # sum += term
    fadd.d f1, f1, f2

    # |term/sum| < eps ?
    fabs.d f6, f2
    fdiv.d f7, f6, f1
    flt.d t3, f7, f3
    bne t3, zero, COSH_END

    addi t0, t0, 1
    blt t0, t4, COSH_LOOP

COSH_END:
    fmv.d %resreg, f1
.end_macro
