	BITS 		64
	section		.text
	global		setJulia

setJulia:
	push	rbp
	mov		rbp, rsp
	push	rbx
	push	rcx
	push	r8
	push	r9
	push	r10
	push	r11
	push	r12
	; RDI *pixels
	; RSI int WIDTH
	; RDX int HEIGTH
	; xmm0 double radius
	; xmm1 double real part of c
	; xmm2 double imaginary part of c
	; xmm3 double real part of centre
	; xmm4 double imaginary part of centre
	; xmm5 double zoom
	mov		rcx, rdx		; rows counter
outside_loop:
	dec		rcx
	test	rcx, rcx
	jbe		end
	mov		rbx, rsi		; columns counter
inside_loop:
	dec		rbx
	test	rbx, rbx
	jbe		outside_loop

	; count xmm6 zReal = (columns - real part of centre) * radius * 2 / (WIDTH * zoom)
	cvtsi2sd 	xmm6, rbx		; convert 32 bits integer to double
	subsd		xmm6, xmm3		; xmm6 = columns - real part of centre
	mulsd		xmm6, xmm0		; xmm6 = (columns - real part of centre ) * radius
	addsd		xmm6, xmm6		; xmm6 = (columns - real part of centre ) * radius * 2
	cvtsi2sd	xmm8, rsi		; xmm8 = width
	mulsd		xmm8, xmm5		; xmm8 = (width * zoom)
	divsd		xmm6, xmm8		; xmm6 = columns - real part of centre ) * radius * 2 / (width * zoom)

	; count xmm7 zImaginary = (rows - imaginary part of centre) * radius * 2 / (HEIGHT * zoom)
	cvtsi2sd 	xmm7, rcx		; convert 32 bits integer to double
	subsd		xmm7, xmm4		; xmm6 = rows - imaginary part of centre
	mulsd		xmm7, xmm0		; xmm6 = (rows - imaginary part of centre ) * radius
	addsd		xmm7, xmm7		; xmm6 = (rows - imaginary part of centre ) * radius * 2
	cvtsi2sd	xmm8, rdx		; xmm8 = heigth
	mulsd		xmm8, xmm5		; xmm8 = (heigth * zoom)
	divsd		xmm7, xmm8		; columns - real part of centre ) * radius * 2 / (width * zoom)

	xor		r8, r8		; set iterator to 0
	mov		r9, 128		; max iterator value
next_loop:
	movsd	xmm8, xmm6	; count the left side of condition (zReal * zReal + zImag * zImag)
	mulsd	xmm8, xmm8	; xmm8 = zReal * zReal
	movsd	xmm9, xmm7	; copy value of zImaginary
	mulsd	xmm9, xmm9	; xmm7 = zImaginary * zImaginary
	addsd	xmm8, xmm9	; xmm8 = zReal * zReal + zImaginary * zImaginary
	movsd	xmm9, xmm0	; copying value of radius
	mulsd	xmm9, xmm9	; xmm9 = radius * radius
	comisd	xmm8, xmm9
	jae		end_next_loop
	cmp		r8, r9
	jae		end_next_loop
	movsd	xmm8, xmm6	; xmm8 = zReal
	mulsd	xmm8, xmm6	; xmm8 = zReal * zReal
	movsd	xmm9, xmm7	; copy value of zImaginary
	mulsd	xmm9, xmm7	; xmm7 = zImaginary * zImaginary
	subsd	xmm8, xmm9	; xmm8 = zReal * zReal - zImaginary * zImaginary
	mulsd	xmm7, xmm6	; xmm7 = zImaginary * zReal
	addsd	xmm7, xmm7	; xmm7 = 2 * (zImaginary * zReal)
	addsd	xmm7, xmm2	; xmm7 = 2 * (zImaginary * zReal) + imaginary part of c
	movsd	xmm6, xmm8	; xmm6 = zReal * zReal - zImaginary * zImaginary
	addsd	xmm6, xmm1  ; xmm6 = zReal * zReal - zImaginary * zImaginary + real part of c
	inc		r8
	jmp		next_loop
end_next_loop:
	; count color intensity
	mov		r10, r9	; move max iteration to r10
	sub		r10, r8		; r10 = max iterator - iterator
	mov		r11, r10 	; r11 = copy of r10
	shl 	r10, 8		; r10 = (max iterator - iterator) * 256
	sub		r10, r11	; r10 = (max iterator - iterator) * 255
	shr 	r10, 7 		; r10 = (max iterator - iterator) * 255 / 128
	; count pixel identificator
	mov		r11, rcx	; r11 = rows
	imul	r11, rsi	; r11 = rows * WIDTH
	add		r11, rbx 	; r11 = rows * WIDTH + columns
	mov		r12, r11	; r12 = copy of r11
	shl		r11, 1		; r11 = 2 * (rows * WIDTH + columns)
	add		r11, r12	; r11 = 3 * (rows * WIDTH + columns)
	; store RGB pixels
	mov 	byte [rdi + r11], 216		; set 216 to red color
	mov		[rdi + r11 + 1], r10b		; set green color
	mov		byte [rdi + r11 + 2], 72	; set 72 to blue color
	jmp		inside_loop 
end:
	pop		r12
	pop		r11
	pop		r10
	pop		r9
	pop		r8
	pop		rcx
	pop		rbx
	mov		rsp, rbp
	pop		rbp
	ret
