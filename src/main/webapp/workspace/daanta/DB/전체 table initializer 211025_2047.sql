테이블 회원 생성구문;
DELETE FROM users;
DROP TABLE users;
DROP SEQUENCE users_seq;
CREATE SEQUENCE users_seq;
CREATE TABLE    users (
  users_idx   NUMBER(20)   PRIMARY KEY,
  users_id    VARCHAR2(20) NOT NULL UNIQUE,
  users_pw    VARCHAR2(20) NOT NULL,
  users_nick  VARCHAR2(30) NOT NULL UNIQUE,
  users_email VARCHAR2(30),
  users_phone CHAR(13),
  users_grade CHAR(9) NOT NULL CHECK(users_grade in('준회원', '정회원', '관리자'))
);
COMMIT;
SELECT * FROM users;

테이블 회원 샘플데이터 구문
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email, users_phone, users_grade)
    VALUES(users_seq.NEXTVAL, 'test', 'test', '테스트', 'test@test.com', '010-0000-0000', '관리자');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email, users_phone, users_grade)
    VALUES(users_seq.NEXTVAL, 'test11111', 'test11111', '테스트1111', 'test@test.com', '010-1111-1111', '관리자');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email, users_phone, users_grade)
    VALUES(users_seq.NEXTVAL, 'testtest', 'testtest', '테스트테스트', 'testtest@test.com', '010-2222-1111', '관리자');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_email, users_phone, users_grade)
    VALUES(users_seq.NEXTVAL, 'testuser4', 'testuser4', '테스트유저4', 'testuser4@test.com', '010-4433-3344', '일반회원');
COMMIT;
SELECT * FROM users;

테이블 이벤트 생성구문
DELETE FROM event;
DROP   TABLE    event;
DROP   SEQUENCE event_seq;
CREATE SEQUENCE event_seq;
CREATE TABLE    event(
  event_idx     NUMBER(20)     PRIMARY KEY,
  users_idx     REFERENCES     users(users_idx),
  event_subject VARCHAR2(100)  NOT NULL,
  event_detail  VARCHAR2(2000) NOT NULL,
  event_period  VARCHAR2(200)
);
COMMIT;
SELECT * FROM event;


테이블 코스 생성구문
DELETE FROM course;
DROP   TABLE    course;
DROP   SEQUENCE course_seq;
CREATE SEQUENCE course_seq;
CREATE TABLE    course(
  course_idx       NUMBER(20)     PRIMARY KEY,
  users_idx        REFERENCES     users(users_idx),
  course_subject   VARCHAR2(100)  NOT NULL,
  course_list      VARCHAR2(2000) NOT NULL,
  course_locations VARCHAR2(2000) NOT NULL,
  course_detail    VARCHAR2(2000) NOT NULL,
  course_tags      VARCHAR2(2000) NOT NULL
);
COMMIT;
SELECT * FROM course;


테이블 댓글-코스 생성구문
※ course_reply_target_idx는 셀프 참조임
DELETE FROM course_reply;
DROP   TABLE    course_reply;
DROP   SEQUENCE course_reply_seq;
CREATE SEQUENCE course_reply_seq;
CREATE TABLE    course_reply(
  course_reply_idx        NUMBER(20)     PRIMARY KEY,
  course_reply_target_idx REFERENCES     course_reply(course_reply_idx),
  course_idx              REFERENCES     course(course_idx),
  users_idx               REFERENCES     users(users_idx),
  course_reply_detail     VARCHAR2(2000) NOT NULL
);
COMMIT;
SELECT * FROM course_reply;


테이블 관광지 생성구문
delete item;
drop table item;
drop sequence item_seq;
create sequence item_seq;
create table item(
item_idx number(20) primary key,
users_idx references users (users_idx),
item_type varchar2(9) default '관광지'
check(item_type in ('관광지','축제')),
item_name varchar2(100) not null unique,
item_address varchar2(150) not null,
item_detail varchar2(2000),
item_tags varchar2(1000),
item_date date default sysdate,
item_periods varchar2(100),
item_time varchar2(100),
item_homepage varchar2(100),
item_parking varchar2(100),
item_count number default 0 not null
);
INSERT INTO item(item_idx, users_idx, item_type, item_name, item_address, item_detail, item_tags, item_periods, item_time, item_homepage, item_parking) 
VALUES(item_seq.nextval, 1, '관광지', '경찰혼', '서울특별시 영등포구 국회대로 608', '우리 사회의 안정과 치안을 위해 순국ㆍ순직한 영등포경찰서 출신 경찰들의 숭고한 희생정신을 추모하고 그 분들의 고귀한 업적을 후세에 널리알리기 위하여 건립된 추모비이다.6ㆍ25전쟁 직후 전몰ㆍ순직한 경찰 62위 및 국내에서 발생한 각종 시위 진압과정에서 순직한 경찰 16위 등 총 78위의 경찰들을 기리고 있으며 서울영등포경찰서 내에 위치해 있다.', '#경찰', '기간없음', '운영시간없음', 'http://mfis.mpva.go.kr', '주차없음');
COMMIT;
SELECT * FROM item;

테이블 댓글-관광지 생성구문
DELETE FROM item_reply;
DROP   TABLE    item_reply;
DROP   SEQUENCE item_reply_seq;
CREATE SEQUENCE item_reply_seq;
CREATE table    item_reply( 
  item_reply_idx        NUMBER(20) PRIMARY KEY,
  item_idx              REFERENCES item(item_idx),
  users_idx             REFERENCES users(users_idx),
  item_reply_target_idx REFERENCES item(item_idx),
  item_reply_detail     VARCHAR2(2000)
);
COMMIT;
SELECT * FROM item_reply;