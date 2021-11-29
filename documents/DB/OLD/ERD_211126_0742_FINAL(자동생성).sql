CREATE TABLE `item` (
	`item_idx`	NUMBER(20)	NOT NULL	COMMENT 'PRIMARY KEY',
	`users_idx`	NUMBER(20)	NOT NULL,
	`item_type`	CHAR(9)	NOT NULL,
	`item_name`	VARCHAR2(100)	NOT NULL,
	`item_detail`	VARCHAR2(2000)	NOT NULL,
	`item_period`	VARCHAR2(100)	NULL,
	`item_time`	VARCHAR2(100)	NULL,
	`item_homepage`	VARCHAR2(100)	NULL,
	`item_parking`	VARCHAR2(100)	NULL,
	`item_address`	VARCHAR2(100)	NOT NULL,
	`item_date`	DATE	NOT NULL	DEFAULT SYSDATE,
	`item_count_view`	NUMBER(20)	NOT NULL	DEFAULT 0,
	`item_count_reply`	NUMBER(20)	NOT NULL	DEFAULT 0
);

CREATE TABLE `couse_item` (
	`course_item_idx`	NUMBER(20)	NOT NULL	COMMENT 'PRIMARY KEY',
	`item_idx`	NUMBER(20)	NOT NULL,
	`course_idx`	NUMBER(20)	NOT NULL
);

CREATE TABLE `item_reply` (
	`item_reply_idx`	NUMBER(20)	NOT NULL	COMMENT 'PRIMARY KEY',
	`users_idx`	NUMBER(20)	NOT NULL,
	`item_idx`	NUMBER(20)	NOT NULL,
	`item_reply_detail`	VARCHAR2(2000)	NOT NULL,
	`item_reply_date`	DATE	NOT NULL	DEFAULT SYSDATE,
	`item_reply_superno`	NUMBER(20)	NULL	COMMENT 'REFERENCE',
	`item_reply_groupno`	NUMBER(20)	NOT NULL,
	`item_reply_depth`	NUMBER(20)	NOT NULL
);

CREATE TABLE `course_reply` (
	`course_reply_idx`	NUMBER(20)	NOT NULL	COMMENT 'PRIMARY KEY',
	`users_idx`	NUMBER(20)	NOT NULL,
	`course_db_idx`	NUMBER(20)	NOT NULL,
	`course_reply_detail`	VARCHAR2(2000)	NOT NULL,
	`course_reply_date`	DATE	NOT NULL	DEFAULT SYSDATE,
	`course_reply_superno`	NUMBER(20)	NOT NULL	COMMENT 'REFERENCE',
	`course_reply_groupno`	NUMBER(20)	NOT NULL,
	`course_reply_depth`	NUMBER(20)	NOT NULL
);

CREATE TABLE `event` (
	`event_idx`	NUMBER(20)	NOT NULL	COMMENT 'PRIMARY KEY',
	`users_idx`	NUMBER(20)	NOT NULL,
	`event_name`	VARCHAR2(100)	NOT NULL,
	`event_detail`	VARCHAR2(2000)	NOT NULL,
	`event_date`	DATE	NOT NULL	DEFAULT SYSDATE,
	`event_count_view`	NUMBER(20)	NOT NULL	DEFAULT 0,
	`event_count_reply`	NUMBER(20)	NOT NULL	DEFAULT 0
);

CREATE TABLE `course` (
	`course_idx`	NUMBER(20)	NOT NULL	COMMENT 'PRIMARY KEY',
	`users_idx`	NUMBER(20)	NOT NULL,
	`course_name`	VARCHAR2(100)	NOT NULL,
	`course_detail`	VARCHAR2(2000)	NOT NULL,
	`course_date`	DATE	NOT NULL	DEFAULT SYSDATE,
	`course_count_view`	NUMBER(20)	NOT NULL	DEFAULT 0,
	`course_count_reply`	NUMBER(20)	NOT NULL	DEFAULT 0
);

CREATE TABLE `users` (
	`users_idx`	NUMBER(20)	NOT NULL	COMMENT 'PRIMARY KEY',
	`users_id`	VARCHAR2(20)	NULL,
	`users_pw`	VARCHAR2(20)	NULL,
	`users_nick`	VARCHAR2(30)	NULL,
	`users_email`	VARCHAR2(30)	NULL,
	`users_phone`	CHAR(13)	NULL,
	`users_join`	DATE	NOT NULL	DEFAULT SYSDATE,
	`users_point`	NUMBER(20)	NOT NULL,
	`users_grade`	CHAR(9)	NOT NULL
);

CREATE TABLE `item_file` (
	`item_file_idx`	number	NOT NULL,
	`item_idx`	NUMBER(20)	NOT NULL	COMMENT 'PRIMARY KEY',
	`item_file_uploadname`	varchar2(256)	NULL,
	`item_file_savename`	varchar2(256)	NULL,
	`item_file_size`	number	NULL,
	`item_file_type`	varchar2(256)	NULL
);

CREATE TABLE `event_file` (
	`event_file_idx`	number	NOT NULL,
	`event_idx`	NUMBER(20)	NOT NULL	COMMENT 'PRIMARY KEY',
	`event_file_uploadname`	varchar2(256)	NULL,
	`event_file_savename`	varchar2(256)	NULL,
	`event_file_size`	number	NULL,
	`event_file_type`	varchar2(256)	NULL
);

CREATE TABLE `course_like` (
	`users_idx`	NUMBER(20)	NOT NULL	COMMENT 'REFERENCE',
	`course_idx`	NUMBER(20)	NOT NULL	COMMENT 'REFERENCE'
);

ALTER TABLE `item` ADD CONSTRAINT `PK_ITEM` PRIMARY KEY (
	`item_idx`,
	`users_idx`
);

ALTER TABLE `couse_item` ADD CONSTRAINT `PK_COUSE_ITEM` PRIMARY KEY (
	`course_item_idx`,
	`item_idx`
);

ALTER TABLE `item_reply` ADD CONSTRAINT `PK_ITEM_REPLY` PRIMARY KEY (
	`item_reply_idx`,
	`users_idx`,
	`item_idx`
);

ALTER TABLE `course_reply` ADD CONSTRAINT `PK_COURSE_REPLY` PRIMARY KEY (
	`course_reply_idx`,
	`users_idx`,
	`course_db_idx`
);

ALTER TABLE `event` ADD CONSTRAINT `PK_EVENT` PRIMARY KEY (
	`event_idx`,
	`users_idx`
);

ALTER TABLE `course` ADD CONSTRAINT `PK_COURSE` PRIMARY KEY (
	`course_idx`,
	`users_idx`
);

ALTER TABLE `users` ADD CONSTRAINT `PK_USERS` PRIMARY KEY (
	`users_idx`
);

ALTER TABLE `item_file` ADD CONSTRAINT `PK_ITEM_FILE` PRIMARY KEY (
	`item_file_idx`,
	`item_idx`
);

ALTER TABLE `event_file` ADD CONSTRAINT `PK_EVENT_FILE` PRIMARY KEY (
	`event_file_idx`,
	`event_idx`
);

ALTER TABLE `course_like` ADD CONSTRAINT `PK_COURSE_LIKE` PRIMARY KEY (
	`users_idx`,
	`course_idx`
);

ALTER TABLE `item` ADD CONSTRAINT `FK_users_TO_item_1` FOREIGN KEY (
	`users_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `couse_item` ADD CONSTRAINT `FK_item_TO_couse_item_1` FOREIGN KEY (
	`item_idx`
)
REFERENCES `item` (
	`item_idx`
);

ALTER TABLE `item_reply` ADD CONSTRAINT `FK_users_TO_item_reply_1` FOREIGN KEY (
	`users_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `item_reply` ADD CONSTRAINT `FK_item_TO_item_reply_1` FOREIGN KEY (
	`item_idx`
)
REFERENCES `item` (
	`item_idx`
);

ALTER TABLE `course_reply` ADD CONSTRAINT `FK_users_TO_course_reply_1` FOREIGN KEY (
	`users_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `course_reply` ADD CONSTRAINT `FK_course_TO_course_reply_1` FOREIGN KEY (
	`course_db_idx`
)
REFERENCES `course` (
	`course_idx`
);

ALTER TABLE `event` ADD CONSTRAINT `FK_users_TO_event_1` FOREIGN KEY (
	`users_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `course` ADD CONSTRAINT `FK_users_TO_course_1` FOREIGN KEY (
	`users_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `item_file` ADD CONSTRAINT `FK_item_TO_item_file_1` FOREIGN KEY (
	`item_idx`
)
REFERENCES `item` (
	`item_idx`
);

ALTER TABLE `event_file` ADD CONSTRAINT `FK_event_TO_event_file_1` FOREIGN KEY (
	`event_idx`
)
REFERENCES `event` (
	`event_idx`
);

ALTER TABLE `course_like` ADD CONSTRAINT `FK_users_TO_course_like_1` FOREIGN KEY (
	`users_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `course_like` ADD CONSTRAINT `FK_course_TO_course_like_1` FOREIGN KEY (
	`course_idx`
)
REFERENCES `course` (
	`course_idx`
);

