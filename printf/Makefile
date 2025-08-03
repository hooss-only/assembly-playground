TARGET = a
OBJS = main.o printf.o

all: $(TARGET)

$(TARGET): $(OBJS)
	ld -o $@ $^

%.o: %.asm
	nasm -f elf64 -o $@ $<

clean:
	rm -r $(OBJS) $(TARGET)
