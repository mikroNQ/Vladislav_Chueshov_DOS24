## Задания:

```bash
1. Создание нового файла с использованием vim
2. Редактирование существующего файла
3. Установить утилиту nginx, посмотреть ее логи и также уровень нагрузки на ОС. Просмотрите логи действий пользователей системы. 
Опционально: 
Установите веб-сервер Apache 2.
Установите утилиту logrotate, которая помещает access.log и error.log веб-сервера
Apache в /var/log/app/. В системе он работает как пользователь и группа www-data
```

# Выполнение:

## Задание 1. Создание нового файла с использованием vim

![alt text](/Homework_Lesson9_UNIX_UTILITES_2/img/1.png)

## Задание 2. Редактирование существующего файла

![alt text](/Homework_Lesson9_UNIX_UTILITES_2/img/2.png)

## Задание 3. Установить утилиту nginx, посмотреть ее логи и также уровень нагрузки на ОС.Просмотрите логи действий пользователей системы


## 1. Установка Nginx

```bash
# Обновляем пакеты
sudo apt update

# Устанавливаем Nginx
sudo apt install nginx -y

# Проверяем статус
sudo systemctl status nginx

# Разрешаем Nginx в брандмауэре
sudo ufw allow 'Nginx HTTP'
```

## 2. Просмотр логов Nginx

```bash
# Просмотр access логов
sudo tail -f /var/log/nginx/access.log

# Просмотр error логов
sudo tail -f /var/log/nginx/error.log
```

## 3. Мониторинг нагрузки на ОС

```bash
# Установка утилиты htop
sudo apt install htop

# Запуск мониторинга
htop

```

![alt text](/Homework_Lesson9_UNIX_UTILITES_2/img/3.png)



