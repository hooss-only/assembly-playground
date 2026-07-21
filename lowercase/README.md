aarch64용, gcc를 통해 컴파일됩니다.

# 제공 함수
void to_lower(char* str)
> str 배열을 순회하며 대문자를 소문자로 바꿔 다시 저장합니다.

# 의존성
strlen

# Test
```
make && ./test
```
"Hello, World!\n"을 to_lower 함수를 통해 소문자화 시키고, print_str로 출력합니다.
