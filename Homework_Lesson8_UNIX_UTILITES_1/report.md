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

## Предварительные требования:
1. Ubuntu Server (Без GUI)
2. Python версии 3.5-3.11 (не 3.12, так как на момент выполнения gsutil не поддерживает её)

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
