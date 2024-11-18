# Задания

```bash
Индивидуальная часть:
На соданном аккаунте github.com создать репозиторий и клонировать его себе локально. Настроить себе доступы для того, чтобы можно было пушить изменения в ветки. Init commit может быть и локальный, это на ваше усмотрение. Далее реализовать следующие сценарии
1. Создать 5-10 коммитов. (Пример: создать файлы, поменять их содержимое). Вывести их лог экран, сделать скрин и добавить в отчёт.
2. С помощью reflog перейти к предыдущему коммиту (на ваше усмотрение). Output, screen, report. (Вывести их лог экран, сделать скрин и добавить в отчёт.)
https://youtu.be/XRV9kai-3mc (небольшая помощь, если запутаетесь)
3. Создайте ветку с названием на ваше усмотрение (можно develop). OSR. (Output, screen, report.)
4. Создайте коммит и добавьте туда ещё дополнительные измения (добавьте, например в изменяемый файл точку, пробел и тд) с помощью ammend. OSR.
5. Сделайте коммит в main. Но не делайте git push (это важно!), сделайте изменения локально.
6. Сделайте так, чтобы этот коммит оказался в новой ветке с помощью git reset --hard. OSR
7.  Сделайте изменения в файле локально. Сделайте коммит для этого изменения. OSR
8. Через git checkout отмените изменения в файле через откат по сохранённому хэшу. OSR
9. Начните всё заново (это важно чтобы вы делали локально то, что я указал сделать локально). Можно использовать любой из подходов. OSR
Ваш основной гайд: https://pikabu.ru/story/git_shit_10252570
Оформленный отчёт запушьте на ваш ПРИВАТНЫЙ репозиторий, куда вы меня уже добавили или добавите (кто этого ещё не сделал).
```

# Выполнение

## Задание 1: Создание коммитов

![alt text](/Homework_Lesson10_GIT/img/step_1.png)

2. Просмотр лога коммитов:
```bash
git log --oneline
```
![alt text](/Homework_Lesson10_GIT/img/step_2.png)

## Задание 2: Использование reflog

1. Просмотр истории действий:
```bash
git reflog
```
![alt text](/Homework_Lesson10_GIT/img/step_3.png)

2. Переход к предыдущему коммиту:
```bash
# Выберите хеш нужного коммита из reflog
git checkout HEAD~1 # или git checkout <hash>
```
![alt text](/Homework_Lesson10_GIT/img/step_4.png)

## Задание 3: Создание новой ветки

```bash
git checkout -b develop
git branch # для проверки текущей ветки
```
![alt text](/Homework_Lesson10_GIT/img/step_5.png)

## Задание 4: Использование amend

1. Создайте коммит:
```bash
echo "Новый контент" > file3.txt
git add file3.txt
git commit -m "add third file"
```

2. Внесите дополнительные изменения:
```bash
echo "." >> file3.txt
git add file3.txt
git commit --amend --no-edit
```

![alt text](/Homework_Lesson10_GIT/img/step_6.png)

## Задание 5-6: Перемещение коммита в новую ветку

1. Переключитесь на main и создайте коммит:
```bash
git checkout master
echo "Контент для master" > main-file.txt
git add main-file.txt
git commit -m "add main file"
```
![alt text](/Homework_Lesson10_GIT/img/step_7.png)

2. Создайте новую ветку и переместите коммит:
```bash
git branch new-branch
git reset --hard HEAD~1
```

## Задание 7: Локальные изменения

```bash
echo "Новые изменения" >> file1.txt
git add file1.txt
git commit -m "add new changes"

```

## Задание 8: Отмена изменений через checkout

```bash
# Сохраните хеш текущего коммита
git log --oneline # копируем хеш
git checkout <hash> file1.txt
```
![alt text](/Homework_Lesson10_GIT/img/step_8.png)

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
git clone git@github.com:mikroNQ/Personal_GIT_Task.git
```

