create table board_event(
event_idx number(20) primary key not null,
users_idx number(20) not null,
event_name varchar2(100) not null,
event_detail varchar2(2000) not null,
event_date date not null,
event_count_view number(20) default 0 not null,
event_count_reply number(20) default 0 not null
);

create sequence event_seq;

insert into event values(event_seq.nextval, 'users_seq.nextval', '노가리 투어 서포터즈', '관광코스 개발 및 월별 테마에 맞는 관광홍보미션 수행', 'to_date('2021-11-01', 'YYYY-MM-DD')', 0, 0);
insert into event values(event_seq.nextval, 'users_seq.nextval', '충북 청년 축제', '충북지역 청년들이 기획부터 운영까지 참여한 '2021 충북 청년축제', 'to_date('2021-09-17', 'YYYY-MM-DD')', 0, 0);
insert into event values(event_seq.nextval, 'users_seq.nextval', '강경 젓갈 축제', '강경젓갈시장에는 야간 경관을 조성해 강경을 찾는 관람객들에 아름다운 추억을 선사할 예정이다.', 'to_date('2021-10-13', 'YYYY-MM-DD')', 0, 0);
insert into event values(event_seq.nextval, 'users_seq.nextval', '괴산 고추 축제', '유기농의 메카, 괴산 방방곳곳 온-오프 투어', 'to_date('2021-08-26', 'YYYY-MM-DD')', 0, 0);
insert into event values(event_seq.nextval, 'users_seq.nextval', '영주 사과 축제', '가을이 익어가는 계절, ‘영주사과’를 온라인으로 만난다', 'to_date('2021-10-13', 'YYYY-MM-DD')', 0, 0);

commit;
