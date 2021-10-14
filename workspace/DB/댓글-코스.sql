
create table reply_course(
reply_id NUMBER(20) primary key,
course_id NUMBER(20) references course(course_id),
user_idx NUMBER(20) references user(user_idx),
reply_detail VARCHAR2(210) not null,
replay_target_id NUMBER(20)
);