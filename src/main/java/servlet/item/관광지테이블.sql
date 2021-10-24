create table item(
item_idx number(20) primary key,
users_idx references users (users_idx),
item_type varchar2(9) default '관광지'
check(item_type in ('관광지','축제')),
item_name varchar2(100) not null unique,
item_address varchar2(150) not null,
item_detail varchar2(2000),
item_tags varchar2(1000),
item_date date default sysdate,
item_period varchar2(100),
item_time varchar2(100),
item_homepage varchar2(100),
item_parking varchar2(100),
item_count number default 0 not null
);

insert into item (item_idx,users_idx,item_type,item_name,item_address,item_detail,item_tags,item_date,item_period,item_time,item_homepage,item_parking,item_count) 
