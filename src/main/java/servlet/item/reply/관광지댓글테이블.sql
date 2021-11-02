create table item_reply(
item_reply_idx number primary key,
item_idx REFERENCES item(item_idx),
users_idx references users(users_idx),
item_reply_detail VARCHAR2(2000) not null,
item_reply_time DATE default sysdate not null,
item_reply_target_idx references item_reply(item_reply_idx) default 0 not null
);
 
create sequence item_reply_seq;



