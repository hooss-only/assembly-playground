extern void itoa(int i, char* buffer);
extern void print_str(char* str);


int main() {
        char buffer[0x10] = { 0 };
        itoa(12345, buffer);
        print_str(buffer);
        print_str("\n");

        return 0;
}
