-- users 테이블 재생성 구문 및 더미 모음

-- 테이블/시퀀스 비우기
DROP SEQUENCE users_seq;
DROP TABLE users;

-- 테이블/시퀀스 새로 정의
CREATE SEQUENCE users_seq;
CREATE TABLE users (

  users_idx   NUMBER(20)   NOT NULL,
  users_id    VARCHAR2(20) ,
  users_pw    VARCHAR2(20) ,
  users_nick  VARCHAR2(30) ,
  users_email VARCHAR2(30) ,
  users_phone CHAR(13)     ,
  users_join  DATE         DEFAULT SYSDATE NOT NULL,
  users_point NUMBER(20)   DEFAULT 0       NOT NULL,
  users_grade CHAR(9)      DEFAULT '준회원'      
);

-- 제약조건 설정
ALTER TABLE users ADD CONSTRAINT users_PK             PRIMARY KEY(users_idx);
ALTER TABLE users ADD CONSTRAINT users_grade_check_in CHECK(users_grade IN('준회원', '정회원', '관리자'));

-- 회원 dummy data
-- ※ 관리자1: ID admin , PW adminadmin, 닉네임 관리자1
-- ※ 관리자2: ID admin2, PW adminadmin, 닉네임 관리자2
-- ※ 회원1: ID testtest , PW testtest, 닉네임 test1
-- ※ 회원2: ID testtest2, PW testtest, 닉네임 테스트2
INSERT INTO users(users_idx,users_id, users_pw, users_nick, users_grade) VALUES(users_seq.nextval, 'admin' , 'adminadmin', '관리자1', '관리자');
INSERT INTO users(users_idx,users_id, users_pw, users_nick, users_grade) VALUES(users_seq.nextval, 'admin2', 'adminadmin', '관리자2', '관리자');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'testtest', 'testtest', 'test1');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'testtest2', 'testtest', '테스트2');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'cigarette', 'rhasdfafsn', 'nickname5');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'potato', 'afnsandf', '닉네임_6');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'platform', 'afndafdnadfn', '닉네임7');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'feedback', 'adfnadfn', '닉네임8');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'passion', 'BFSFBSFB', '닉네임9');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'administration', 'AEHHRWREH', '닉네임10');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'marketing', 'SHASHDASDH', '닉네임11');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'method', 'HRWHWRHRHWRH', '닉네임12');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'phone', 'ADHDAHADH', '닉네임13');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'area', 'ADFNADFNAD', '닉네임14');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'birthday', '135131353', '닉네임15');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'tennis', 'ASDHASDHHDAS', '닉네임16');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'village', '$%@#$%$@', '닉네임17');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'intention', 'asdfasdf', '닉네임18');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'government', 'asdfasdf', '닉네임19');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'beer', 'asdfasdf', '닉네임20');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'climate', 'asdfasdf', '닉네임21');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'sir', 'asdfasdf', '닉네임22');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'poet', 'asdfasdf', '닉네임23');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'basket', 'asdfasdf', '닉네임24');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'championship', 'asdfasdf', '닉네임25');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'ratio9', 'asdfasdf', '닉네임26');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'advertising1', 'asdfasdf', '닉네임27');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'garbage9', 'asdfasdf', '닉네임28');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'control3', 'asdfasdf', '닉네임29');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'session2', 'asdfasdf', '닉네임30');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'teacher9', 'asdfasdf', '닉네임31');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'operation4', 'asdfasdf', '닉네임32');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'basis9', 'asdfasdf', '닉네임33');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'child7', 'asdfasdf', '닉네임34');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'perception0', 'asdfasdf', '닉네임35');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'difference8', 'asdfasdf', '닉네임36');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'temperature1', 'asdfasdf', '닉네임37');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'cell9', 'asdfasdf', '닉네임38');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'player3', 'asdfasdf', '닉네임39');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'depression6', 'asdfasdf', '닉네임40');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'two2', 'asdfasdf', '닉네임41');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'actor7', 'asdfasdf', '닉네임42');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'editor5', 'asdfasdf', '닉네임43');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'insurance9', 'asdfasdf', '닉네임44');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'steak1', 'asdfasdf', '닉네임45');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'wife2', 'asdfasdf', '닉네임46');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'recommendation4', 'asdfasdf', '닉네임47');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'entry6', 'asdfasdf', '닉네임48');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'storage5', 'asdfasdf', '닉네임49');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'video9', 'asdfasdf', '닉네임50');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'attitude6', 'asdfasdf', '닉네임51');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'dealer1', 'asdfasdf', '닉네임52');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'love9', 'asdfasdf', '닉네임53');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'candidate9', 'asdfasdf', '닉네임54');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'dad8', 'asdfasdf', '닉네임55');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'midnight3', 'asdfasdf', '닉네임56');
INSERT INTO users(users_idx,users_id, users_pw, users_nick) VALUES(users_seq.nextval, 'africa5', 'asdfasdf', '닉네임57');

-- 저장
COMMIT;

-- 테이블 데이터 보기
SELECT * FROM users;