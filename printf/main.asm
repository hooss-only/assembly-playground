section .data
  msg db "test %c %d", 10, 0

section .text
  global _start
  extern printf

_start:
  ; 호출 규약에 따른 printf 호출 과정
  mov rdi, msg
  mov rsi, 'h'
  mov rdx, 'i'
  call printf
  
  mov rax, 60
  xor rdi, rdi
  syscall
