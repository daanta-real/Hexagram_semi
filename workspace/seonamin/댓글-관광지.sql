
create table reply_item(
reply_id NUMBER(20) primary key,
item_idx NUMBER(20) references item(item_idx),
user_idx NUMBER(20) references user(user_idx),
reply_detail VARCHAR2(210) not null,
reply_target_id NUMBER(20)
);