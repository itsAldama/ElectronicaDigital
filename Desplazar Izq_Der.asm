.cseg
	.org 0

	; A: botones
	cbi ddra, 0
	; mueve derecha
	cbi ddra, 7
	; mueve izquierda

	; B: salidas
	ser r16
	out ddrb, r16
	; en r17 guardamos el movimiento
	ldi r17, 0x10
	out portb, r17

	loop:
		in r16, pina
		sbrs r16, 0
		rjmp evaluar_si_izq_presionado
		rjmp mueve_derecha

		evaluar_si_izq_presionado:
			sbrs r16, 7
			rjmp loop

		mueve_izquierda:
			sbrc r17, 7
			rjmp salto1
			lsl r17
			rjmp salto1

		mueve_derecha:
			sbrc r17, 0
			rjmp salto1
			lsr r17

		salto1:
			espera_deje_presionar:
				in r16, pina
				cpi r16, 0
				breq salto2
				rjmp espera_deje_presionar

			salto2:
				out portb, r17
				rjmp loop