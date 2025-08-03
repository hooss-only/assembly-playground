section .text
  global printf

; dword [rbp - 4]: fmt cnt
; qword [rbp - 12]: fmt pointer
printf:
  sub rsp, 12
  mov dword [rbp-4], 0
  mov qword [rbp-12], rdi

  mov rsi, qword [rbp-12]

printf_fmt_cnt_loop:
  cmp rsi, '%'
  je printf_fmt_cnt_up

  cmp rsi, '0'
  je printf_start

  add rsi, 1

printf_fmt_cnt_up:
  add qword [rbp-4], 1
  add rsi, 1
  jmp printf_cnt_loop

printf_start:
  mov rsi, qword [rbp-12] ; write syscall 준비과정
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
  mov rax, 60
  mov rdi, 1
  syscall

printf_fmt_done:
  add rsi, 1
  jmp printf_loop

printf_done:
  mov rax, 0
  ret

section .data:
  fmt_type_err_msg db "No such type", 10, 0
