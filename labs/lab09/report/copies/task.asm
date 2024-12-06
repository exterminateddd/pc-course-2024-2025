%include 'in_out.asm'
SECTION .data
msg db "Результат: ",0
msg1 db "Функция: f(x)=4x-3",0
SECTION .text
global _start
_start:
mov eax, msg1
call sprintLF

pop ecx ; Извлекаем из стека в `ecx` количество
; аргументов (первое значение в стеке)
pop edx ; Извлекаем из стека в `edx` имя программы
; (второе значение в стеке)
sub ecx,1 ; Уменьшаем `ecx` на 1 (количество
; аргументов без названия программы)
mov esi,0 ; Используем `esi` для хранения
; промежуточных сумм

next:
cmp ecx,0h ; проверяем, есть ли еще аргументы
jz _end ; если аргументов нет выходим из цикла
; (переход на метку `_end`)
pop eax        ; eax := следующий аргумент
call atoi

; имеем аргумент x в eax
; требуется сделать из него 4x-3
call _calc

add esi, eax ; esi := esi + 4x-3
mov eax, esi

loop next ; переход к обработке следующего аргумента

_end:
mov eax, msg ; вывод сообщения "Результат: "
call sprint
mov eax, esi ; записываем сумму в регистр `eax`
call iprintLF ; печать результата
call quit ; завершение программы

_calc: ; имеем в eax значение х
mov ebx, 4
mul ebx       ; eax = 4x
sub eax, 3    ; eax = 4x-3
ret       ; выходим из подпрограммы
