.equ do = 1500
.equ re = 2500
.equ mi = 3500
.equ fa = 4500
.equ sol = 5500
.equ la = 6600
.equ si = 7700

.cseg
	.org 0

	sbi ddrd, 5; patita d5 como salida

	; entradas
	clr r16
	out ddra, r16
	; configuramos tico 1 en modo CTC con n=1 y alternando 0c1a
	ldi r16, (1<<com1a0)
	out tccr1a, r16
	ldi r16, (1<<wgm12 | 1<<cs10)
	out tccr1b, r16

	ldi r16, high(0)
	out ocr1ah, r16
	ldi r16, low(0)
	out ocr1al, r16

	loop:
	; guardamos lo que esta en el pina y lo guardamos en r16
		in r16, pina
		cpi r16, 0b00000000
		breq loop

		buscar:
			cpi r16, 0b00000010
			breq la_sonido
			buscar2:
				cpi r16, 0b00000100
				breq sol_sonido
				buscar3:
					cpi r16, 0b00001000
					breq fa_sonido
					buscar4:
						cpi r16, 0b00010000
						breq mi_sonido
						buscar5:
							cpi r16, 0b00100000
							breq re_sonido
							buscar6:
								cpi r16, 0b01000000
								breq do_sonido
								buscar7:
									cpi r16, 0b00000001
									breq si_sonido
									rjmp wait_release

		do_sonido:
			ldi r16, high(do)
			out ocr1ah, r16
			ldi r16, low(do)
			out ocr1al, r16
			rjmp wait_release

		re_sonido:
			ldi r16, high(re)
			out ocr1ah, r16
			ldi r16, low(re)
			out ocr1al, r16
			rjmp wait_release
		
		mi_sonido:
			ldi r16, high(mi)
			out ocr1ah, r16
			ldi r16, low(mi)
			out ocr1al, r16
			rjmp wait_release

		fa_sonido:
			ldi r16, high(fa)
			out ocr1ah, r16
			ldi r16, low(fa)
			out ocr1al, r16
			rjmp wait_release

		sol_sonido:
			ldi r16, high(sol)
			out ocr1ah, r16
			ldi r16, low(sol)
			out ocr1al, r16
			rjmp wait_release

		la_sonido:
			ldi r16, high(la)
			out ocr1ah, r16
			ldi r16, low(la)
			out ocr1al, r16
			rjmp wait_release

		si_sonido:
			ldi r16, high(si)
			out ocr1ah, r16
			ldi r16, low(si)
			out ocr1al, r16
			rjmp wait_release
		
		wait_release:
			in r16, pina
			cpi r16, 0
			breq loop

		rjmp loop