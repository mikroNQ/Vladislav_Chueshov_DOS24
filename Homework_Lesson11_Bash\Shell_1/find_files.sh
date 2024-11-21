#!/bin/bash

if [ $# -ne 3 ]; then
    echo "Ошибка: требуется три аргумента"
    echo "Использование: $0 выходной_файл директория расширение"
    echo "Пример: $0 res.txt ~/Desktop png"
    exit 1
fi

if [ ! -d "$2" ]; then
    echo "Ошибка: директория '$2' не существует"
    exit 1
fi

find "$2" -maxdepth 1 -type f -name "*.$3" | while read -r file; do
    basename "$file"
done > "$1"