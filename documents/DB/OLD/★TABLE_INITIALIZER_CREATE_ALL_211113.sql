
CLEAR SCREEN;



-- ★★★★★★★★★★ users ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (users)

-- 테이블/시퀀스 새로 정의 (users)
CREATE SEQUENCE users_seq;
CREATE TABLE    users (
  users_idx   NUMBER(20)   CONSTRAINT users_idx_not_null NOT NULL CONSTRAINT users_PK PRIMARY KEY,
  users_id    VARCHAR2(20) CONSTRAINT users_id_unique UNIQUE,
  users_pw    VARCHAR2(20) ,
  users_nick  VARCHAR2(30) ,
  users_email VARCHAR2(30) ,
  users_phone CHAR(13)     ,
  users_join  DATE         DEFAULT SYSDATE  CONSTRAINT users_join_not_null NOT NULL,
  users_point NUMBER(20)   DEFAULT 0        CONSTRAINT users_number_not_null NOT NULL,
  users_grade CHAR(9)      DEFAULT '준회원' CONSTRAINT users_grade_check_in CHECK(users_grade IN('준회원', '정회원', '관리자'))
);

-- 데이터 생성 (users)
-- ※ 관리자1: ID admin    , PW adminadmin, 닉네임 관리자1
-- ※ 관리자2: ID admin2   , PW adminadmin, 닉네임 관리자2
-- ※ 회원1  : ID testtest , PW testtest  , 닉네임 test1
-- ※ 회원2  : ID testtest2, PW testtest  , 닉네임 테스트2
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_grade) VALUES(users_seq.NEXTVAL, 'admin' , 'adminadmin', '관리자1', '관리자');
INSERT INTO users(users_idx, users_id, users_pw, users_nick, users_grade) VALUES(users_seq.NEXTVAL, 'admin2', 'adminadmin', '관리자2', '관리자');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'testtest', 'testtest', 'test1');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'testtest2', 'testtest', '테스트2');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'cigarette', 'rhasdfafsn', 'nickname5');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'potato', 'afnsandf', '닉네임_6');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'platform', 'afndafdnadfn', '닉네임7');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'feedback', 'adfnadfn', '닉네임8');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'passion', 'BFSFBSFB', '닉네임9');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'administration', 'AEHHRWREH', '닉네임10');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'marketing', 'SHASHDASDH', '닉네임11');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'method', 'HRWHWRHRHWRH', '닉네임12');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'phone', 'ADHDAHADH', '닉네임13');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'area', 'ADFNADFNAD', '닉네임14');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'birthday', '135131353', '닉네임15');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'tennis', 'ASDHASDHHDAS', '닉네임16');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'village', '$%@#$%$@', '닉네임17');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'intention', 'asdfasdf', '닉네임18');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'government', 'asdfasdf', '닉네임19');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'beer', 'asdfasdf', '닉네임20');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'climate', 'asdfasdf', '닉네임21');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'sir', 'asdfasdf', '닉네임22');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'poet', 'asdfasdf', '닉네임23');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'basket', 'asdfasdf', '닉네임24');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'championship', 'asdfasdf', '닉네임25');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'ratio9', 'asdfasdf', '닉네임26');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'advertising1', 'asdfasdf', '닉네임27');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'garbage9', 'asdfasdf', '닉네임28');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'control3', 'asdfasdf', '닉네임29');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'session2', 'asdfasdf', '닉네임30');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'teacher9', 'asdfasdf', '닉네임31');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'operation4', 'asdfasdf', '닉네임32');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'basis9', 'asdfasdf', '닉네임33');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'child7', 'asdfasdf', '닉네임34');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'perception0', 'asdfasdf', '닉네임35');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'difference8', 'asdfasdf', '닉네임36');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'temperature1', 'asdfasdf', '닉네임37');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'cell9', 'asdfasdf', '닉네임38');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'player3', 'asdfasdf', '닉네임39');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'depression6', 'asdfasdf', '닉네임40');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'two2', 'asdfasdf', '닉네임41');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'actor7', 'asdfasdf', '닉네임42');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'editor5', 'asdfasdf', '닉네임43');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'insurance9', 'asdfasdf', '닉네임44');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'steak1', 'asdfasdf', '닉네임45');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'wife2', 'asdfasdf', '닉네임46');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'recommendation4', 'asdfasdf', '닉네임47');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'entry6', 'asdfasdf', '닉네임48');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'storage5', 'asdfasdf', '닉네임49');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'video9', 'asdfasdf', '닉네임50');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'attitude6', 'asdfasdf', '닉네임51');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'dealer1', 'asdfasdf', '닉네임52');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'love9', 'asdfasdf', '닉네임53');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'candidate9', 'asdfasdf', '닉네임54');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'dad8', 'asdfasdf', '닉네임55');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'midnight3', 'asdfasdf', '닉네임56');
INSERT INTO users(users_idx, users_id, users_pw, users_nick) VALUES(users_seq.NEXTVAL, 'africa5', 'asdfasdf', '닉네임57');

-- 저장 (users)
COMMIT;

-- 테이블 데이터 보기 (users)
SELECT * FROM users;



-- ★★★★★★★★★★ item ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (item)

-- 테이블/시퀀스 새로 정의 (item)
CREATE SEQUENCE item_seq;
CREATE TABLE    item(
  item_idx         NUMBER(20)                     NOT NULL CONSTRAINT item_PK PRIMARY KEY,
  users_idx        REFERENCES users (users_idx)  ON DELETE CASCADE,
  item_type        CHAR(9)                        NOT NULL CONSTRAINT item_type_check_in  CHECK (item_type IN ('관광지', '축제')),
  item_name        VARCHAR2(100)                  NOT NULL CONSTRAINT item_name_unique UNIQUE,
  item_detail      VARCHAR2(2000)                 NOT NULL,
  item_period      VARCHAR2(100),
  item_time        VARCHAR2(100),
  item_homepage    VARCHAR2(100),
  item_parking     VARCHAR2(1000),
  item_address     VARCHAR2(200)                  NOT NULL,
  item_date        DATE                           DEFAULT SYSDATE NOT NULL,
  item_count_view  NUMBER(20)                     DEFAULT 0 NOT NULL,
  item_count_reply NUMBER(20)                     DEFAULT 0 NOT NULL
);

-- 데이터 생성 (item)
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름1' , '관광지내용 관광지내용1' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름1'   , '축제내용 축제내용1'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름2' , '관광지내용 관광지내용2' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름2'   , '축제내용 축제내용2'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름3' , '관광지내용 관광지내용3' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름3'   , '축제내용 축제내용3'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름4' , '관광지내용 관광지내용4' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름4'   , '축제내용 축제내용4'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름5' , '관광지내용 관광지내용5' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름5'   , '축제내용 축제내용5'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름6' , '관광지내용 관광지내용6' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름6'   , '축제내용 축제내용6'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름7' , '관광지내용 관광지내용7' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름7'   , '축제내용 축제내용7'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름8' , '관광지내용 관광지내용8' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름8'   , '축제내용 축제내용8'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름9' , '관광지내용 관광지내용9' , null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름9'   , '축제내용 축제내용9'     , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름10', '관광지내용 관광지내용10', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름10'  , '축제내용 축제내용10'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름11', '관광지내용 관광지내용11', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름11'  , '축제내용 축제내용11'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름12', '관광지내용 관광지내용12', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름12'  , '축제내용 축제내용12'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름13', '관광지내용 관광지내용13', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름13'  , '축제내용 축제내용13'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름14', '관광지내용 관광지내용14', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름14'  , '축제내용 축제내용14'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름15', '관광지내용 관광지내용15', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름15'  , '축제내용 축제내용15'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);

INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름16', '관광지내용 관광지내용16', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름16'  , '축제내용 축제내용16'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이17'  , '관광지내용 관광지내용17', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름17'  , '축제내용 축제내용17'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름18', '관광지내용 관광지내용18', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름18'  , '축제내용 축제내용18'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름19', '관광지내용 관광지내용19', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름19'  , '축제내용 축제내용19'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름20', '관광지내용 관광지내용20', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름20'  , '축제내용 축제내용20'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름21', '관광지내용 관광지내용21', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름21'  , '축제내용 축제내용21'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름22', '관광지내용 관광지내용22', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름22'  , '축제내용 축제내용22'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름23', '관광지내용 관광지내용23', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름23'  , '축제내용 축제내용23'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름24', '관광지내용 관광지내용24', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름24'  , '축제내용 축제내용24'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름25', '관광지내용 관광지내용25', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름25'  , '축제내용 축제내용25'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름26', '관광지내용 관광지내용26', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름26'  , '축제내용 축제내용26'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름27', '관광지내용 관광지내용27', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름27'  , '축제내용 축제내용27'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름28', '관광지내용 관광지내용28', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름28'  , '축제내용 축제내용13'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름29', '관광지내용 관광지내용29', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름29'  , '축제내용 축제내용29'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '관광지', '관광지이름30', '관광지내용 관광지내용30', null                                    , '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 당산로'        , SYSDATE, 0, 0);
INSERT INTO item VALUES(item_seq.NEXTVAL, 1, '축제'  , '축제이름30'  , '축제내용 축제내용30'    , '축제기간 : 21.11.04부터 ~ 21.12.04까지', '09:00부터 ~ 22:00까지', 'http://test@test.com', '공원앞 주차가능', '서울시 영등포구 여의도 윤중대로', SYSDATE, 0, 0);

-- 저장 (item)
COMMIT;

-- 테이블 데이터 보기 (item)
SELECT * FROM item;



-- ★★★★★★★★★★ item_reply ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (item_reply)

-- 테이블/시퀀스 새로 정의 (item_reply)
CREATE SEQUENCE item_reply_seq;
CREATE TABLE    item_reply(
  item_reply_idx     NUMBER                                NOT NULL CONSTRAINT item_reply_PK PRIMARY KEY,
  users_idx          REFERENCES users (users_idx)         ON DELETE CASCADE NOT NULL,
  item_idx           REFERENCES item(item_idx)             ON DELETE CASCADE NOT NULL,
  item_reply_detail  VARCHAR2(2000)                        NOT NULL,
  item_reply_date    DATE                                  DEFAULT SYSDATE NOT NULL,
  item_reply_superno REFERENCES item_reply(item_reply_idx) ON DELETE SET NULL,
  item_reply_groupno NUMBER                                DEFAULT 0 NOT NULL,
  item_reply_depth   NUMBER                                DEFAULT 0 NOT NULL
);

-- 저장
COMMIT;

-- 테이블 데이터 보기
SELECT * FROM item_reply;




-- ★★★★★★★★★★ item_file ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (item_file)
-- 서블릿에서 파일 다운로드를 C:/image로 해놨기 때문에
-- 테이블 생성 후 C:/image 폴더 만들어야 합니다.

-- 테이블/시퀀스 새로 정의 (item_file)
CREATE SEQUENCE item_file_seq;
CREATE TABLE item_file(
item_file_idx        NUMBER                    NOT NULL            CONSTRAINT item_file_PK                PRIMARY KEY,
item_idx             REFERENCES item(item_idx) ON DELETE CASCADE,
item_file_uploadname VARCHAR2(256)             NOT NULL            CONSTRAINT item_file_uploadname_unique UNIQUE     ,
item_file_savename   VARCHAR2(256)             NOT NULL            CONSTRAINT item_file_savename_unique   UNIQUE     ,
item_file_size       NUMBER,
item_file_type       VARCHAR2(256)
);

-- 저장
COMMIT;

-- 테이블 데이터 보기
SELECT * FROM item_file;




-- ★★★★★★★★★★ board_event ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (board_event)

-- 테이블/시퀀스 새로 정의 (board_event)
CREATE SEQUENCE board_event_seq;
CREATE TABLE board_event(
  event_idx         NUMBER(20)                   NOT NULL CONSTRAINT event_PK PRIMARY KEY,
  users_idx         REFERENCES users(users_idx) ON DELETE SET NULL,
  event_name        VARCHAR2(100)                NOT NULL,
  event_detail      VARCHAR2(2000)               NOT NULL,
  event_date        DATE                         NOT NULL,
  event_count_view  NUMBER(20)                   DEFAULT 0 NOT NULL,
  event_count_reply NUMBER(20)                   DEFAULT 0 NOT NULL
);

-- 데이터 생성 (board_event)
INSERT INTO board_event VALUES(board_event_seq.NEXTVAL, 1, '노가리 투어 서포터즈', '관광코스 개발 및 월별 테마에 맞는 관광홍보미션 수행'                                        , TO_DATE('2021-11-01', 'YYYY-MM-DD'), 0, 0);
INSERT INTO board_event VALUES(board_event_seq.NEXTVAL, 3, '충북 청년 축제'      , '충북지역 청년들이 기획부터 운영까지 참여한 2021 충북 청년축제'                              , TO_DATE('2021-09-17', 'YYYY-MM-DD'), 0, 0);
INSERT INTO board_event VALUES(board_event_seq.NEXTVAL, 5, '강경 젓갈 축제'      , '강경젓갈시장에는 야간 경관을 조성해 강경을 찾는 관람객들에 아름다운 추억을 선사할 예정이다.', TO_DATE('2021-10-13', 'YYYY-MM-DD'), 0, 0);
INSERT INTO board_event VALUES(board_event_seq.NEXTVAL, 7, '괴산 고추 축제'      , '유기농의 메카, 괴산 방방곳곳 온-오프 투어'                                                  , TO_DATE('2021-08-26', 'YYYY-MM-DD'), 0, 0);
INSERT INTO board_event VALUES(board_event_seq.NEXTVAL, 9, '영주 사과 축제'      , '가을이 익어가는 계절, ‘영주사과’를 온라인으로 만난다'                                     , TO_DATE('2021-10-13', 'YYYY-MM-DD'), 0, 0);

-- 저장
COMMIT;

-- 테이블 데이터 보기
SELECT * FROM board_event;