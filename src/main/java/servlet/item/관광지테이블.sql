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
item_periods varchar2(100),
item_time varchar2(100),
item_homepage varchar2(100),
item_parking varchar2(100),
item_count number default 0 not null
);

create sequence item_seq;

insert into item(item_idx, users_idx, item_type, item_name, item_address, item_detail, item_tags, item_periods, item_time, item_homepage, item_parking) 
values(item_seq.nextval, '21', '관광지', '경찰혼', '서울특별시 영등포구 국회대로 608', '우리 사회의 안정과 치안을 위해 순국ㆍ순직한 영등포경찰서 출신 경찰들의 숭고한 희생정신을 추모하고 그 분들의 고귀한 업적을 후세에 널리알리기 위하여 건립된 추모비이다.6ㆍ25전쟁 직후 전몰ㆍ순직한 경찰 62위 및 국내에서 발생한 각종 시위 진압과정에서 순직한 경찰 16위 등 총 78위의 경찰들을 기리고 있으며 서울영등포경찰서 내에 위치해 있다.', '#경찰', '기간없음', '운영시간없음', 'http://mfis.mpva.go.kr', '주차없음');

commit;
delete item;
drop table item;
drop sequence item_seq;