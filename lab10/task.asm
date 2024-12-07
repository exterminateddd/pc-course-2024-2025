;--------------------------------
; Запись в файл строки введенной на запрос
;--------------------------------
%include 'in_out.asm'
SECTION .data
filename db 'name.txt', 0h ; Имя файла
msg db 'Как Вас зовут? ', 0h ; Сообщение
SECTION .bss
name resb 255 ; переменная для имени и фамилии
SECTION .text
global _start
_start:
; --- Печать сообщения `msg`
mov eax,msg
call sprint
; ---- Запись введенной с клавиатуры строки в `contents`
mov ecx, name
mov edx, 255
call sread

; создание нового файла 'name.txt' (`sys_creat`)
mov ecx, 0o777
mov ebx, filename
mov eax, 8
int 80h
; --- Открытие созданного файла (`sys_open`)
mov ecx, 2 ; открываем для записи
mov ebx, filename
mov eax, 5
int 80h
; --- Запись дескриптора файла в `esi`
mov esi, eax
; --- Расчет длины введенной строки
mov eax, name ; в `eax` запишется количество
call slen ; введенных байтов
; --- Записываем в файл `name` (`sys_write`)
mov edx, eax
mov ecx, name
mov ebx, esi
mov eax, 4
int 80h
; --- Закрываем файл (`sys_close`)
mov ebx, esi
mov eax, 6
int 80h
call quit
