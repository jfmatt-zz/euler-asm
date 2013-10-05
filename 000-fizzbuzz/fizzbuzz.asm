%macro write 3
				mov eax, 4
				mov ebx, %1
				mov ecx, %2
				mov edx, %3
				int 0x80
%endmacro
%macro exit 1
				mov eax, 1
				mov ebx, %1
				int 0x80
%endmacro

%define STDOUT 1

section .bss
				three	resb	1						;when to fizz
				five	resb	1						;when to buzz
				tickP	resb	1						;if still true, tick

section .text
global _start

_start:
				mov si,      0xFF
				mov [three], byte 0x3
				mov [five],  byte 0x5

startloop:
				push si
				
				;; if this makes it to end of loop,
				;; print 'tick'
				mov [tickP], byte 1

				sub [three], byte 1
				mov bl, [three]

				cmp [three], byte 0
				jne resetFizz
				mov [three], byte 3
resetFizz:
				
				test bl, 0xFF
				jnz nofizz
				mov [tickP], byte 0
				write STDOUT, fizz, 4
nofizz:

				sub [five], byte 1
				mov bl, [five]

				cmp [five], byte 0
				jne resetBuzz
				mov [five], byte 5
resetBuzz:
				
				test bl, 0xFF
				jnz nobuzz
				mov [tickP], byte 0
				write STDOUT, buzz, 4
nobuzz:

				mov al, [tickP]
				test al, 0xFF
				jz notick
				write STDOUT, tick, 4				
notick:

				push 0xA
				write STDOUT, esp, 1		;print newline from stack
				pop eax
				
				pop si
				dec si
				jnz startloop

				exit 0

section .data
				tick db 'tick'
				fizz db 'fizz'
				buzz db 'buzz'
