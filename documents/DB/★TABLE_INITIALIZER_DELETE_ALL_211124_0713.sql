
CLEAR SCREEN;


-- ★★★★★★★★★★ course_reply ★★★★★★★★★★

-- 테이블 데이터 삭제 (course_reply)
TRUNCATE TABLE course_reply;

-- 테이블/시퀀스 삭제 (course_reply)
DROP SEQUENCE course_reply_seq;
DROP TABLE course_reply CASCADE CONSTRAINTS;



-- ★★★★★★★★★★ course_item ★★★★★★★★★★

-- 테이블 데이터 삭제 (course_item)
TRUNCATE TABLE course_item;

-- 테이블/시퀀스 삭제 (course_item)
DROP SEQUENCE course_item_seq;
DROP TABLE course_item CASCADE CONSTRAINTS;



-- ★★★★★★★★★★ course ★★★★★★★★★★

-- 테이블 데이터 삭제 (course)
TRUNCATE TABLE course;

-- 테이블/시퀀스 삭제 (course)
DROP SEQUENCE course_seq;
DROP TABLE course CASCADE CONSTRAINTS;



-- ★★★★★★★★★★ event_file ★★★★★★★★★★

-- 테이블 데이터 삭제 (event_file)
TRUNCATE TABLE event_file;

-- 테이블/시퀀스 삭제 (event_file)
DROP SEQUENCE event_file_seq;
DROP TABLE event_file CASCADE CONSTRAINTS;



-- ★★★★★★★★★★ board_event ★★★★★★★★★★

-- 테이블 데이터 삭제 (board_event)
TRUNCATE TABLE board_event;

-- 테이블/시퀀스 삭제 (board_event)
DROP SEQUENCE board_event_seq;
DROP TABLE board_event CASCADE CONSTRAINTS;



-- ★★★★★★★★★★ item_file ★★★★★★★★★★

-- 테이블 데이터 삭제 (item_file)
TRUNCATE TABLE item_file;

-- 테이블/시퀀스 삭제 (item_file)
DROP SEQUENCE item_file_seq;
DROP TABLE item_file CASCADE CONSTRAINTS;



-- ★★★★★★★★★★ item_reply ★★★★★★★★★★

-- 테이블 데이터 삭제 (item_reply)
TRUNCATE TABLE item_reply;

-- 테이블/시퀀스 삭제 (item_reply)
DROP SEQUENCE item_reply_seq;
DROP TABLE item_reply CASCADE CONSTRAINTS;



-- ★★★★★★★★★★ item ★★★★★★★★★★

-- 테이블 데이터 삭제 (item)
TRUNCATE TABLE item;

-- 테이블/시퀀스 삭제 (item)
DROP SEQUENCE item_seq;
DROP TABLE item CASCADE CONSTRAINTS;



-- ★★★★★★★★★★ users ★★★★★★★★★★

-- 테이블 데이터 삭제 (users)
TRUNCATE TABLE users;

-- 테이블/시퀀스 삭제 (users)
DROP SEQUENCE users_seq;
DROP TABLE users CASCADE CONSTRAINTS;
