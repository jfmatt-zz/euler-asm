%include "macros.mac"

;; Input: eax - integer to be printed
;; Input: ebx - base of output (i.e. 0x10 for hex)
;; Return: void
;; Pulverises all registers
printBase:
				sub esp, 32 ;can handle as far as binary
				mov edi, esp

printBase_digit:
				xor edx, edx
				div ebx

				cmp dl, 0xA
				jb printBase_numeric

				;alpha character
				sub dx, 0xA
				add dx, 'A'
				jmp printBase_gotDigit

printBase_numeric:
				add dx, '0'

printBase_gotDigit:
				mov [edi], dl
				inc edi

				test eax, eax
				jnz printBase_digit
				mov edx, edi						;length of string
				sub edx, esp
				mov esi, esp						;si at first char
				dec edi									;di at last char

printBase_reverse:									;built rtl, now needs to be flipped
				mov al, [esi]
				mov ah, [edi]
				mov [esi], ah
				mov [edi], al
				inc esi
				dec edi

				cmp esi, edi						;keep going until they pass
				jb printBase_reverse	  	;  each other
				
				write STDOUT, esp, edx

				add esp, 32             ;be kind, rewind
				ret
				
;; Input: eax - integer to be printed
;; Return: void
;; Pulverises all registers
printI:
        ;; need at most 10 digits (decimal)
				sub esp, 10
				mov edi, esp
printI_digit:
				xor edx, edx
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
