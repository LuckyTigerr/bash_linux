#!/bin/bash

# Функция вывода сообщения и завершения скрипта
stopIt() {
  echo "$1" >&2
  exit 1
}

# Проверка количества аргументов
if [ "$#" -ne 3 ]; then
  stopIt "Использование: $0 <путь_к_каталогу> <старый_суффикс> <новый_суффикс>"
fi

# Параметры
dir="$1"
old_suffix="$2"
new_suffix="$3"

# Проверка существования директории
if [ ! -d "$dir" ]; then
  stopIt "Ошибка: '$dir' не является каталогом."
fi

# Поиск и переименование файлов
find "$dir" -type f | while read -r file; do
  # Получение имени файла без пути
  filename=$(basename -- "$file")

  # Проверка суффикса
  if [[ $filename == *"$old_suffix" ]]; then
    # Получение имени файла без суффикса
    base_filename="${filename%$old_suffix}"

    # Формирование нового имени файла
    new_filename="${base_filename}$new_suffix"

    # Переименовываем файл
    mv "$file" "$(dirname -- "$file")/$new_filename"

    # Выводим информацию о переименовании
    echo "Переименован файл: $filename -> $new_filename"
  fi
done

echo "Выполнено!"
