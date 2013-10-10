AS = nasm
ASFLAGS = -g -f elf -w+all

LD = ld
LDFLAGS = -m elf_i386

OBJECTS = 003.o

OUTDIR = bin

all: 003

003: $(OBJECTS)
			mkdir -p $(OUTDIR)
			$(LD) $(LDFLAGS) -o $(OUTDIR)/$@ $^

%.o: %.asm
				$(AS) $(ASFLAGS) $<

run: 003
				./bin/003

clean:
				rm -rf *.o 003
