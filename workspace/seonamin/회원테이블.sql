

create table user(
user_idx NUMBER(20) primary key,
user_id VARCHAR2(20) not null check(regexp_like(member_id, '^[a-z][a-z0-9-_]{4,19}$')),
user_pw VARCHAR2(20) not null check(regexp_like(member_pw, '^[a-zA-Z0-9-_!@#$]{8,20}$')),
user_nick VARCHAR2(30) not null,
user_email VARCHAR2(30),
user_phone char(13) not null check(regexp_like(member_phone, '^010-[0-9]{4}-[0-9]{4}$')),
user_grade VARCHAR2(12)  not null check(member_grade in ('일반회원', '관리자'))
);

--user_nick, user_email, user_phone은 회원가입시 필요할 것으로 예상되는 컬럼이라고 생각되서 추가함
--<제약조건>
--user_id : 필수입력정보. 첫글자는 영소문자만 허용. 두번째 글자부터는 영소문자, 0~9, 특수문자 -, _ 만 허용 4글자이상 19글자미만. 
--user_pw : 필수입력정보. 8글자이상 20글자 미만.
--user_phone : 필수입력정보. 형식이 정해져있는 문자열이라서 char로 설정  