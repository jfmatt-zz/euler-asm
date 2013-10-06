AS = nasm
ASFLAGS = -g -f elf -w+all

LD = ld
LDFLAGS = -m elf_i386

OBJECTS = 001.o

all: 001

001: $(OBJECTS)
				$(LD) $(LDFLAGS) -o bin/$@ $^

%.o: %.asm
				$(AS) $(ASFLAGS) $<

run: 001
				./bin/001

clean:
				rm -rf *.o 001
