
create table reply_item(
reply_idx NUMBER(20) primary key,
item_idx NUMBER(20) references item(item_idx),
users_idx NUMBER(20) references users(users_idx),
reply_detail VARCHAR2(210) not null,
reply_target_id NUMBER(20)
);