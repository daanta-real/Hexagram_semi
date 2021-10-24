create table item (
item_idx number(20) primary key,
users_idx references users(users_idx) ,
item_type char(9),
item_name varchar2(100),
item_detail varchar2(2000),
item_tags varchar2(200),
item_date date,
item_ables varchar2(200)
);