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
  mov qword [rbp-48], 0 ; 포맷팅 개수 세기

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

  mov r9, qword [rbp-48]
  mov r10, 8

printf_fmt_get_arg_loop:
  cmp r9, 0
  je printf_fmt_switch

  sub r9, 1

  add r10, 8
  jmp printf_fmt_get_arg_loop

printf_fmt_switch:
  mov r11, rbp
  sub r11, r10
  ; 타입에 따라 분기
  cmp byte [rsi], 'c'
  je printf_fmt_char

printf_fmt_char:
  mov r8, rsi
  lea rsi, [r11]
  syscall
  mov rsi, r8
  jmp printf_fmt_done

printf_fmt_done:
  add rsi, 1
  add qword [rbp-48], 1
  jmp printf_loop

printf_fmt_too_much:
  mov rax, 1
  mov rdi, 1
  mov rsi, fmt_too_much_fmt_err_msg
  mov rdx, 21
  syscall

  mov rax, 60
  mov rdi, 1
  syscall

printf_done:
  mov rax, 0
  mov rsp, rbp
  pop rbp
  ret

section .data:
  fmt_type_err_msg db "No such type", 10, 0
  fmt_too_much_fmt_err_msg db "Too Much Formating!", 10, 0
