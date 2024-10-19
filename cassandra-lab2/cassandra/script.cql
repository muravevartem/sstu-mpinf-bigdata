create keyspace social
    with replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
use social;

create table if not exists social.profile
(
    profile_id UUID,
    username   text,
    firstName  text,
    lastName   text,
    primary key ( profile_id )
);

create table if not exists social.post
(
    post_id   UUID,
    author_id UUID,
    subject   text,
    body      text,
    time      timestamp,
    primary key ( post_id, time )
);

create table if not exists social.comment
(
    comment_id UUID,
    post_id    UUID,
    profile_id UUID,
    reply_to   UUID,
    body       text,
    time       timestamp,
    primary key ( comment_id, time )
);

insert into social.profile (profile_id, username, firstName, lastName)
values (d4647724-45b4-41b8-88bd-59fce91bcc92, 'muravevas', 'Артём', 'Муравьев');
insert into social.profile (profile_id, username, firstName, lastName)
values (42a37576-a62f-45f1-8f1a-5a23b0904f9d, 'ivanovii', 'Иван', 'Иванов');
insert into social.profile (profile_id, username, firstName, lastName)
values (57200cd2-55b9-4853-8c86-f197f67527e2, 'serveevss', 'Сергей', 'Сергеев');

select * from social.profile;

insert into social.post (post_id, author_id, subject, body, time)
values (ea6391f9-8e3c-47cc-be43-93cb81b42310, d4647724-45b4-41b8-88bd-59fce91bcc92 , 'Cassandra single node', 'docker run', toTimestamp(now()));
insert into social.post (post_id, author_id, subject, body, time)
values (7c9d2f6c-05c8-4d8b-9ce3-c6f5ebc928f0, d4647724-45b4-41b8-88bd-59fce91bcc92, 'Cassandra cluster', 'docker run on cluster', toTimestamp(now()));
insert into social.post (post_id, author_id, subject, body, time)
values (0ab537b0-bc4e-44fd-801f-1caff496c0c4, 57200cd2-55b9-4853-8c86-f197f67527e2, 'Test post', 'It is test post', toTimestamp(now()));

select * from social.post;

insert into social.comment (comment_id, time, body, post_id, profile_id, reply_to)
values (cffeee85-62b5-4136-9666-1b953f2be0e5, totimestamp(now()), 'одна нода не интересно, давай 3!', 0ab537b0-bc4e-44fd-801f-1caff496c0c4, 42a37576-a62f-45f1-8f1a-5a23b0904f9d, null);
insert into social.comment (comment_id, time, body, post_id, profile_id, reply_to)
values (cd6cf992-75f4-4943-97f9-74f407b9de5f, toTimestamp(now()), 'Готово #7c9d2f6c-05c8-4d8b-9ce3-c6f5ebc928f0', 0ab537b0-bc4e-44fd-801f-1caff496c0c4, d4647724-45b4-41b8-88bd-59fce91bcc92, cffeee85-62b5-4136-9666-1b953f2be0e5);
insert into social.comment (comment_id, time, body, post_id, profile_id, reply_to)
values (4ece5792-c081-4edd-890a-551e98695ae5, toTimestamp(now()), '3 мало, давай 10!', 7c9d2f6c-05c8-4d8b-9ce3-c6f5ebc928f0, 42a37576-a62f-45f1-8f1a-5a23b0904f9d, null);

select * from social.comment;

create index if not exists post_author_idx
    on social.post (author_id);

create index if not exists comment_author_idx
    on social.comment (profile_id);

create index if not exists comment_reply_to_idx
    on social.comment (reply_to);

create index if not exists comment_post_idx
    on social.comment (post_id);

-- получение всех постов с автором с id = d4647724-45b4-41b8-88bd-59fce91bcc92
select * from social.post
where author_id = d4647724-45b4-41b8-88bd-59fce91bcc92;

-- получение информации о профиле с id = d4647724-45b4-41b8-88bd-59fce91bcc92
select * from social.profile
where profile_id = d4647724-45b4-41b8-88bd-59fce91bcc92;

-- получение информации под постом 0ab537b0-bc4e-44fd-801f-1caff496c0c4
select * from social.comment
where post_id = 0ab537b0-bc4e-44fd-801f-1caff496c0c4 and time < toTimestamp(now())