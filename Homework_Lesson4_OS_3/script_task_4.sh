#!/bin/bash

# Func для проверки, является ли строка числом
is_number() {
    [[ $1 =~ ^[0-9]+$ ]]
}

# Запрос исходной строки
echo "Введите исходную строку:"
read input_string

# Получение длины строки
string_length=${#input_string}

# Запрос начальной позиции
while true; do
    echo "Введите начальную позицию (от 1 до $string_length):"
    read start_pos
    
    # Проверка валидности ввода
    if ! is_number "$start_pos"; then
        echo "Ошибка: введите числовое значение"
        continue
    fi
    
    if [ $start_pos -lt 1 ] || [ $start_pos -gt $string_length ]; then
        echo "Ошибка: позиция должна быть от 1 до $string_length"
        continue
    fi
    break
done

# Запрос конечной позиции
while true; do
    echo "Введите конечную позицию (от $start_pos до $string_length):"
    read end_pos
    
    # Проверка валидности ввода
    if ! is_number "$end_pos"; then
        echo "Ошибка: введите числовое значение"
        continue
    fi
    
    if [ $end_pos -lt $start_pos ] || [ $end_pos -gt $string_length ]; then
        echo "Ошибка: позиция должна быть от $start_pos до $string_length"
        continue
    fi
    break
done

# Вычисление длины подстроки
length=$((end_pos - start_pos + 1))

# Извлечение подстроки
substring=${input_string:$((start_pos-1)):$length}

# Вывод результата
echo "Выделенная подстрока: $substring"