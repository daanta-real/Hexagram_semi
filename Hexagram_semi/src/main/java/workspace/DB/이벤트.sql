create table event(
event_idx number(20) primary key,
users_idx references users(users_idx),
event_subject varchar2(100) not null,
event_detail varchar2(2000) not null,
event_ables varchar2(200)
);