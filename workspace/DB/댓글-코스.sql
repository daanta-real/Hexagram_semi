
create table reply_course(
course_reply_idx NUMBER(20) primary key,
course_idx NUMBER(20) references course(course_id),
users_idx NUMBER(20) references users(users_idx),
course_reply_target_idx NUMBER(20),
course_reply_detail VARCHAR2(210) not null
);