# Задание 1 – добавить в cron скрипт/команду,которая будет очищать кэш apt (кэшируемые пакеты, пакеты, которые не могут быть загружены) раз в месяц в 16 часов.

# Задание 2 – запустить демон nodejs-приложения через systemd. 

## Выполнение Задния 1


1. Добавляем команду очистки кэша apt в cron:

```bash
sudo crontab -e
```

2. Добавьте следующую строку:

```bash
0 16 1 * * apt-get clean && apt-get autoclean
```

Расписание cron:
- 0 - минуты (0-я минута)
- 16 - час (16:00)
- 1 - день месяца (1-е число)
- * - месяц (каждый месяц)
- * - день недели (любой)

Скрипт будет выполняться автоматически в 16:00 первого числа каждого месяца.

![alt text](img/Screenshot%202024-10-28%20at%209.38.31 AM.png)

Проверка: 

![alt text](img/Screenshot%202024-10-28%20at%209.39.16 AM.png)

# Задание 2 

Устанавливаем пакеты:

```bash
sudo apt update
sudo apt install nodejs npm
```
И проверяем версии:
```bash 
node --version
npm --version
```


1. Подготовка приложения:
```bash
mkdir ~/nodeapp
cd ~/nodeapp
nano app.js  
```

2. Тестирование приложения:
```bash
MYAPP_PORT=3000 node app.js
curl http://localhost:3000    # проверка в другом терминале
```

3. Создание systemd сервиса:
```bash
sudo nano /etc/systemd/system/nodeapp.service
```
Ключевые параметры в конфиге:
- Environment=MYAPP_PORT=3000
- User=mikron
- WorkingDirectory=/home/mikron/nodeapp
- ExecStart=/usr/bin/node app.js
- Restart=always

![alt img](img/Screenshot%202024-10-28%20at%2011.05.42 AM.png)

4. Запуск сервиса:
```bash
sudo systemctl daemon-reload
sudo systemctl start nodeapp
sudo systemctl enable nodeapp    # автозапуск
```
![alt img](img/Screenshot%202024-10-28%20at%2011.01.48 AM.png)

5. Удаление (если нужно):
```bash
sudo systemctl stop nodeapp
sudo systemctl disable nodeapp
sudo rm /etc/systemd/system/nodeapp.service
sudo systemctl daemon-reload
rm -rf ~/nodeapp
```

Основные команды управления:
```bash
sudo systemctl status nodeapp    # проверка статуса
sudo systemctl restart nodeapp   # перезапуск
sudo journalctl -u nodeapp      # просмотр логов
```