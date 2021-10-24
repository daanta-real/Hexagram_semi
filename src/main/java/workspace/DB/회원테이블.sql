create table users(
users_idx NUMBER(20) primary key,
users_id VARCHAR2(20) not null check(regexp_like(users_id, '^[a-z][a-z0-9-_]{4,19}$')),
users_pw VARCHAR2(20) not null check(regexp_like(users_pw, '^[a-zA-Z0-9-_!@#$]{8,20}$')),
users_nick VARCHAR2(30) not null,
users_email VARCHAR2(30),
users_phone char(13) check(regexp_like(users_phone, '^010-[0-9]{4}-[0-9]{4}$')),
users_grade VARCHAR2(12) default '일반회원' check(users_grade in ('일반회원', '관리자'))
);

-- 시퀀스? 협의 필요
create sequence users_seq;

-- 테스트 등록 명령어
insert into users(users_idx, users_id, users_pw, users_nick, users_email, users_phone, users_grade)
    values(users_seq.nextval, 'test11111', 'test11111', '테스트1111', 'test@test.com', '010-1111-1111', '일반회원');
insert into users(users_idx, users_id, users_pw, users_nick, users_email, users_phone, users_grade)
    values(users_seq.nextval, 'testtest', 'testtest', '테스트테스트', 'testtest@test.com', '010-2222-1111', '관리자');

--users_nick, users_email, users_phone은 회원가입시 필요할 것으로 예상되는 컬럼이라고 생각되서 추가함

--<제약조건>
--users_id : 필수입력정보. 첫글자는 영소문자만 허용. 두번째 글자부터는 영소문자, 0~9, 특수문자 -, _ 만 허용 4글자이상 19글자미만. 
--users_pw : 필수입력정보. 8글자이상 20글자 미만.
--users_phone : 필수입력정보. 형식이 정해져있는 문자열이라서 char로 설정  
--users_grade : 등급미입력시 기본값 일반회원으로 설정

select * from users;

drop table users;
drop sequence users_seq;
