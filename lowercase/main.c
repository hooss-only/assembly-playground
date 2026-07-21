extern void to_lower(char* str);
extern void print_str(char* str);

int main(void) {
        char test[] = "Hello, World!\n";

        to_lower(test);
        print_str(test);
        return 0;
}
