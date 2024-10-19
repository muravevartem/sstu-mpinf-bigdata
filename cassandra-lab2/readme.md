# Lab 2 -- Cassandra
- Создание keyspace (аналог БД из РСУБД)
```sql
create keyspace messenger
    with replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

```
- Создание таблиц
```sql
create table messenger.profile
(
    profile_id UUID,
    username   text,
    firstName  text,
    lastName   text,
    primary key ( profile_id )
);

create table messenger.post
(
    post_id   UUID,
    author_id UUID,
    subject   text,
    body      text,
    time      timestamp,
    primary key ( post_id, time )
);

create table messenger.comment
(
    comment_id UUID,
    post_id    UUID,
    profile_id UUID,
    reply_to   UUID,
    body       text,
    time       timestamp,
    primary key ( comment_id, time )
);
```
- Заполнение данными
