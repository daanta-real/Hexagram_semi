
CLEAR SCREEN;


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
