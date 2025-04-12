# Домашнее задание к занятию 14 «Средство визуализации Grafana»

## Задание повышенной сложности

**При решении задания 1** не используйте директорию [help](./help) для сборки проекта. Самостоятельно разверните grafana, где в роли источника данных будет выступать prometheus, а сборщиком данных будет node-exporter:

- grafana;
- prometheus-server;
- prometheus node-exporter.

За дополнительными материалами можете обратиться в официальную документацию grafana и prometheus.

В решении к домашнему заданию также приведите все конфигурации, скрипты, манифесты, которые вы 
использовали в процессе решения задания.

**При решении задания 3** вы должны самостоятельно завести удобный для вас канал нотификации, например, Telegram или email, и отправить туда тестовые события.

В решении приведите скриншоты тестовых событий из каналов нотификаций.

## Обязательные задания

## Задание 1

1. Используя директорию [help](./help) внутри этого домашнего задания, запустите связку prometheus-grafana.
1. Зайдите в веб-интерфейс grafana, используя авторизационные данные, указанные в манифесте docker-compose.
1. Подключите поднятый вами prometheus, как источник данных.
1. Решение домашнего задания — скриншот веб-интерфейса grafana со списком подключенных Datasource.

## Ответ 1

Используется имя контейнера вместо hostname, т.к. внутри одной Docker-сети., рис.:

![](img/10-03-01-01.png)


## Задание 2

Изучите самостоятельно ресурсы:

1. [PromQL tutorial for beginners and humans](https://valyala.medium.com/promql-tutorial-for-beginners-9ab455142085).
1. [Understanding Machine CPU usage](https://www.robustperception.io/understanding-machine-cpu-usage).
1. [Introduction to PromQL, the Prometheus query language](https://grafana.com/blog/2020/02/04/introduction-to-promql-the-prometheus-query-language/).

Создайте Dashboard и в ней создайте Panels:

- утилизация CPU для nodeexporter (в процентах, 100-idle);
- CPULA 1/5/15;
- количество свободной оперативной памяти;
- количество места на файловой системе.

Для решения этого задания приведите promql-запросы для выдачи этих метрик, а также скриншот получившейся Dashboard.

## Ответ 2

- утилизация CPU для nodeexporter (в процентах, 100-idle):
    ```
    100 - (avg by (instance) (rate(node_cpu_seconds_total{instance="nodeexporter:9100",job="nodeexporter",mode="idle"}[1m])) * 100)
    ```
- CPULA 1/5/15:
    ```
    node_load1{instance="nodeexporter:9100",job="nodeexporter"}
    node_load5{instance="nodeexporter:9100",job="nodeexporter"}
    node_load15{instance="nodeexporter:9100",job="nodeexporter"}
    ```
- количество свободной оперативной памяти:
    ```
    node_memory_MemFree_bytes{instance="nodeexporter:9100",job="nodeexporter"}
    ```
- количество свободной оперативной памяти:
    ```
    node_filesystem_free_bytes{instance="nodeexporter:9100", job="nodeexporter", mountpoint="/"}
    ```

Home > Dashboards > System Load Monitoring:

![](img/10-03-02-01.png)

## Задание 3

1. Создайте для каждой Dashboard подходящее правило alert — можно обратиться к первой лекции в блоке «Мониторинг».
1. В качестве решения задания приведите скриншот вашей итоговой Dashboard.

## Ответ 3

Создан и настроен бот в Telegram для приёма алертов [Configure Telegram for Alerting](https://grafana.com/docs/grafana/latest/alerting/configure-notifications/manage-contact-points/integrations/configure-telegram/):

![](img/10-03-03-01.png)

Создан алерт для "CPU Utilization (%)" вид графика "Time series":

![](img/10-03-03-02.png)

Для остальных видов визуализации (которые были выбраны мною) алерты недоступны:

![](img/10-03-03-03.png)

## Задание 4

1. Сохраните ваш Dashboard.Для этого перейдите в настройки Dashboard, выберите в боковом меню «JSON MODEL». Далее скопируйте отображаемое json-содержимое в отдельный файл и сохраните его.
1. В качестве решения задания приведите листинг этого файла.

## Ответ 4

[JSON_MODEL.json](JSON_MODEL.json)

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
