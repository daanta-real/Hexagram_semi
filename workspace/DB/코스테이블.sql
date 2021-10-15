create table course(
course_id NUMBER(30) primary key,
users_idx references users(users_idx) on delete cascade, --회원이 탈퇴하면 글이 삭제되야 한다.
course_list VARCHAR2(2000) not null,
course_detail VARCHAR2(2000),
course_locations VARCHAR2(2000) not null,
course_tags VARCHAR2(2000)
);

-- 코스테이블 시퀀스?
create sequence course_seq;

-- 코스테이블 테스트 등록(inster)
insert into course(course_id, course_list, course_detail, course_locations, course_tags)
    values(course_seq.nextval, '목록(홍대-신촌-아현)', '내용(상상마당,각종유흥)', '지역(서울)', '태그(#홍대,#젊음의거리)');
    
-- 코스테이블 테스트 수정(update)
-- 궁금증 (코스번호(course_id)로 입력받고 수정을 하는지, 회원번호(user_idx)를 입력받고 수정하는지)
update course set course_list='목록(홍대-신촌)', course_detail='내용(상상마당)', course_locations='지역(서울서울)', course_tags='태그(#홍대)' where course_id = 2;