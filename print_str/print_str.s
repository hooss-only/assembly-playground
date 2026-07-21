.global _print_str

// print_str(char* str)
_print_str:
  stp x29, x30, [sp, #-16]!
  mov x29, sp

  mov x9, x0 // x9: char* str
  mov x11, x9 // x11: char* tmp = str

.Lget_str_len:
  mov w10, #0 // x10: int length = 0

.Lget_len_loop:
  ldrb w12, [x11] // x12: char c = *str
  cbz x12, .Lwrite
  add w10, w10, #1
  add x11, x11, #1
  b .Lget_len_loop

.Lwrite:
  mov x0, #1
  mov x1, x9
  mov x2, x10

  mov x16, #4
  svc #0

.Lreturn:
  ldp x29, x30, [sp], #16
  ret
