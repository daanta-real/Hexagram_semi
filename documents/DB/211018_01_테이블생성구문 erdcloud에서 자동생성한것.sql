CREATE TABLE `item` (
	`item_idx`	NUMBER(20)	NOT NULL,
	`user_idx`	NUMBER(20)	NOT NULL,
	`item_type`	CHAR(9)	NULL,
	`item_name`	VARCHAR2(100)	NULL,
	`item_detail`	VARCHAR2(2000)	NULL,
	`item_tags`	VARCHAR2(200)	NULL,
	`item_date`	DATE	NULL,
	`item_ables`	VARCHAR2(200)	NULL
);

CREATE TABLE `users` (
	`users_idx`	NUMBER(20)	NOT NULL,
	`users_id`	VARCHAR2(20)	NULL,
	`users_pw`	VARCHAR2(20)	NULL,
	`users_nick`	VARCHAR2(30)	NULL,
	`users_email`	VARCHAR2(30)	NULL,
	`users_grade`	VARCHAR2(6)	 NULL
);

CREATE TABLE `event` (
	`event_idx`	NUMBER(20)	NOT NULL,
	`user_idx`	NUMBER(20)	NOT NULL,
	`event_subject`	VARCHAR2(100)	NULL,
	`event_detail`	VARCHAR2(2000)	NULL,
	`event_ables`	VARCHAR2(200)	NULL
);

CREATE TABLE `course` (
	`course_id`	NUMBER(20)	NOT NULL,
	`user_idx`	NUMBER(20)	NOT NULL,
	`course_list`	VARCHAR2(2000)	NULL,
	`course_detail`	VARCHAR2(2000)	NULL,
	`course_locations`	VARCHAR2(2000)	NULL,
	`course_tags`	VARCHAR2(2000)	NULL
);

CREATE TABLE `reply_item` (
	`reply_id`	NUMBER(20)	NOT NULL,
	`item_idx`	NUMBER(20)	NOT NULL,
	`user_idx`	NUMBER(20)	NOT NULL,
	`reply_detail`	VARCHAR2(20)	NULL,
	`reply_target_id`	NUMBER(20)	NULL
);

CREATE TABLE `reply_course` (
	`reply_id`	NUMBER(20)	NOT NULL,
	`course_id`	NUMBER(20)	NOT NULL,
	`user_idx`	NUMBER(20)	NOT NULL,
	`reply_detail`	VARCHAR2(20)	NULL,
	`reply_target_id`	NUMBER(20)	NULL
);

ALTER TABLE `item` ADD CONSTRAINT `PK_ITEM` PRIMARY KEY (
	`item_idx`,
	`user_idx`
);

ALTER TABLE `users` ADD CONSTRAINT `PK_USERS` PRIMARY KEY (
	`users_idx`
);

ALTER TABLE `event` ADD CONSTRAINT `PK_EVENT` PRIMARY KEY (
	`event_idx`,
	`user_idx`
);

ALTER TABLE `course` ADD CONSTRAINT `PK_COURSE` PRIMARY KEY (
	`course_id`,
	`user_idx`
);

ALTER TABLE `reply_item` ADD CONSTRAINT `PK_REPLY_ITEM` PRIMARY KEY (
	`reply_id`,
	`item_idx`,
	`user_idx`
);

ALTER TABLE `reply_course` ADD CONSTRAINT `PK_REPLY_COURSE` PRIMARY KEY (
	`reply_id`,
	`course_id`,
	`user_idx`
);

ALTER TABLE `item` ADD CONSTRAINT `FK_users_TO_item_1` FOREIGN KEY (
	`user_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `event` ADD CONSTRAINT `FK_users_TO_event_1` FOREIGN KEY (
	`user_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `course` ADD CONSTRAINT `FK_users_TO_course_1` FOREIGN KEY (
	`user_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `reply_item` ADD CONSTRAINT `FK_item_TO_reply_item_1` FOREIGN KEY (
	`item_idx`
)
REFERENCES `item` (
	`item_idx`
);

ALTER TABLE `reply_item` ADD CONSTRAINT `FK_users_TO_reply_item_1` FOREIGN KEY (
	`user_idx`
)
REFERENCES `users` (
	`users_idx`
);

ALTER TABLE `reply_course` ADD CONSTRAINT `FK_course_TO_reply_course_1` FOREIGN KEY (
	`course_id`
)
REFERENCES `course` (
	`course_id`
);

ALTER TABLE `reply_course` ADD CONSTRAINT `FK_users_TO_reply_course_1` FOREIGN KEY (
	`user_idx`
)
REFERENCES `users` (
	`users_idx`
);

