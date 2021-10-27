CREATE TABLE `board_item` (
	`item_idx`	NUMBER(20)	NOT NULL,
	`users_idx`	NUMBER(20)	NOT NULL,
	`item_type`	CHAR(9)	NULL,
	`item_name`	VARCHAR2(100)	NULL,
	`item_detail`	VARCHAR2(2000)	NULL,
	`item_date`	DATE	NULL,
	`item_address`	VARCHAR2(100)	NULL,
	`item_periods`	VARCHAR2(200)	NULL,
	`item_count`	NUMBER(20)	NULL,
	`item_target_idx`	NUMBER(20)	NOT NULL
);

CREATE TABLE `users` (
	`users_idx`	NUMBER(20)	NOT NULL,
	`users_id`	VARCHAR2(20)	NULL,
	`users_pw`	VARCHAR2(20)	NULL,
	`users_nick`	VARCHAR2(30)	NULL,
	`users_email`	VARCHAR2(30)	NULL,
	`users_phone`	CHAR(13)	NULL,
	`users_grade`	VARCHAR2(6)	NULL,
	`Field`	VARCHAR(255)	NULL
);

CREATE TABLE `couse_list` (
	`course_list_idx`	NUMBER(20)	NOT NULL,
	`course_idx`	NUMBER(20)	NOT NULL,
	`item_idx`	NUMBER(20)	NOT NULL
);

CREATE TABLE `item_reply` (
	`item_reply_idx`	NUMBER(20)	NOT NULL,
	`users_idx`	NUMBER(20)	NOT NULL,
	`item_idx`	NUMBER(20)	NOT NULL,
	`item_reply_idx2`	NUMBER(20)	NOT NULL,
	`item_reply_detail`	VARCHAR2(20)	NULL
);

CREATE TABLE `course_reply` (
	`course_reply_idx`	NUMBER(20)	NOT NULL,
	`users_idx`	NUMBER(20)	NOT NULL,
	`course_db_idx`	NUMBER(20)	NOT NULL,
	`course_reply_target`	NUMBER(20)	NOT NULL,
	`course_reply_detail`	VARCHAR2(2000)	NULL
);

CREATE TABLE `CopyOfcourse_reply2` (
	`event_reply_idx`	NUMBER(20)	NOT NULL,
	`users_idx`	NUMBER(20)	NOT NULL,
	`event_idx`	NUMBER(20)	NOT NULL,
	`event_reply_target_idx`	NUMBER(20)	NOT NULL,
	`event_reply_detail`	VARCHAR2(2000)	NULL
);

CREATE TABLE `board_event` (
	`event_idx`	NUMBER(20)	NOT NULL,
	`users_idx`	NUMBER(20)	NOT NULL,
	`item_idx`	NUMBER(20)	NOT NULL,
	`event_name`	VARCHAR2(100)	NULL,
	`event_detail`	VARCHAR2(2000)	NULL,
	`event_date`	DATE	NULL,
	`event_address`	VARCHAR2(100)	NULL,
	`event_periods`	VARCHAR2(200)	NULL
);

CREATE TABLE `course` (
	`course_idx`	NUMBER(20)	NOT NULL,
	`course_name`	VARCHAR2(100)	NULL,
	`course_detail`	VARCHAR2(2000)	NULL
);

CREATE TABLE `board_course` (
	`course_db_idx`	NUMBER(20)	NOT NULL,
	`course_list_idx`	NUMBER(20)	NOT NULL,
	`users_idx`	NUMBER(20)	NOT NULL,
	`course_name`	VARCHAR2(200)	NULL,
	`course_detail`	VARCHAR2(2000)	NULL,
	`course_date`	DATE	NULL,
	`course_count`	NUMBER(20)	NULL
);

CREATE TABLE `tag` (
	`tag_idx`	NUMBER(20)	NOT NULL,
	`tag_name`	VARCHAR2(50)	NULL
);

CREATE TABLE `tag_item` (
	`tag_item_idx`	NUMBER(20)	NOT NULL,
	`tag_idx`	NUMBER(20)	NOT NULL,
	`item_idx`	NUMBER(20)	NOT NULL
);

CREATE TABLE `tag_event` (
	`tag_event_idx`	NUMBER(20)	NOT NULL,
	`tag_idx`	NUMBER(20)	NOT NULL,
	`event_idx`	NUMBER(20)	NOT NULL
);

CREATE TABLE `tag_course` (
	`tag_course_idx`	NUMBER(20)	NOT NULL,
	`tag_idx`	NUMBER(20)	NOT NULL,
	`course_idx`	NUMBER(20)	NOT NULL
);

ALTER TABLE `board_item` ADD CONSTRAINT `PK_BOARD_ITEM` PRIMARY KEY (
	`item_idx`,
	`users_idx`
);

ALTER TABLE `users` ADD CONSTRAINT `PK_USERS` PRIMARY KEY (
	`users_idx`
);

ALTER TABLE `couse_list` ADD CONSTRAINT `PK_COUSE_LIST` PRIMARY KEY (
	`course_list_idx`,
	`course_idx`,
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

ALTER TABLE `CopyOfcourse_reply2` ADD CONSTRAINT `PK_COPYOFCOURSE_REPLY2` PRIMARY KEY (
	`event_reply_idx`,
	`users_idx`,
	`event_idx`
);

ALTER TABLE `board_event` ADD CONSTRAINT `PK_BOARD_EVENT` PRIMARY KEY (
	`event_idx`,
	`users_idx`,
	`item_idx`
);

ALTER TABLE `course` ADD CONSTRAINT `PK_COURSE` PRIMARY KEY (
	`course_idx`
);

ALTER TABLE `board_course` ADD CONSTRAINT `PK_BOARD_COURSE` PRIMARY KEY (
	`course_db_idx`,
	`course_list_idx`,
	`users_idx`
);

ALTER TABLE `tag` ADD CONSTRAINT `PK_TAG` PRIMARY KEY (
	`tag_idx`
);

ALTER TABLE `tag_item` ADD CONSTRAINT `PK_TAG_ITEM` PRIMARY KEY (
	`tag_item_idx`,
	`tag_idx`,
	`item_idx`
);

ALTER TABLE `tag_event` ADD CONSTRAINT `PK_TAG_EVENT` PRIMARY KEY (
	`tag_event_idx`,
	`tag_idx`,
	`event_idx`
);

ALTER TABLE `tag_course` ADD CONSTRAINT `PK_TAG_COURSE` PRIMARY KEY (
	`tag_course_idx`,
	`tag_idx`,
	`course_idx`
);

ALTER TABLE `board_item` ADD CONSTRAINT `FK_users_TO_board_item_1` FOREIGN KEY (
	`users_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `couse_list` ADD CONSTRAINT `FK_course_TO_couse_list_1` FOREIGN KEY (
	`course_idx`
)
REFERENCES `course` (
	`course_idx`
);

ALTER TABLE `couse_list` ADD CONSTRAINT `FK_board_item_TO_couse_list_1` FOREIGN KEY (
	`item_idx`
)
REFERENCES `board_item` (
	`item_idx`
);

ALTER TABLE `item_reply` ADD CONSTRAINT `FK_users_TO_item_reply_1` FOREIGN KEY (
	`users_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `item_reply` ADD CONSTRAINT `FK_board_item_TO_item_reply_1` FOREIGN KEY (
	`item_idx`
)
REFERENCES `board_item` (
	`item_idx`
);

ALTER TABLE `course_reply` ADD CONSTRAINT `FK_users_TO_course_reply_1` FOREIGN KEY (
	`users_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `course_reply` ADD CONSTRAINT `FK_board_course_TO_course_reply_1` FOREIGN KEY (
	`course_db_idx`
)
REFERENCES `board_course` (
	`course_db_idx`
);

ALTER TABLE `CopyOfcourse_reply2` ADD CONSTRAINT `FK_users_TO_CopyOfcourse_reply2_1` FOREIGN KEY (
	`users_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `CopyOfcourse_reply2` ADD CONSTRAINT `FK_board_event_TO_CopyOfcourse_reply2_1` FOREIGN KEY (
	`event_idx`
)
REFERENCES `board_event` (
	`event_idx`
);

ALTER TABLE `board_event` ADD CONSTRAINT `FK_users_TO_board_event_1` FOREIGN KEY (
	`users_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `board_event` ADD CONSTRAINT `FK_board_item_TO_board_event_1` FOREIGN KEY (
	`item_idx`
)
REFERENCES `board_item` (
	`item_idx`
);

ALTER TABLE `board_course` ADD CONSTRAINT `FK_couse_list_TO_board_course_1` FOREIGN KEY (
	`course_list_idx`
)
REFERENCES `couse_list` (
	`course_list_idx`
);

ALTER TABLE `board_course` ADD CONSTRAINT `FK_users_TO_board_course_1` FOREIGN KEY (
	`users_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `tag_item` ADD CONSTRAINT `FK_tag_TO_tag_item_1` FOREIGN KEY (
	`tag_idx`
)
REFERENCES `tag` (
	`tag_idx`
);

ALTER TABLE `tag_item` ADD CONSTRAINT `FK_board_item_TO_tag_item_1` FOREIGN KEY (
	`item_idx`
)
REFERENCES `board_item` (
	`item_idx`
);

ALTER TABLE `tag_event` ADD CONSTRAINT `FK_tag_TO_tag_event_1` FOREIGN KEY (
	`tag_idx`
)
REFERENCES `tag` (
	`tag_idx`
);

ALTER TABLE `tag_event` ADD CONSTRAINT `FK_board_event_TO_tag_event_1` FOREIGN KEY (
	`event_idx`
)
REFERENCES `board_event` (
	`event_idx`
);

ALTER TABLE `tag_course` ADD CONSTRAINT `FK_tag_TO_tag_course_1` FOREIGN KEY (
	`tag_idx`
)
REFERENCES `tag` (
	`tag_idx`
);

ALTER TABLE `tag_course` ADD CONSTRAINT `FK_course_TO_tag_course_1` FOREIGN KEY (
	`course_idx`
)
REFERENCES `course` (
	`course_idx`
);

