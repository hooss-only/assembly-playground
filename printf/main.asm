section .data
  msg db "test %c %d", 10, 0

section .text
  global _start
  extern printf

_start:
  mov rdi, msg
  mov rsi, 'h'
  mov rdx, 'i'
  call printf
  
  mov rax, 60
  xor rdi, rdi
  syscall
