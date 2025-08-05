section .text
    global cvt_digit_to_str

; rdi: digit
; rsi: char[8]
; void cvt_digit_to_str(int d, char str[8]);
cvt_digit_to_str:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    mov dword [rbp-4], 0 ; int length
    mov dword [rbp-8], 0 ; int cnt
    mov qword [rbp-16], rdi ; long original

    mov rax, rdi

cvt_digit_to_str_get_length:
    ; rax == 0 ? break
    cmp rax, 0
    je cvt_digit_to_str_preloop

    ; rax /= 10
    mov rbx, 10
    xor rdx, rdx
    div rbx 

    ; length++
    add dword [rbp-4], 1

    ; loop
    jmp cvt_digit_to_str_get_length

cvt_digit_to_str_preloop:
    mov eax, dword [rbp-4]
    add rsi, rax
    sub rsi, 1
    mov rax, qword [rbp-16] ; rax = original

cvt_digit_to_str_loop:
    cmp rax, 0 ; rax == 0 ? return
    je cvt_digit_to_str_done

    ; rdx = rax % 10; rax /= 10
    mov rbx, 10
    xor rdx, rdx
    div rbx

    ; rbx += '0' => int to char
    add rdx, '0'
    ; rsi: char str[8]

    mov byte [rsi], dl
    sub rsi, 1

    jmp cvt_digit_to_str_loop


cvt_digit_to_str_done:
    mov rsp, rbp
    pop rbp
    xor rax, rax
    ret