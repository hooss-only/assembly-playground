section .text
  global _start

_start:   
  mov r9, 0

loop:
  mov rsi, msg
  call print
    
  cmp r9, 10
  je done
  
  add r9, 1
  jmp loop

done:
  mov rax, 60
  mov rdi, 0
  syscall

print:
  mov rax, 1
  mov rdi, 1
  mov rdx, 1

print_loop:
  cmp byte [rsi], 0
  je print_done
  
  syscall

  add rsi, 1

  jmp print_loop

print_done:
  ret

msg: db "Hello, World!", 10, 0
