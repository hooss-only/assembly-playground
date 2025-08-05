section .data
  msg db "%d * %d = %d", 10, 0
  nl db 0xa

section .text
  global _start
  extern printf

_start:
  ; 호출 규약에 따른 printf 호출 과정
  call main
  
  mov rdi, rax
  mov rax, 60
  syscall

main:
  push rbp
  mov rbp, rsp
  sub rsp, 16
  
  mov dword [rbp-4], 0 ; i = 0
  mov dword [rbp-8], 0 ; j = 0

loop_1:
  cmp dword [rbp-4], 9 ; i < 9 ?
  je main_done ; then return

  add dword [rbp-4], 1 ; i++
  mov dword [rbp-8], 0 ; j = 0

  mov rdi, nl
  call printf

loop_2:
  cmp dword [rsp+8], 9 ; j < 9 ?
  je loop_1 ; then break

  add dword [rsp+8], 1

  mov rdi, msg
  mov esi, dword [rbp-4]
  mov edx, dword [rbp-8]

  mov eax, esi
  mul edx
  mov ecx, eax
  mov edx, dword [rbp-8]

  call printf ; printf("%d * %d = %d", i, j, i * j)

  jmp loop_2

main_done:
  mov rsp, rbp
  pop rbp

  xor rax, rax 
  ret
