.global _itoa

// void itoa(int i, char* buffer)
_itoa:
  stp x29, x30, [sp, #-16]!
  mov x29, sp

  mov w2, w0 // w2: int tmp = i

.Lget_int_length_start:
  mov x3, #0 // x3: int length = 0
  mov x4, #10

.Lget_int_length_loop:
  add x3, x3, #1
  udiv x2, x2, x4
  cbz x2, .Lbegin
  b .Lget_int_length_loop

.Lbegin:
  mov w4, #0
  add x5, x1, x3
  strb w4, [x5]
  mov w2, #10

.Lloop:
  sub x3, x3, #1
  udiv w5, w0, w2 // w5 = input / 10
  msub w4, w5, w2, w0 // w4 = input % 10 (result)
  mov w0, w5 // input /= 10 (input = w5)
  add w4, w4, #48
  add x5, x1, x3
  strb w4, [x5]
  cbz x3, .Lreturn
  b .Lloop

.Lreturn:
  ldp x29, x30, [sp], #16
  ret
