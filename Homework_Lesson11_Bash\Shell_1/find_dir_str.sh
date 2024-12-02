#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Использование: $0 \"строка для поиска\" путь/к/каталогу"
    exit 1
fi

search_string="$1"
search_dir="$2"

# Проверка существования каталога
[[ ! -d "$search_dir" ]] && {
    echo "Ошибка: Каталог '$search_dir' не существует"
    exit 1
}

# Определение команды stat в зависимости от ОС
stat_cmd="stat -c%s"
[[ "$(uname)" == "Darwin" ]] && stat_cmd="stat -f%z"

# Функция для вывода информации о файле
print_file_info() {
    local file="$1"
    local full_path size
    
    full_path=$(realpath "$file" 2>/dev/null) || return
    size=$($stat_cmd "$file" 2>/dev/null) || return
    
    cat <<EOF
Путь: $full_path
Имя файла: $(basename "$file")
Размер: $size байт
-----------------------------
EOF
}

# Основной поиск
find "$search_dir" -type f -exec sh -c '
    for file; do
        if grep -q -- "$1" "$file" 2>/dev/null; then
            echo "$file"
        fi
    done
' sh "$search_string" {} + 2>/dev/null | 
while IFS= read -r file; do
    print_file_info "$file"
done