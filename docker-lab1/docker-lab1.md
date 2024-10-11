# мПИНФ - BigData

* Установите Docker. Убедитесь в его работоспособности. Выведите информацию о Docker на экран (команды docker version, docker info)
![img.png](img.png)
* Выведите список образов на экран (docker image ls)
![img_1.png](img_1.png)
* Выведите список контейнеров на экран (docker container ls)
![img_2.png](img_2.png)
* Скопируйте простейший образ alpine с репозитория docker hub (docker pull). Убедитесь, что он появился в Docker
![img_3.png](img_3.png)
* Создайте и запустите на основе образа alpine два контейнера (в detach и attach режимах), указав для них названия. Покажите разницу между двумя режимами.

Detach: 
![img_4.png](img_4.png)

Attach:
![img_5.png](img_5.png)

* Выведите на экран статистику запущенных контейнеров (docker stats)
![img_6.png](img_6.png)
* Выведите на экран информацию о контейнере при помощи команды docker inspect
![img_7.png](img_7.png)
* Выведите в новый файл информацию о контейнере при помощи команды docker inspect
![img_8.png](img_8.png)
[alpine-detach.json](alpine-detach.json)
* Скопируйте созданный раннее файл в один из контейнеров (docker cp)
![img_9.png](img_9.png)
* Перейдите в контейнер и запустите там командную оболочку (docker exec)
![img_10.png](img_10.png)
* При помощи оболочки создайте в контейнере новую папку и новый пустой файл. Поместите пустой файл и ранее скопированный файл в новую папку (mkdir, cat, touch, mv)
![img_11.png](img_11.png)
* Запустите новый контейнер и убедитесь в том, что внесенные раннее изменения в новом контейнере не отображаются
![img_12.png](img_12.png)
* Остановите контейнер с изменениями (docker stop) и запустите его заново (docker start). Проверьте наличие там внесенных ранее изменений
![img_13.png](img_13.png)
* В контейнере, где были внесены изменения, при помощи оболочки и менеджера apk установите утилиты sudo и vim (apk update, apk add vim, apk add sudo)
![img_14.png](img_14.png)
* Скачайте из репозитория Docker Hub образ httpd (docker pull)
![img_15.png](img_15.png)
* Запустите новый контейнер на основе образа httpd. При этом установите соответствие порта 80 на компьютере порту 80 в контейнере
![img_16.png](img_16.png)
* Проверьте работоспособность развернутого в контейнере веб-сервера, обратившись к нему по http-протоколу (http://localhost:80)
![img_17.png](img_17.png)
* Создайте на компьютере папку, добавив туда несколько небольших файлов (любых)
* На основе одного из ранее созданных образов запустите контейнер, указав соответствие папки в контейнере папке на компьютере (docker run -v)
![img_18.png](img_18.png)
* Убедитесь в том, что изменения, вносимые в папку в контейнере, отображаются в папке на компьютере и наоборот
![img_19.png](img_19.png)
* Создайте dockerfile, в котором опишите логику создания нового образа на основе существующего образа alpine. В новом образе должен обновляться менеджер пакетов apk, устанавливаться текстовый редактор. Также в новом образе должна быть скопирована директория с файлами (любыми). 
Предусмотрите также установку переменной окружения AUTHOR, в качестве значения которой выступает ваша фамилия.
```dockerfile
FROM alpine:latest
RUN apk update
RUN apk add vim
COPY alpine-detach.json /alpine-detach.json
ENV AUTHOR=muravev
```
* Создайте образ на основе созданного ранее dockerfile. Создайте контейнер и проверьте результат действий, прописанных в dockerfile. (docker build, docker run)
![img_20.png](img_20.png)
![img_21.png](img_21.png)
![img_23.png](img_23.png)
![img_24.png](img_24.png)
* Создайте или найдите в открытых источниках compose-файл, описывающий кластер Hadoop. Кластер должен включать в себя главный узел, как минимум, 3 дочерних узла и прочие вспомогательные компоненты. Изучите все конструкции, из которых состоит compose-файл.
```yaml
version: "3"

services:
  namenode:
    image: apache/hadoop:3
    hostname: namenode
    ports:
      - 9870:9870
    env_file:
      - ./config
    environment:
      ENSURE_NAMENODE_DIR: "/tmp/hadoop-root/dfs/name"
    command: ["hdfs", "namenode"]
  datanode1:
    image: apache/hadoop:3
    command: [ "hdfs", "datanode" ]
    env_file:
      - ./config
    volumes:
      - ./datanode1:/hadoop/dfs/data
  datanode2:
    image: apache/hadoop:3
    command: [ "hdfs", "datanode" ]
    env_file:
      - ./config
    volumes:
      - ./datanode2:/hadoop/dfs/data
  datanode3:
    image: apache/hadoop:3
    command: [ "hdfs", "datanode" ]
    env_file:
      - ./config
    volumes:
      - ./datanode3:/hadoop/dfs/data
  resourcemanager:
    image: apache/hadoop:3
    hostname: resourcemanager
    command: [ "yarn", "resourcemanager" ]
    ports:
      - 8088:8088
    env_file:
      - ./config
  nodemanager:
    image: apache/hadoop:3
    command: [ "yarn", "nodemanager" ]
    env_file:
      - ./config
```
* Разверните инфраструктуру кластера Hadoop при помощи compose-файла. Проверьте её работоспособность. (docker compose up)
![img_25.png](img_25.png)
![img_26.png](img_26.png)
* Развернутый кластер. Сохраните его.