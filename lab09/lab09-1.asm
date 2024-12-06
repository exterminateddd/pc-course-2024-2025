%include 'in_out.asm'
SECTION .data
msg: DB 'Введите x: ',0
result: DB '2(3x-1)+7=',0
SECTION .bss
x: RESB 80
res: RESB 80
SECTION .text
GLOBAL _start
_start:
;------------------------------------------
; Основная программа
;------------------------------------------
mov eax, msg
call sprint
mov ecx, x
mov edx, 80
call sread
mov eax,x
call atoi
call _calcul ; Вызов подпрограммы _calcul
mov eax,result
call sprint
mov eax,[res]
call iprintLF
call quit
;------------------------------------------
; Подпрограмма вычисления
; выражения "2x+7"
_calcul:
call _subcalcul ; eax = 3x-1
mov ebx,2
mul ebx
add eax,7
mov [res],eax   ; eax = 2*eax + 7
ret ; выход из подпрограммы
; g(x) = 3x-1
_subcalcul: ; eax=x
mov ebx,3   ; ebx=3
mul ebx     ; eax=eax*ebx=3x
sub eax,1   ; eax=3x-1
ret
