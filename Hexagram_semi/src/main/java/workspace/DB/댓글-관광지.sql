
create table reply_item(
item_reply_idx NUMBER(20) primary key,
item_idx NUMBER(20) references item(item_idx),
users_idx NUMBER(20) references users(users_idx),
item_reply_target_idx NUMBER(20),
item_reply_detail VARCHAR2(210) not null
);