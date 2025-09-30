#create Makefile

cat > Makefile << EOF

CC=gcc
CFLAGS=-Iinclude -Wall -g
DEPS = 
OBJ = main.o

# Pattern rule for object files
%.o: %.c \$(DEPS)
	$(CC) \$(CFLAGS) -c -o $@ $< 

# Rule for building the final executable
a: \$(OBJ)
	$(CC) \$(CFLAGS) -o $@ $^

.PHONY: clean compile_commands

clean:
	rm -f *.o main  # Updated to remove the 'src/' as your object file is not in 'src/'

compile_commands:
	bear -- make

EOF


# create gitignore
cat > .gitignore << EOF
*.o
a
EOF

mkdir -p include
mkdir -p src

# create main.c
cat > src/main.c << EOF
#include <stdio.h>

int main(int argc, char *argv[])
{
    printf("Hello World!\n");
    return 0;
}
EOF


