.global _to_lower

// void to_lower(char* str)
_to_lower:
  stp x29, x30, [sp, #-16]!
  mov x29, sp
  
  mov x19, x0
  bl _strlen
  mov w10, w0 // w9: int length = strlen(str)

.Lloop:
  cbz w10, .Lend
  sub w10, w10, #1

  add x11, x19, x10 // x11: char* p, an address of selected character

  ldrb w12, [x11] // w12: char c = *p
  
.Lcheck_case:
  cmp w12, #65
  b.lt .Lloop
  cmp w12, #90
  b.gt .Lloop

.Lmake_lower:
  add w12, w12, #32
  strb w12, [x11]
  b .Lloop

.Lend:
  ldp x29, x30, [sp], #16
  ret
