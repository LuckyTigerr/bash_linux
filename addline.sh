#!/bin/bash

# Функция c сообщением об ошибке и завершением скрипта
stopIt() {
  echo "$1" >&2
  exit 1
}

# Проверка количества аргументов
if [ "$#" -ne 1 ]; then
  stopIt "Использование: $0 <путь_к_каталогу>"
fi

# Чтение аргумента скрипта
directory="$1"

# Проверка существования директории
if [ ! -d "$directory" ]; then
  stopIt "Ошибка: '$directory' не является каталогом."
fi

# Формирование строки для добавления в файл
user_name=$(whoami)
current_date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
line_to_add="Approved $user_name $current_date"

# Обработка файлов в каталоге
for file in "$directory"/*.txt; do
  # Проверка, что файл существует и является обычным файлом
  if [ -f "$file" ]; then
    # Добавление строки в начало файла
    echo "$line_to_add" | cat - "$file" >tempfile && mv tempfile "$file"
    echo "Добавлена строка в файл: $file"
  fi
done

echo "Выполнено!"
