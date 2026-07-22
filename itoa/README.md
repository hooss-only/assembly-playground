aarch64, gnu as

# function
void itoa(int i, char* buffer)

# test
```
gcc -o test main.c itoa.s ../print_str/print_str.s && ./test
```
