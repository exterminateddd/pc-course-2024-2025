;--------------------------------
; Программа вычисления выражения
;--------------------------------
%include 'in_out.asm' ; подключение внешнего файла
SECTION .data
msg: DB 'Введите значение x',0
div: DB 'Результат: ',0
dot: DB '.',0
SECTION .bss
x: RESB 80    ; резервируем память под значение x
SECTION .text
GLOBAL _start
_start:
mov eax, msg
call sprintLF ; вывод приглашения к вводу
mov ecx, x
mov edx, 80
call sread ; считывание значения x
mov eax, x ; eax = x
call atoi ; преобразуем eax в число
mov edi, eax
mul edi   ; умножаем eax на edi=x, eax = x^2
mul edi   ; eax = x^3
mov ebx,2 ; ebx = 2
xor edx, edx ; обнуляем edx
div ebx   ; делим eax на ebx, eax = eax//2
; остаток от деления помещается в edx
inc eax ; eax = x^3/2 + 1
mov edi, eax ; результат кладём в edi
mov eax, edx ; остаток от деления перемещаем в eax
mov ecx,10
mul ecx  ; умножаем eax на 10
div ebx ; делим eax на 2
mov edx, eax
; теперь в edx имеем дробную (десятичную) форму остатка
; в edi целая часть частного
; выводить будем [целая часть].[дробная часть]
mov eax,div ; вызов подпрограммы печати
call sprint ; сообщения 'Результат: '
mov eax,edi ; вызов подпрограммы печати значения
call iprint ; из 'edi' в виде символов
mov eax,dot ; точка
call sprint ; печать точки
mov eax,edx ; вызов подпрограммы печати значения
call iprintLF ; из 'edx' (остаток) в виде символов
call quit ; вызов подпрограммы завершения

