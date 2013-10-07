				;; Project Euler Problem 2
				;; James Matthews, 2013
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

section .data

section .bss

section .text
global _start
_start:
				mov eax, 0       ;fib0
				mov ebx, 1       ;fib1
				mov edx, 0       ;total
				mov edi, 4000000 ;max

				jmp odd          ;don't need to add starting 0, so let's
				                 ;skip ahead by one at least
loop:
				test eax, 0x1
				jnz odd
				add edx, eax
odd:
				;move to next fib
				mov ecx, ebx ;n + 1 cache in ecx
				add ebx, eax ;n + 2 in ebx
				mov eax, ecx ;n + 1 to eax

				cmp eax, edi
				jb loop

				;push total to eax so copypasta printer works
				mov eax, edx
print:
        ;; need at most 10 digits (decimal)
				sub esp, 10
				mov edi, esp
				
digit:
				cdq											;extend to edx
				mov esi, 0xA
				div esi									;divide by 10

				add dl, 0x30						;make ASCII digit of remainder
				mov [edi], dl						;put in memory
				inc edi

				test eax, eax
				jnz digit								;keep going until 0


				mov edx, edi						;length of string
				sub edx, esp
				mov esi, esp						;si at first char
				dec edi									;di at last char
reverse:											;built rtl, now needs to be flipped
				mov al, [esi]
				mov ah, [edi]
				mov [esi], ah
				mov [edi], al
				inc esi
				dec edi

				cmp esi, edi						;keep going until they pass
				jb reverse							;  each other
				
				write STDOUT, esp, edx

				add esp, 10							;stack-neutral
				
				exit 0
