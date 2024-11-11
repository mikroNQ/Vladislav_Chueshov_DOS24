## Задания:
RSYNC либо RCLONE
1. сделать синхронизацию с облачных хранилищем (S3, GCP Storage) c указанием NAME_SURNAME в имени папки
2. FDISK + LVM
3. *синхронизировать между собой две папки на двух разных вм-ках
4. *синхронизировать папки на двух вмках и ещё на GCP
____________________________________________
ссылки на GCP bucket
https://console.cloud.google.com/storage/browser/tms_123121419djscj_test
gs://tms_123121419djscj_test

## Задание 1. Сделать синхронизацию с облачных хранилищем (S3, GCP Storage) c указанием NAME_SURNAME в имени папки

## Выполнялось в условиях:
1. Ubuntu Server (Без GUI)
2. Python версии 3.5-3.11 (не 3.12, так как на момент выполнения дз gsutil не поддерживает её)

# Выполнение:

### 1. Подготовка Python окружения
```bash
# Установка Python 3.11
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.11

# Создание виртуального окружения
sudo apt install python3.11-venv
python3.11 -m venv ~/gsutil_env

# Активация виртуального окружения
source ~/gsutil_env/bin/activate
```

### 2. Очистка системы от старых версий Google Cloud SDK
```bash
# Удаление существующих установок
sudo apt-get remove google-cloud-sdk --purge
sudo apt-get autoremove

# Удаление остаточных файлов
sudo rm -rf /usr/lib/google-cloud-sdk
sudo rm -rf ~/google-cloud-sdk

# Очистка и обновление системы
sudo apt-get clean
sudo apt-get update
```

### 3. Установка Google Cloud SDK
```bash
curl https://sdk.cloud.google.com | bash

# При установке:
# - Принять путь по умолчанию (Enter)
# - Отказаться от отправки статистики (n)
# - Подтвердить установку (Y)
# - Разрешить модификацию PATH (Y)
# - Принять путь к rc файлу по умолчанию (Enter)
```

### 4. Настройка окружения
```bash
# Применение изменений в окружении
source ~/.bashrc

# Инициализация gcloud
gcloud init

# При инициализации:
# - Выбрать реинициализацию существующей конфигурации (1)
# - Войти в аккаунт Google через браузер
# - Выбрать нужный проект
```

### 5. Создание локальной директории и файлов для синхронизации
```bash
# Создание директории с вашим именем
mkdir ~/Vladislv_Chueshov

# Создание тестовых файлов (опционально)
echo "10.11.24" > ~/Vladislv_Chueshov/date.sh
```

### 6. Синхронизация с Google Cloud Storage
```bash
# Проверка доступа к bucket
gsutil ls gs://tms_123121419djscj_test/

# Выполнение синхронизации
gsutil -m rsync -r ~/Vladislav_Chueshov gs://tms_123121419djscj_test/Vladislav_Chueshov
```

```
- Параметр `-m` в команде rsync включает многопоточную загрузку
- Параметр `-r` обеспечивает рекурсивную синхронизацию
```

## Проверка результата:
```bash
# Просмотр синхронизированных файлов
gsutil ls gs://tms_123121419djscj_test/Vladislav_Chueshov/
```
![alt text](/Homework_Lesson8_UNIX_UTILITES_1/img/ls_gs.png)


## Задание 2. FDISK + LVM

## 1. Расширение виртуального диска
```bash
# Выключаем VM
# Переходим в директорию VirtualBox на Mac
cd /Applications/VirtualBox.app/Contents/MacOS/

# Расширить диск с 25GB до 27GB (25600 MB + 2048 MB = 27648 MB)
./VBoxManage modifyhd "/Users/ваше_имя/VirtualBox VMs/Ubuntu/Ubuntu.vdi" --resize 27648
```

## 2. Проверка текущего состояния дисков
```bash
# После загрузки VM
sudo fdisk -l
lsblk

# Пример вывода lsblk:
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda      8:0    0    27G  0 disk 
├─sda1   8:1    0     1G  0 part /boot/efi
├─sda2   8:2    0    15G  0 part /
├─sda3   8:3    0     5G  0 part /home
└─sda4   8:4    0   3.9G  0 part /boot
```

## 3. Создание нового раздела
```bash
sudo fdisk /dev/sda

# Команды в fdisk:
n    # новый раздел
[Enter]  # primary раздел
[Enter]  # номер раздела (5)
[Enter]  # начальный сектор по умолчанию
[Enter]  # конечный сектор по умолчанию
w    # записать и выйти
```

## 4. Форматирование и монтирование
```bash
# Форматирование раздела
sudo mkfs.ext4 /dev/sda5

# Создание точки монтирования
sudo mkdir /data

# Монтирование
sudo mount /dev/sda5 /data
```

## 5. Настройка автомонтирования
```bash
# Получение UUID
sudo blkid /dev/sda5
# Пример UUID="3dfd8c68-8793-465d-b926-7540108cb524"

# Редактирование fstab
sudo nano /etc/fstab

# Добавить строку:
UUID=3dfd8c68-8793-465d-b926-7540108cb524 /data ext4 defaults 0 2
```

## 6. Проверка
```bash
# Проверка монтирования
sudo mount -a

# Проверка размеров и монтирования
df -h
```

## Команды для диагностики:
```bash
lsblk        # показать структуру дисков
df -h        # показать использование дискового пространства
sudo blkid   # показать UUID разделов
mount        # показать примонтированные файловые системы
```

## Структура /etc/fstab:
```
UUID=xxx  /точка_монтирования  тип_фс  опции  dump  pass
```
- dump: 0 (отключить бэкап)
- pass: 2 (проверка после корневого раздела)

# Настройка LVM в Ubuntu Server 

## 1. Подготовка раздела
```bash
# Проверка текущих разделов
sudo fdisk -l
lsblk

# Удаление существующего раздела (если есть)
sudo fdisk /dev/sda
d    # удалить раздел
5    # номер раздела
w    # записать изменения

# Создание нового раздела для LVM
sudo fdisk /dev/sda
n    # новый раздел
[Enter]  # primary
5    # номер раздела
[Enter]  # начальный сектор (по умолчанию)
[Enter]  # конечный сектор (по умолчанию)
t    # сменить тип
5    # выбрать раздел
8e   # код для Linux LVM
w    # записать изменения
```

## 2. Настройка LVM
```bash
# Создание физического тома (PV)
sudo pvcreate /dev/sda5
# При запросе о очистке существующей подписи вводим 'y'

# Проверка PV
sudo pvs

# Создание группы томов (VG)
sudo vgcreate vg_data /dev/sda5

# Проверка VG
sudo vgs

# Создание логического тома (LV)
sudo lvcreate -l 100%FREE -n lv_data vg_data

# Проверка LV
sudo lvs
```

## 3. Создание файловой системы и монтирование
```bash
# Форматирование
sudo mkfs.ext4 /dev/vg_data/lv_data

# Создание точки монтирования
sudo mkdir -p /data

# Монтирование
sudo mount /dev/vg_data/lv_data /data

# Настройка автомонтирования
sudo nano /etc/fstab
# Добавить строку:
/dev/vg_data/lv_data    /data    ext4    defaults    0    2

# Перезагрузка systemd
sudo systemctl daemon-reload

# Проверка монтирования
sudo mount -a
df -h
```

## 4. Проверка настроек
```bash
# Просмотр всех компонентов LVM
sudo pvdisplay  # физические тома
sudo vgdisplay  # группы томов
sudo lvdisplay  # логические тома

# Проверка монтирования
df -h
```

## 5. Полезные команды для управления LVM

### Просмотр информации:
```bash
sudo pvs    # краткая информация о физических томах
sudo vgs    # краткая информация о группах томов
sudo lvs    # краткая информация о логических томах
```

### Расширение тома:
```bash
# Расширение логического тома
sudo lvextend -L +1G /dev/vg_data/lv_data

# Расширение файловой системы
sudo resize2fs /dev/vg_data/lv_data
```

## Проверка работоспособности:
```bash
# Создание тестового файла
sudo touch /data/test.txt

# Проверка прав доступа
ls -l /data

# Проверка доступного места
df -h /data
```

## 6. Настройка прав доступа

```bash
# Изменение владельца директории
sudo chown пользователь:пользователь /data

# Установка прав доступа (rwxr-xr-x)
sudo chmod 755 /data

# Проверка прав
ls -la /data
```

## Задание 3. *синхронизировать между собой две папки на двух разных вм-ках
 
# Устанавливаем rsync 
sudo apt-get install rsync

# Создаём SSH-ключ для беспарольной авторизации
ssh-keygen -t rsa

# Копируем публичный ключ на другую машину
ssh-copy-id username@ip_другой_vm

```bash
Всё это проделываем на вдух vm
```
# Для удобвста создадим скрипт и автозапуск 

``` bash
#!/bin/bash

SRC="/home/mikron/rsync_home_work/"
REMOTE="mikron2@192.168.56.4"
REMOTE_DIR="/home/mikron2/rsync_home_work/"

if ping -c 1 192.168.56.4 &> /dev/null; then
    rsync -avz $SRC $REMOTE:$REMOTE_DIR
    rsync -avz $REMOTE:$REMOTE_DIR $SRC
fi
```
# Настраиваем crontab

```bash
# Открываем crontab
crontab -e

# Добавляем строку для запуска каждые 5 минут
*/5 * * * * /path/to/script.sh
```
# Демонстрация 
![alt text](/Homework_Lesson8_UNIX_UTILITES_1/img/mirroring.png)

### Репликация работает в обе стороны


# Задание 4. *синхронизировать папки на двух вмках и ещё на GCP

## Выполнил, не хватило времени оформить. Все 4 выходных был без доступа к ПК
