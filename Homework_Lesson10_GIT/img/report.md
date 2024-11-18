# Руководство по выполнению задания с Git

## Подготовка

1. Создание репозитория на GitHub:
   - Перейдите на github.com и войдите в свой аккаунт
   - Нажмите "+" в правом верхнем углу → New repository
   - Укажите имя репозитория (например, "git-practice")
   - Выберите "Private"
   - Создайте репозиторий

2. Настройка локального репозитория:
```bash
# Клонирование репозитория
git clone https://github.com/ваш-username/git-practice.git
cd git-practice

# Настройка Git (если ещё не настроено)
git config --global user.name "Ваше Имя"
git config --global user.email "ваш@email.com"

# Настройка SSH-ключа (если ещё не настроено):
ssh-keygen -t ed25519 -C "ваш@email.com"
# Добавьте публичный ключ в GitHub (Settings → SSH and GPG keys)
```

## Задание 1: Создание коммитов

1. Создайте несколько файлов и коммитов:
```bash
# Создание первого файла
echo "Первый файл" > file1.txt
git add file1.txt
git commit -m "feat: add first file"

# Создание второго файла
echo "Второй файл" > file2.txt
git add file2.txt
git commit -m "feat: add second file"

# Изменение первого файла
echo "Обновленное содержимое" >> file1.txt
git add file1.txt
git commit -m "feat: update first file"

# И так далее до 5-10 коммитов
```

2. Просмотр лога коммитов:
```bash
git log --oneline
# Сделайте скриншот вывода для отчёта
```

## Задание 2: Использование reflog

1. Просмотр истории действий:
```bash
git reflog
# Сделайте скриншот
```

2. Переход к предыдущему коммиту:
```bash
# Выберите хеш нужного коммита из reflog
git checkout HEAD~1 # или git checkout <hash>
# Сделайте скриншот
```

## Задание 3: Создание новой ветки

```bash
git checkout -b develop
git branch # для проверки текущей ветки
# Сделайте скриншот
```

## Задание 4: Использование amend

1. Создайте коммит:
```bash
echo "Новый контент" > file3.txt
git add file3.txt
git commit -m "feat: add third file"
```

2. Внесите дополнительные изменения:
```bash
echo "." >> file3.txt
git add file3.txt
git commit --amend --no-edit
# Сделайте скриншот
```

## Задание 5-6: Перемещение коммита в новую ветку

1. Переключитесь на main и создайте коммит:
```bash
git checkout main
echo "Контент для main" > main-file.txt
git add main-file.txt
git commit -m "feat: add main file"
```

2. Создайте новую ветку и переместите коммит:
```bash
git branch new-branch
git reset --hard HEAD~1
# Сделайте скриншот
```

## Задание 7: Локальные изменения

```bash
echo "Новые изменения" >> file1.txt
git add file1.txt
git commit -m "feat: add new changes"
# Сделайте скриншот
```

## Задание 8: Отмена изменений через checkout

```bash
# Сохраните хеш текущего коммита
git log --oneline # копируем хеш
git checkout <hash> file1.txt
# Сделайте скриншот
```

## Задание 9: Полный сброс

Есть несколько способов начать заново:

1. Жёсткий сброс:
```bash
git reset --hard <hash-первого-коммита>
```

2. Удаление и клонирование заново:
```bash
cd ..
rm -rf git-practice
git clone https://github.com/ваш-username/git-practice.git
```
