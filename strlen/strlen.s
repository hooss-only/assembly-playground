.global _strlen

// int strlen(char* str)
_strlen:
  stp x29, x30, [sp, #-16]!
  mov x29, sp
  
  mov x9, x0 // x9: char* s = str
  mov w0, #0 // int result = 0;

.Lloop:
  ldrb w10, [x9]
  cbz w10, .Lreturn
  add w0, w0, #1
  add x9, x9, #1
  b .Lloop

.Lreturn:
  ldp x29, x30, [sp], #16
  ret
