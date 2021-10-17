
create table reply_course(
reply_idx NUMBER(20) primary key,
course_idx NUMBER(20) references course(course_id),
users_idx NUMBER(20) references users(users_idx),
reply_detail VARCHAR2(210) not null,
replay_target_id NUMBER(20)
);