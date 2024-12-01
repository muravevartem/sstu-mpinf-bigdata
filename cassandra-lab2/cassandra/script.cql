create keyspace social
            with replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
use social;

drop table if exists social.post;
drop table if exists social.post_viewing;
drop table if exists social.profile;

create table if not exists social.profile
(
    profile_id   uuid,
    username     text,
    email        text,
    email_domain text,
    gender       tinyint,
    first_name   text,
    last_name    text,
    tel          text,
    tel_code     text,
    country_code text,
    region_code  text,
    birth_date   date,
    created_at   timestamp,
    primary key ( (country_code, region_code), gender, created_at )
);

create table if not exists social.post
(
    author_id    uuid,
    post_id      uuid,
    subject      text,
    subject_size int,
    body         text,
    body_size    int,
    client_name  text,
    client_ipv4  inet,
    created_at   timestamp,
    is_mobile    boolean,
    primary key ( author_id, client_name, created_at)
);

create table if not exists social.post_viewing
(
    post_id              uuid,
    client_ipv4          inet,
    client_name          text,
    viewed_at            timestamp,
    country_code         text,
    is_mobile            boolean,
    window_client_height smallint,
    window_client_width  smallint,
    primary key ( post_id, country_code, is_mobile, window_client_height, window_client_width, client_name, viewed_at)
);

select uuid()
from system.local;

insert into social.profile (profile_id, username, email, email_domain, gender, first_name, last_name, tel, tel_code,
                            country_code, region_code, birth_date, created_at)
values (de3c4e5c-da7d-4da7-9d91-c221bf7399f2, 'muravevas', 'muravevas@yandex.ru', 'yandex.ru', 0, 'Артём', 'Муравьев',
        '+7 978 744-25-02', '+7', 'RU', 'RU-SAR', '2002-02-08', totimestamp(now()));

insert into social.profile (profile_id, username, email, email_domain, gender, first_name, last_name, tel, tel_code,
                            country_code, region_code, birth_date, created_at)
values (28df9a18-0ac9-445e-87ed-66337a3d53fe, 'ivanovii', 'ivanov1976@mail.ru', 'mail.ru', 0, 'Иван', 'Иванов',
        '+7 926 410-13-75', '+7', 'RU', 'RU-AL', '1976-01-01', toTimestamp(now()));

insert into social.profile (profile_id, username, email, email_domain, gender, first_name, last_name, tel, tel_code,
                            country_code, region_code, birth_date, created_at)
values (3758108d-b9a2-4c99-9467-a1bbc4ffe00e, 'alekseeva123456', 'email@yahoo.com', 'yahoo', 1, 'Александра',
        'Алексеева', '+375 44 340-55-67', '+375', 'BY', 'BY_MI', '1999-02-02', toTimestamp(now()));

insert into social.profile (profile_id, username, email, email_domain, gender, first_name, last_name, tel, tel_code,
                            country_code, region_code, birth_date, created_at)
values (62f0efe4-f101-45dc-a0ca-884c727f1ecb, 'gerasimova9402394', 'gerasimova@yandex.by', 'yandex.by', 1, 'Ирина',
        'Герасимова',
        '+7 992 748-78-20', '+7', 'RU', 'RU_SMO', '1994-03-03', toTimestamp(now()));

insert into social.post (post_id, author_id, subject, subject_size, body, body_size, client_name, client_ipv4,
                         created_at,
                         is_mobile)
values (00cfcdf3-6910-409c-9d84-f02168dc4998, 28df9a18-0ac9-445e-87ed-66337a3d53fe, 'Cassandra в Docker', 18,
        'История о том, как я кассандру в докере запускал', 48, 'Mozilla', '88.146.178.30', toTimestamp(now()),
        true);

insert into social.post (post_id, author_id, subject, subject_size, body, body_size, client_name, client_ipv4,
                         created_at,
                         is_mobile)
values (6958308a-9915-4334-98a2-35cdf1f85b95, 28df9a18-0ac9-445e-87ed-66337a3d53fe, 'Cassandra в Docker 2', 20,
        'История о том, как я кассандру в докере поддерживал', 51, 'Safari', '225.214.219.82', toTimestamp(now()),
        false);

insert into social.post (post_id, author_id, subject, subject_size, body, body_size, client_name, client_ipv4,
                         created_at,
                         is_mobile)
values (7ba00494-82b2-40fd-ad62-f2d78b95dbd3, 3758108d-b9a2-4c99-9467-a1bbc4ffe00e,
        'Генерируем случайные данные для Cassandra', 41,
        'История о том, как мне пришлось создавать случайно сгенерированный массив данных', 80, 'Chrome',
        '4.15.152.230', toTimestamp(now()),
        false);

insert into social.post (post_id, author_id, subject, subject_size, body, body_size, client_name, client_ipv4,
                         created_at,
                         is_mobile)
values (b60cb5c0-edf1-4cbf-90a7-a6fa33ed50c0, 3758108d-b9a2-4c99-9467-a1bbc4ffe00e,
        'Системы контроля версий в лабораторных работах', 48,
        'Системы контроля версий (CVS) помогают отслеивать выполенение лабораторных работ и не случайно не потерять их',
        109, 'Chrome', '93.236.0.143', toTimestamp(now()),
        false);

insert into social.post_viewing (post_id, client_ipv4, client_name, viewed_at, country_code, is_mobile,
                                 window_client_height, window_client_width)
values (b60cb5c0-edf1-4cbf-90a7-a6fa33ed50c0, '178.89.48.157', 'Chrome',
        toTimestamp(now()), 'RU', true, 640, 720);

insert into social.post_viewing (post_id, client_ipv4, client_name, viewed_at, country_code, is_mobile,
                                 window_client_height, window_client_width)
values (b60cb5c0-edf1-4cbf-90a7-a6fa33ed50c0, '78.116.43.145', 'Chrome',
        toTimestamp(now()), 'RU', true, 640, 720);

insert into social.post_viewing (post_id, client_ipv4, client_name, viewed_at, country_code, is_mobile,
                                 window_client_height, window_client_width)
values (b60cb5c0-edf1-4cbf-90a7-a6fa33ed50c0, '91.34.105.250', 'Safari',
        toTimestamp(now()), 'RU', true, 640, 720);

insert into social.post_viewing (post_id, client_ipv4, client_name, viewed_at, country_code, is_mobile,
                                 window_client_height, window_client_width)
values (b60cb5c0-edf1-4cbf-90a7-a6fa33ed50c0, '20.84.181.154', 'Mozilla',
        toTimestamp(now()), 'BY', true, 640, 720);

insert into social.post_viewing (post_id, client_ipv4, client_name, viewed_at, country_code, is_mobile,
                                 window_client_height, window_client_width)
values (b60cb5c0-edf1-4cbf-90a7-a6fa33ed50c0, '210.178.14.237', 'Chrome',
        toTimestamp(now()), 'BY', false, 1080, 1920);

insert into social.post_viewing (post_id, client_ipv4, client_name, viewed_at, country_code, is_mobile,
                                 window_client_height, window_client_width)
values (6958308a-9915-4334-98a2-35cdf1f85b95, '20.84.181.154', 'Mozilla',
        toTimestamp(now()), 'BY', true, 640, 720);

insert into social.post_viewing (post_id, client_ipv4, client_name, viewed_at, country_code, is_mobile,
                                 window_client_height, window_client_width)
values (6958308a-9915-4334-98a2-35cdf1f85b95, '210.178.14.237', 'Chrome',
        toTimestamp(now()), 'BY', false, 1080, 1920);

insert into social.post_viewing (post_id, client_ipv4, client_name, viewed_at, country_code, is_mobile,
                                 window_client_height, window_client_width)
values (00cfcdf3-6910-409c-9d84-f02168dc4998, '78.116.43.145', 'Chrome',
        toTimestamp(now()), 'RU', true, 640, 720);

insert into social.post_viewing (post_id, client_ipv4, client_name, viewed_at, country_code, is_mobile,
                                 window_client_height, window_client_width)
values (00cfcdf3-6910-409c-9d84-f02168dc4998, '91.34.105.250', 'Safari',
        toTimestamp(now()), 'RU', true, 640, 720);

insert into social.post_viewing (post_id, client_ipv4, client_name, viewed_at, country_code, is_mobile,
                                 window_client_height, window_client_width)
values (00cfcdf3-6910-409c-9d84-f02168dc4998, '20.84.181.154', 'Mozilla',
        toTimestamp(now()), 'BY', true, 640, 720);

-- Количество просмотров поста 00cfcdf3-6910-409c-9d84-f02168dc4998
select post_id, count(post_id)
from social.post_viewing
where post_id = 00cfcdf3-6910-409c-9d84-f02168dc4998
group by post_id;

-- Распределение просмотров постов по странам
select post_id, country_code, count(country_code)
from social.post_viewing
group by post_id, country_code;

-- Статистика длины постов по пользователям
select author_id,
       avg(subject_size) as avg_subject_size,
       max(subject_size) as max_subject_size,
       min(subject_size) as min_subject_size,
       avg(body_size)    as avg_body_size,
       max(body_size)    as max_body_size,
       min(body_size)    as min_body_size
from social.post
group by author_id;

-- Посты пользователя 3758108d-b9a2-4c99-9467-a1bbc4ffe00e
select subject, body, author_id
from social.post
where author_id = 3758108d-b9a2-4c99-9467-a1bbc4ffe00e;

-- Коды регионы, в которых зарегистрированы пользователи
select distinct country_code, region_code from social.profile
