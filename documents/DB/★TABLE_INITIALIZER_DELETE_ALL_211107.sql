
CLEAR SCREEN;



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
