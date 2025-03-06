# Playbook для установки Clickhouse, Vector и LightHouse

Playbook предназначен для установки и настройки Clickhouse, Vector и LightHouse на указанных хостах CentOS. Он автоматически загружает необходимые пакеты, устанавливает их и запускает соответствующие сервисы.

## Описание задач

### 1. Установка Clickhouse
Playbook выполняет следующие шаги для установки ClickHouse:
- Загружает дистрибутивы ClickHouse из официального репозитория.
- Устанавливает пакеты ClickHouse (clickhouse-client, clickhouse-server и clickhouse-common-static).
- Вносит правку в файле конфигурации ClickHouse /etc/clickhouse-server/config.xml, чтобы сервер слушал входящие соединения.
- Модифицирует файл конфигурации ClickHouse /etc/clickhouse-server/users.xml, настройки прописаны в jinja-шаблоне [clickhouse.users.j2](playbook/templates/clickhouse.users.j2):
    - ограничивает доступ пользователю default, оставляет права только на чтение
    - добавляет нового пользователя netology и задаёт ему паролем
- После установки и настройки запускает сервис ClickHouse.
- Создаёт базу данных `hw_demo_logs` и таблицу `hw_demo_logs_table` (вновь не создаются если уже существуют).

### 2. Установка Vector
Playbook выполняет следующие шаги для установки Vector:
- Загружает дистрибутив Vector из официального репозитория.
- Устанавливает пакет Vector.
- Создаёт файл конфигурации для Vector, с помощью jinja-шаблонов.
- Запускает сервис Vector после установки.

### 3. Установка и настройка LightHouse, Nginx
Playbook выполняет следующие шаги для установки LightHouse:
- Устанавливает Nginx для работы LightHouse.
- Создаёт конфигурацию Nginx.
- Загружает и распаковывает архив LightHouse.
- Генерирует файл конфигурации lighthouse.conf из шаблона и сохраняет его в папке конфигурации Nginx.
- Перезагружает либо запускает Nginx.
- Формирует URL строку для доступа к интерфейсу Lighthouse с необходимыми параметрами.

## Переменные

- `clickhouse_version`  : Версия ClickHouse, которая будет установлена.
- `clickhouse_packages` : Список пакетов ClickHouse для загрузки и установки (например, `clickhouse-client`, `clickhouse-server`, `clickhouse-common-static`).
- `clickhouse_user`     : Логин пользователя ClickHouse.
- `clickhouse_password` : Пароль пользователя ClickHouse.
- `vector_version`      : Версия Vector, которая будет установлена.
- `vector_config_dir`   : Каталог в котором располагается конфигурационный файл Vector.
- `lighthouse_link_zip` : URL откуда будет загружаться LightHouse.
- `lighthouse_location_dir`:  Директория куда будет загружаться LightHouse.

## Теги

- `install_clickhouse`: тег для выполнения задач связанных с установкой ClickHouse.
- `install_vector`: тег для выполнения задач связанных с установкой Vector.
- `install_lighthouse`: тег для выполнения задач связанных с установкой LightHouse и настройкой Nginx.

## Использование

Playbook тестировался с использованием интерпритатора Python версии 3.9.

Для запуска playbook используйте команду:

```bash
ansible-playbook site.yml -i inventory/prod.yml
```

Для доступа к интерфейсу Lighthouse скопируйте URL строку, которая формируется в конце выполнения playbook, пример:

```bash
TASK [Lighthouse - User URL] **********************************************************************

ok: [lighthouse-01] => {
    "msg": "http://158.160.39.142/#http://158.160.49.30:8123/?user=netology"
}

```