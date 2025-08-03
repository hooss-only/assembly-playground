section .data
  msg db "test", 10, 0

section .text
  global _start
  extern printf

_start:
  mov rdi, msg
  call printf
  
  mov rax, 60
  xor rdi, rdi
  syscall
