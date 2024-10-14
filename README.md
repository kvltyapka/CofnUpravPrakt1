# Практическое занятие №1. Введение, основы работы в командной строке

Матюхов А.И. - ИКБО-62-23

## Задание 1

```
grep '^[^:]*' /etc/passwd | cut -d: -f1 | sort
```
![1](https://github.com/user-attachments/assets/7e6984e1-8f81-446e-a562-71e4ecbefb50)

## Задание 2

```
cat /etc/protocols | awk '{print $2, $1}' | sort -nr | head -n 5
```
![2](https://github.com/user-attachments/assets/55160de7-3920-4fa5-a959-d0db3c45a8a8)


## Задание 3

```
#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 \"text\""
    exit 1
fi

text="$1"
length=${#text}
border=$(printf '%*s' $((length + 2)) '' | tr ' ' '-')

echo "+$border+"
echo "| $text |"
echo "+$border+"
~
```
![3](https://github.com/user-attachments/assets/2c9172f3-a288-4375-815f-2c0a9b99e5df)


## Задание 4

```
#!/bin/bash

# Проверка наличия аргумента
if [ -z "$1" ]; then
    echo "Usage: $0 filename"
    exit 1
fi

grep -oE '\b[_a-zA-Z][_a-zA-Z0-9]*\b' "$1" | sort -u
```
![4](https://github.com/user-attachments/assets/250b554a-4448-4fdc-bde1-164eb8f44cc6)


## Задание 5

```
#!/bin/bash

cmd="$1"

if [[ -f "$cmd" && -x "$cmd" ]]; then
    sudo cp "$cmd" /usr/local/bin/

    sudo chmod 755 /usr/local/bin/"$(basename "$cmd")"

    echo "Command '$cmd' registered successfully."
else
    echo "File '$cmd' does not exist or is not executable."
    exit 1
fi
```
![5](https://github.com/user-attachments/assets/e9de2609-7bbd-4e57-8f63-afade1e40323)


## Задание 6

```
#!/bin/bash

check_comment() {
	local file=$1
	local ext=${file##*.}

	echo "Проверка: $file с расширением: .$ext"
	
	case $ext in
		c)
			if head -n 1 "$file" | grep -q '^\s*//' || head -n 1 "$file" | grep -q '^\s*/\*'; then
				echo "$file: Есть комментарий."
			else
				echo "$file: Нет комментария."
			fi
			;;
		js)
			if head -n 1 "$file" | grep -q '^\s*//'; then
				echo "$file: Есть комментарий."
			else
				echo "$file: Нет комментария."
			fi
			;;
		py)
			if head -n 1 "$file" | grep -q '^\s*#'; then
				echo "$file: Есть комментарий."
			else
				echo "$file: Нет комментария."
			fi
			;;
		*)
			echo "$file: Неподдерживаемый формат."
			;;
	esac
}


if [[ $# -ne 1 ]]; then
	echo "Использование: $0 <имя_файла>."
	exit 1
fi

if [[ -f $1 ]]; then
	check_comment "$1"
else
	echo "Файл $file не найден."
	exit 1
fi
```
![изображение](https://github.com/user-attachments/assets/30360786-a16e-4b4f-9e22-46b760961b33)


## Задание 7

```
#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo "Использование: $0 /путь/к/каталогу."
	exit 1
fi

directory=$1

if [[ ! -d $directory ]]; then
	echo "Ошибка: каталог $directory не найден."
	exit 1
fi

declare -A file_hashes

while IFS= read -r -d '' file; do
	hash=$(sha256sum "$file" | awk '{ print $1 }')
	file_hashes["$hash"]+="file"$'\n'
done < <(find "$directory" -type f -print0)

found_duplicates=false

for hash in "${!file_hashes[@]}"; do
	files="${file_hashes[$hash]}"
	files_count=$(echo -e "files" | wc -l)


	if [[ $files_count -gt 1 ]]; then
		found_duplicates=true
		echo "Найдены дубликаты:"
		echo -e "$files"
	fi
done

if ! $found_duplicates; then
	echo "Дубликатов не найдено."
	exit 1
fi
```

## Задание 8

```
#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Использование: $0 /путь/к/каталогу <расширение>."
	exit 1
fi

directory="$1"
extension="$2"

if [ ! -d "$directory" ]; then
	echo "Ошибка: указанный каталог '$directory' не существует."
	exit 1
fi

shopt -s nullglob
files=("$directory"/*."$extension")

if [ ${#files[@]} -eq 0 ]; then
	echo "Ошибка: в указанном каталоге '$directory' нет файлов с расширением .'$extension'."
	exit 1
fi

archive_name="${directory%/}.tar"

tar -cvf "$archive_name" -C "$directory" ./*."$extension"

echo "Архив '$archive_name' успешно создан."
```

## Задание 9

```
#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Использование: $0 <входной_файл> <выходной_файл>"
	exit 1
fi

input_file="$1"
output_file="$2"

if [ ! -f "$input_file" ]; then
	echo "Ошибка: '$input_file' не найден."
	exit 1
fi

sed 's/    /\t/g' "$input_file" > "$output_file"

echo "Заменено в файле: '$output_file'"
```

## Задание 10

```
#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Использование: $0 /путь/к/каталогу."
	exit 1
fi

directory="$1"

if [ ! -d "$directory" ]; then
	echo: "Ошибка: указанный каталог '$directory' не существует."
	exit 1
fi

find "$directory" -type f -name "*.txt" -empty -exec basename {} \;
```
