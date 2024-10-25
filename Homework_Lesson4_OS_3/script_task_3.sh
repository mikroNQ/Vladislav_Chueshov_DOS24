#!/bin/bash

# Проверка количества аргументов
if [ $# -ne 2 ]; then
    echo "Использование: $0 filename new_extension"
    echo "Пример: $0 text.txt doc"
    exit 1
fi

filename="$1"
new_ext="$2"

# Проверка существования файла
if [ ! -f "$filename" ]; then
    echo "Ошибка: файл '$filename' не существует"
    exit 1
fi

# Извлечение имени файла без расширения
# ${filename%.*} удаляет самый короткий суффикс, соответствующий шаблону .*
basename="${filename%.*}"

# Формирование нового имени файла
new_filename="${basename}.${new_ext}"

# Переименование файла
mv "$filename" "$new_filename"

if [ $? -eq 0 ]; then
    echo "Файл успешно переименован в: $new_filename"
else
    echo "Ошибка при переименовании файла"
    exit 1
fi