section .text
  global printf
  extern cvt_digit_to_str

; rsi 레지스터를 사용하므로 내부에서 다른 함수 호출시 rsi 백업이 필요함.
printf:
  push rbp
  mov rbp, rsp
  sub rsp, 48
  mov qword [rbp-8], rsi ; 인자들을 지역변수로 이동
  mov qword [rbp-16], rdx
  mov qword [rbp-24], rcx
  mov qword [rbp-32], r8
  mov qword [rbp-40], r9
  mov qword [rbp-48], 0 ; 포맷팅 개수 세기, long fmt_cnt;

  mov rsi, rdi ; write syscall 준비과정, rsi는 출력할 문자 포인터

; 기본적으로는 문자열 포인터를 1씩 더해가며 한 글자씩 출력합니다.
; 0을 만나면 문자열의 끝으로 판단하고 함수를 종료(printf_done)시킵니다.
; %을 만나면 printf_fmt로 분기합니다.
printf_loop:
  cmp byte [rsi], 0 ; 현재 문자가 0인지 확인, *rsi == 0?
  je printf_done ; 끝내기

  cmp byte [rsi], '%' ; *rsi == '%'?
  je printf_fmt

  mov rax, 1
  mov rdi, 1
  mov rdx, 1

  syscall ; putchar(*rsi)
  add rsi, 1 ; rsi++

  jmp printf_loop ; loop

; 문자열 포인터를 1 증가시킵니다. (다음 문자로 포매팅 타입을 알기 위해)
; 포매팅 개수가 5개 초과시 에러로 분기시킵니다.
printf_fmt:
  add rsi, 1 ; rsi++

  cmp qword [rbp-48], 5 ; fmt_cnt == 5
  je printf_fmt_too_much ; ERROR

  mov r9, qword [rbp-48] ; r0 = fmt_cnt
  mov r10, 8 ; r10은 rbp와 현재 인자 사이 오프셋을 알려주는 용도

; 현재 포매팅 개수에 따라 인자를 고르는 과정입니다.
; fmt_cnt(현재 포매팅 개수) 만큼 반복하며 r10에 8씩 더해줍니다.
; 이 과정은 rbp로부터 현재 인자가 어느정도의 오프셋으로 떨어져있는지 알 수 있게 해줍니다.
; 예시) 2번째 포매팅 -> rbp-16
printf_fmt_get_arg_loop:
  cmp r9, 0 ; r9 == 0?
  je printf_fmt_switch ; 루프 종료

  sub r9, 1 ; r9에서 1 빼기

  add r10, 8 ; r10에 8 더하기
  jmp printf_fmt_get_arg_loop ; 루프

; 타입에 따라 분기합니다.
; 예시) %c -> printf_fmt_char로 분기
; 만약 지원하지 않는 타입이면 printf_fmt_unknown으로 분기합니다.
printf_fmt_switch:
  mov r11, rbp
  sub r11, r10 ; 두 줄로 r11 = rbp-r10(오프셋)
  mov r8, rsi ; rsi를 r8에 백업해둠

  ; 타입에 따라 분기
  cmp byte [r8], 'c' ; %c?
  je printf_fmt_char

  cmp byte [r8], 'd' ; %d?
  je printf_fmt_digit

  jmp printf_fmt_unknown ; else

; 구한 char 인자값을 대입하여 출력합니다.
printf_fmt_char:
  lea rsi, [r11] ; rsi = &r11(= rbp-r10(인자 오프셋))
  syscall ; 한 글자 출력 (print char)
  jmp printf_fmt_done

; 구한 숫자 인자값을 대입하여 출력합니다.
printf_fmt_digit:
  sub rsp, 16

  mov rdi, qword [r11] ; rdi = args[cnt]
  mov qword [rsp], 0
  mov qword [rsp+8], 0 ; buf = { 0 }
  lea rsi, [rsp] ; = rsi = &buf
  call cvt_digit_to_str ; cvt_digit_to_str(args[cnt], &buf)
  lea rsi, [rsp] ; = rsi = &buf
  mov rax, 1
  mov rdi, 1
  mov rdx, 16
  syscall ; rsi에 있는 값 16바이트 출력

  add rsp, 16

  jmp printf_fmt_done

; 포매팅 개수를 늘리고
; 원본 문자열 포인터를 1 더하고
; 루프로 돌아갑니다.
printf_fmt_done:
  mov rsi, r8 ; 백업한 rsi 복구
  add rsi, 1 ; rsi++
  add qword [rbp-48], 1 ; fmt_cnt++
  jmp printf_loop ; print_loop로 복귀

; 스택프레임을 정리하고 리턴합니다.
printf_done:
  xor rax, rax
  mov rsp, rbp
  pop rbp
  ret

; 에러 처리
printf_fmt_too_much:
  mov rax, 1
  mov rdi, 1
  mov rsi, fmt_too_much_fmt_err_msg
  mov rdx, 21
  syscall

  mov rax, 60
  mov rdi, 1
  syscall

printf_fmt_unknown:
  mov rax, 1
  mov rdi, 1
  mov rsi, fmt_type_err_msg
  mov rdx, 14
  syscall

  mov rax, 60
  mov rdi, 2
  syscall

section .data:
  fmt_type_err_msg db "No such type", 10, 0
  fmt_too_much_fmt_err_msg db "Too Much Formating!", 10, 0
