AS = nasm
ASFLAGS = -g -f elf

LD = ld
LDFLAGS = -m elf_i386

OBJECTS = fizzbuzz.o

all: fizzbuzz

fizzbuzz: $(OBJECTS)
				$(LD) $(LDFLAGS) -o bin/$@ $^

%.o: %.asm
				$(AS) $(ASFLAGS) $<

run: fizzbuzz
				./bin/fizzbuzz

clean:
				rm -rf *.o fizzbuzz
