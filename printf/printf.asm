section .text
  global printf

printf:
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
