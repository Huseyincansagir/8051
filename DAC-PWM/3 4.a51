#include <aduc841.h>
org 0000
x:
mov SP,#71h
push 61h
push 16h
acall mikro
sjmp $

mikro:
nop
nop
ret



end
