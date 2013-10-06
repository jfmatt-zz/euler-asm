euler-asm
=========

Project Euler in x86 assembly

##About

This is probably not the best code in the world; if it were, I wouldn't be doing Project Euler. It should improve as I go, though.

I'm developing on Ubuntu 12.04x86_64, but the makefiles are set up to compile to Elf32. That might change once I start wanting to link to glibc.

##Problem List

###0. FizzBuzz

This isn't even hard enough to be a Project Euler question, but it was enough to get my toolchain set up and make sure everything was working properly. And it's the first assembly program I've written in a good while, so here it is.

###1. Multiples of 3 and 5

More basic arithmetic; introduces the full form of the `div` operation (using `CDQ` to divide 32-bit numbers).

Successfully prints an integer answer to the console in decimal (`itoa` functionality).
