AS = nasm
ASFLAGS = -g -f elf -w+all

LD = ld
LDFLAGS = -m elf_i386

OBJECTS = 002.o

OUTDIR = bin

all: 002

002: $(OBJECTS)
			mkdir -p $(OUTDIR)
			$(LD) $(LDFLAGS) -o $(OUTDIR)/$@ $^

%.o: %.asm
				$(AS) $(ASFLAGS) $<

run: 002
				./bin/002

clean:
				rm -rf *.o 002
