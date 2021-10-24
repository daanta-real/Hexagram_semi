create table item_reply(
item_reply_idx number primary key,
item_idx REFERENCES item(item_idx),
users_idx references users(users_idx),
item_reply_detail VARCHAR2(2000) not null,
item_reply_time DATE default sysdate,
item_reply_target_idx NUMBER default 0
);

create sequence item_reply_seq;
