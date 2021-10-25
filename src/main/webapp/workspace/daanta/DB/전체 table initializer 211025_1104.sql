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
insert into users(users_idx, users_id, users_pw, users_nick, users_email, users_phone, users_grade)
    values(users_seq.nextval, 'test11111', 'test11111', '테스트1111', 'test@test.com', '010-1111-1111', '관리자');
insert into users(users_idx, users_id, users_pw, users_nick, users_email, users_phone, users_grade)
    values(users_seq.nextval, 'testtest', 'testtest', '테스트테스트', 'testtest@test.com', '010-2222-1111', '관리자');
insert into users(users_idx, users_id, users_pw, users_nick, users_email, users_phone, users_grade)
    values(users_seq.nextval, 'testuser4', 'testuser4', '테스트유저4', 'testuser4@test.com', '010-4433-3344', '일반회원');
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
DELETE FROM item;
DROP   TABLE    item;
DROP   SEQUENCE item_seq;
CREATE SEQUENCE item_seq;
CREATE TABLE    item(
  item_idx    NUMBER(20)     PRIMARY KEY,
  users_idx   REFERENCES     users(users_idx),
  item_type   CHAR(9),
  item_name   VARCHAR2(100)  NOT NULL,
  item_detail VARCHAR2(2000) NOT NULL,
  item_tags   VARCHAR2(200)  NOT NULL,
  item_date   DATE,
  item_period VARCHAR2(200)
);
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