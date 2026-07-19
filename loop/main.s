.global _main

.data
msg: .ascii "Hello, World!\n"
len = . - msg

.text
_main:
  mov x19, #10

.Lloop:
  mov x0, #0
  adrp x1, msg@PAGE
  add x1, x1, msg@PAGEOFF
  mov x2, len

  mov x16, #4
  svc #0
  
  sub x19, x19, #1
  cbz x19, .Lend
  b .Lloop

.Lend:
  mov x0, #0
  mov x16, #1
  svc #0
