
CLEAR SCREEN;



-- ★★★★★★★★★★ users ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (users)

-- 테이블/시퀀스 새로 정의 (users)
CREATE SEQUENCE users_seq;
CREATE TABLE    users (
  users_idx   NUMBER(20)   NOT NULL CONSTRAINT users_PK PRIMARY KEY,
  users_id    VARCHAR2(20) ,
  users_pw    VARCHAR2(20) ,
  users_nick  VARCHAR2(30) ,
  users_email VARCHAR2(30) ,
  users_phone CHAR(13)     ,
  users_join  DATE         DEFAULT SYSDATE NOT NULL,
  users_point NUMBER(20)   DEFAULT 0       NOT NULL,
  users_grade CHAR(9)      DEFAULT '준회원' CONSTRAINT users_grade_check_in CHECK(users_grade IN('준회원', '정회원', '관리자'))
);

-- 데이터 생성 (users)
-- ※ 관리자1: ID admin    , PW adminadmin, 닉네임 관리자1
-- ※ 관리자2: ID admin2   , PW adminadmin, 닉네임 관리자2
-- ※ 회원1  : ID testtest , PW testtest  , 닉네임 test1
-- ※ 회원2  : ID testtest2, PW testtest  , 닉네임 테스트2
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

-- 저장 (users)
COMMIT;

-- 테이블 데이터 보기 (users)
SELECT * FROM users;



-- ★★★★★★★★★★ item ★★★★★★★★★★

-- 테이블 생성 구문 및 더미 모음 (item)

-- 테이블/시퀀스 새로 정의 (item)
CREATE SEQUENCE item_seq;
CREATE TABLE    item(
  item_idx         NUMBER(20) CONSTRAINT item_PK PRIMARY KEY,
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
  item_reply_idx     NUMBER                                CONSTRAINT item_reply_pk PRIMARY KEY,
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
