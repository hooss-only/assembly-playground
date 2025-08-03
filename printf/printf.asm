section .text
  global printf

printf:
  push rbp
  mov rbp, rsp
  sub rsp, 48
  mov qword [rbp-8], rsi
  mov qword [rbp-16], rdx
  mov qword [rbp-24], rcx
  mov qword [rbp-32], r8
  mov qword [rbp-40], r9
  mov qword [rbp-48], 0

  mov rsi, rdi ; write syscall 준비과정
  mov rax, 1
  mov rdi, 1
  mov rdx, 1

printf_loop:
  cmp byte [rsi], 0
  je printf_done

  cmp byte [rsi], '%'
  je printf_fmt
  
  syscall
  add rsi, 1

  jmp printf_loop

printf_fmt:
  add rsi, 1

  ; 타입에 따라 분기
  cmp byte [rsi], 'c'
  je printf_fmt_char

printf_fmt_char:
  mov rbx, rsi
  lea rsi, [rbp-8]
  syscall
  mov rsi, rbx
  jmp printf_fmt_done

printf_fmt_done:
  add rsi, 1
  jmp printf_loop

printf_done:
  mov rax, 0
  mov rsp, rbp
  pop rbp
  ret

section .data:
  fmt_type_err_msg db "No such type", 10, 0
