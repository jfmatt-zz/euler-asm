%include "macros.mac"

;; Input: eax - integer to be printed
;; Return: void
;; Pulverises all registers
printI:
        ;; need at most 10 digits (decimal)
				sub esp, 10
				mov edi, esp
printI_digit:
				cdq											;extend to edx
				mov esi, 0xA
				div esi									;divide by 10

				add dl, 0x30						;make ASCII digit of remainder
				mov [edi], dl						;put in memory
				inc edi

				test eax, eax
				jnz printI_digit				;keep going until 0


				mov edx, edi						;length of string
				sub edx, esp
				mov esi, esp						;si at first char
				dec edi									;di at last char
printI_reverse:									;built rtl, now needs to be flipped
				mov al, [esi]
				mov ah, [edi]
				mov [esi], ah
				mov [edi], al
				inc esi
				dec edi

				cmp esi, edi						;keep going until they pass
				jb printI_reverse	  		;  each other
				
				write STDOUT, esp, edx

				add esp, 10             ;be kind, rewind
				ret
