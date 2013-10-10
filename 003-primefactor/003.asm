;;Project Euler Problem 3
;;James Matthews, 2013

%include "macros.mac"
%include "lib.asm"

section .data

section .bss

section .text
global _start

_start:
				mov edi, 0x80000000
				mov esi, edi
				
factorLoop:
				mov eax, edi
				xor edx, edx
				div esi
				test edx, edx  ;remainder
				jz isFactor

				dec esi
				jmp factorLoop
isFactor:
				
				push esi
				mov eax, esi
				call prime
				pop esi

				; stop if factor and prime
				test ebx, ebx
				jnz breakLoop

				; stop at 0; this means something's broken
				dec esi
				jz breakLoop
				
				jmp factorLoop
breakLoop:
				
				mov eax, esi
				call printI

				exit 0

;eax - IN, number to test
;ebx - OUT, 1 if prime, 0 if not prime
;Pulverizes ebx, ecx, edx, esi
prime:
				cmp eax, 2
				ja prime_main
				je prime_two
				;; if here, eax was 1 or zero
				xor ebx, ebx
				ret
prime_two:
				mov ebx, 1
				ret
prime_main:
				test eax, 0x1 ;test if even
				jnz prime_odd
				xor ebx, ebx
				ret
prime_odd:
				mov esi, eax ;cache against div
				mov ecx, 1   ;iterator
				mov ebx, 1   ;return value - assume prime, fail fast if not  

prime_loop:
				inc ecx     ;starts at 2

				mov eax, esi  ;get original number back
				xor edx, edx
				div ecx       ;divide by current potential factor
				test edx, edx ;look for remainder
				jnz prime_notthisfactor 

        ;; no remainder -> dividied evenly -> not prime
				xor ebx, ebx
				ret

prime_notthisfactor:
				mov eax, ecx  ;loop until ecx^2 > n
				mul ecx       ;  i.e. until ecx > sqrt(n)
				cmp eax, esi  ;we know this can't overflow into edx
				              ;because we're killing the loop before then
				jb prime_loop

				ret