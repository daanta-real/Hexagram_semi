
create table course(
course_id NUMBER(30) primary key,
user_idX NUMBER(20) references user(user_idx),
course_list VARCHAR2(2000) not null,
course_detatil VARCHAR2(2000),
course_locations VARCHAR2(2000) not null,
course_tags VARCHAR2(2000)
);