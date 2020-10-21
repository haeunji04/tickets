--======================================================
-- Tickets
--======================================================
--관리자계정으로 tickets계정 생성

--create user tickets
--identified by tickets
--default tablespace users;
--
--grant connect, resource to tickets;
show user;

--view 생성 권한
--grant create view to final;


--==================================================
--계정 삭제 후 다시 만들 때 사용할 것
--drop user tickets cascade;

--=============== tickets계정으로 테이블 확인/삭제 ===============
--현재 계정 확인
--show user;

-- 계정 내 테이블/시퀀스/뷰 목록 확인
--select * from user_tables;
--select * from user_sequences;
--select * from user_views;

-- 테이블 삭제
--DROP TABLE "THEATER" CASCADE CONSTRAINTS;
--DROP TABLE "LOCATION" CASCADE CONSTRAINTS;
--DROP TABLE "CATEGORY" CASCADE CONSTRAINTS;
--DROP TABLE "MEMBER" CASCADE CONSTRAINTS;
--DROP TABLE "PERFORMANCE" CASCADE CONSTRAINTS;
--DROP TABLE "REVIEW" CASCADE CONSTRAINTS;
--DROP TABLE "WISHLIST" CASCADE CONSTRAINTS;
--DROP TABLE "SCHEDULE" CASCADE CONSTRAINTS;
--DROP TABLE "SEAT" CASCADE CONSTRAINTS;
--DROP TABLE "TICKET" CASCADE CONSTRAINTS;
--DROP TABLE "PAY" CASCADE CONSTRAINTS;
--DROP TABLE "COMMENT_BOARD" CASCADE CONSTRAINTS;
--DROP TABLE "RECENTLY_PER_LIST" CASCADE CONSTRAINTS;
--DROP TABLE "SELECTED" CASCADE CONSTRAINTS;

-- 시퀀스 삭제
--DROP SEQUENCE "PERFORMANCE_SEQ";

-- 뷰 삭제
--DROP VIEW "MEMBER_PAY_TICKET_VIEW";
--=============== tickets계정으로 테이블 생성 ===============

--Theater
create table theater(
    theater_no number,
    tot_theater_number number,
    theater_address varchar2(200),
    constraints pk_theater_no primary key(theater_no)
);

--drop table theater;

--Location
create table location(
    location_code varchar2(20),
    location_name varchar2(20),
    constraints pk_location_code primary key(location_code)
);

ALTER TABLE LOCATION MODIFY LOCATION_NAME VARCHAR2(50);
--Category
create table category(
    category_code varchar2(20) not null,
    category_name varchar2(30),
    category_level number default 1,
    category_ref number default 1,
    constraints pk_category_code primary key(category_code)
 ); 

--Member
create table member(
    member_id varchar2(15),
    password varchar2(300) not null,
    name varchar2(30) not null,
    email varchar2(100),
    phone char(11),
    addr varchar2(200) not null,
    addr_detail varchar2(200),
    post_code char(5) not null,
    member_role char(1)default 'U' not null,
    enroll_date date default sysdate,
    quit_yn char(1) default 'N' not null,
    constraints pk_member_id primary key(member_id),
    constraints ck_member_role check(member_role in ('U','A','C')),
    constraints ck_quit_yn check(quit_yn in ('N','Y'))
);

--2020.10.10 security 관련 start
select * from member;
alter table member add enabled number default 1;


--권한 테이블 생성
create table auth (
    member_id varchar2(20),
    authority varchar2(20),
    constraint pk_auth primary key(member_id, authority),
    constraint fk_auth_member_id foreign key(member_id) references member(member_id)
);

alter table auth drop constraints fk_auth_member_id cascade;
alter table auth add constraint fk_auth_member_id foreign key(member_id) references member(member_id) on delete cascade;

insert into 
    auth
values(
    'honggd',
    'ROLE_USER'
);
insert into 
    auth
values(
    'admin',
    'ROLE_USER'
);
insert into 
    auth
values(
    'admin',
    'ROLE_ADMIN'
);

insert into 
    auth
values(
    'company1',
    'ROLE_USER'
);
   
select 
    *
from
    auth;

commit;

select
    *
from 
    member M
  left join auth A
    on M.member_id = A.member_id
where 
    M.member_id = 'admin';

--2020.10.10 security 관련 end

SELECT * FROM PERFORMANCE where category_code='C4';
--SELECT * FROM performance_join_view where to_char(per_end_date, 'YYMMDD') = to_char(sysdate, 'YYMMDD');

--Performance
create table performance(
    per_no number,
    member_id varchar2(15),
    category_code varchar2(20),
    location_code varchar2(20),
    per_title varchar2(100) not null,
    per_director varchar2(20),
    per_actor varchar2(300),
    theater_no varchar2(200),
--    per_address varchar2(200),
    per_time number,
    per_content varchar2(2000),
    per_img_original_filename varchar(256),
    per_img_renamed_filename varchar(256),
    detail_img_original_filename varchar(256),
    detail_img_renamed_filename varchar(256),
    per_rating number,
    per_display char(1) default 'N',
    admin_approval char(1) default 'N',
    per_register_date date default sysdate,
    per_start_date date,
    per_end_date date,
    constraints pk_per_no primary key(per_no),
    constraints fk_member_id foreign key(member_id)
                            references member(member_id) on delete set null,
    constraints fk_category_code foreign key(category_code)
                            references category(category_code) on delete set null,
    constraints fk_location_code foreign key(location_code)
                            references location(location_code) on delete set null,
    constraints ck_per_rating check(per_rating in (0,8,15,18)),
    constraints ck_per_display check(per_display in ('N','Y')),
    constraints ck_admin_approval check(admin_approval in ('N','Y'))
    --    per_sale varchar2(20),
);

alter table performance add price number;
update performance set price = 15000 where category_code='C5';


alter table performance add sale_cnt int default 0;
--오픈 소식 추가 관련
--alter table performance add open_date date default null;
--alter table performance drop column open_date CASCADE CONSTRAINT;

alter table performance add alone_sale char(1) default 'N';
alter table performance add constraint ck_alone_sale check(alone_sale in ('N','Y'));

--Review
create table review(
    review_no number,
    revies_content varchar2(200) not null,
    review_date date default sysdate,
    per_no number not null,
    member_id varchar2(15) not null,
    constraints pk_review_no primary key(review_no),
    constraints fk_per_no1 foreign key (per_no) references performance(per_no) on delete cascade,
    constraints fk_member_id1 foreign key (member_id) references member(member_id) on delete cascade
);
--Wishlist
create table wishlist(
    member_id varchar2(15),
    per_no number,
    wish_date date default sysdate,
    constraints pk_wishlist primary key(member_id,per_no),
    constraints fk_member_id2 foreign key(member_id) references member(member_id),
    constraints fk_per_no2 foreign key(per_no) references performance(per_no)
);

alter table wishlist drop constraints fk_member_id2 cascade;
alter table wishlist add constraint fk_member_id2 foreign key(member_id) references member(member_id) on delete cascade;

--삭제관련 수정사항(도현 20.10.06) Start
-- 테이블 recently_per_list와 schedule에서 fk관련 alter 문만 돌려주기.

--DROP TABLE "RECENTLY_PER_LIST" CASCADE CONSTRAINTS;

--RecentlyPerList
create table recently_per_list(
    member_id varchar2(15),
    per_no number,
    recently_date date default sysdate,
    constraints pk_recently_per_list primary key(member_id,per_no),
    constraints fk_recently_member_id foreign key(member_id) references member(member_id),
    constraints fk_recently_per_no foreign key(per_no) references performance(per_no) 
);
select * from recently_per_list where member_id='honggd';
--delete recently_per_list where member_id='honggd';
--commit;

alter table recently_per_list drop constraints fk_recently_member_id cascade;
alter table recently_per_list add constraint fk_recently_member_id foreign key(member_id) references member(member_id) on delete cascade;
alter table recently_per_list drop constraints fk_recently_per_no cascade;
alter table recently_per_list add constraint fk_recently_per_no foreign key(per_no) references performance(per_no) on delete cascade;

--DROP TABLE "SCHEDULE" CASCADE CONSTRAINTS;
create table schedule(
    sch_no number,
    per_no number,
    sch_round number,
    sch_date_time date,
    constraints pk_sch_no primary key(sch_no),
    constraints fk_per_no4 foreign key(per_no) references performance(per_no)
);
ALTER TABLE SCHEDULE MODIFY SCH_DATE_TIME TIMESTAMP;

alter table schedule drop constraints fk_per_no4 cascade;
alter table schedule add constraint fk_per_no4 foreign key(per_no) references performance(per_no) on delete cascade;

select * from schedule;

--삭제관련 수정사항(도현 20.10.06) End

--schedule insert

--Seat
create table seat(
    seat_no number,
    seat_price number,
    seat_grade varchar2(10),
    floor number,
    x number,
    y number,
    theater_no number,
    constraints pk_seat_no primary key(seat_no),
    constraints fk_theater_no2 foreign key(theater_no) references theater(theater_no)
);

--Pay
create table pay(
    order_no varchar2(13) default 'M'||to_char(sysdate,'yyMMddHHssSS'),
    sch_no number,
    tot_price number,
    seat_count number,
    pay_option varchar2(20),
    pay_date date default sysdate,
    member_id varchar2(15),
    pay_yn char(1) default 'N',
    cancel_yn char(1) default 'N',
    constraints pk_order_no primary key(order_no),
    constraints fk_member_id4 foreign key(member_id) references member(member_id),
    constraints fk_sch_no4 foreign key(sch_no) references schedule(sch_no)
);

alter table pay modify(order_no varchar2(20));
alter table ticket modify(order_no varchar2(20));
--Ticket
create table ticket(
    tic_no number,
    tic_price number,
    sch_no number,
    seat_no number,
    member_id varchar2(15),
    order_no varchar2(13),
    constraints pk_tic_no primary key(tic_no),
    constraints fk_order_no foreign key(order_no) references pay(order_no),
    constraints fk_sch_no6 foreign key(sch_no) references schedule(sch_no),
    constraints fk_member_id6 foreign key(member_id) references member(member_id),
    constraints fk_seat_no2 foreign key(seat_no) references seat(seat_no)
);


--selected
create table selected(
    seat_no number,
    member_id varchar2(15),
    sch_no number,
    constraints pk_selected primary key(seat_no,member_id,sch_no),
    constraints fk_seat_no3 foreign key(seat_no) references seat(seat_no),
    constraints fk_member_id5 foreign key(member_id) references member(member_id),
    constraints fk_sch_no3 foreign key(sch_no) references schedule(sch_no)
    
);
--DROP TABLE "COMMENT_BOARD" CASCADE CONSTRAINTS;
CREATE TABLE comment_board (
	board_comment_no number null,
	board_comment_level	number DEFAULT 1,
    board_comment_writer varchar2(15),
	board_comment_content varchar(2000),
	per_no number,
    board_comment_ref number, 
	board_comment_date date DEFAULT sysdate,
    constraints pk_board_comment primary key(board_comment_no),
    constraints fk_board_comment_writer foreign key (board_comment_writer) 
                                                        references member(member_id)
                                                        on delete set null,
    constraints fk_per_no_ foreign key(per_no)
                                      references performance(per_no)
                                      on delete cascade            
--    constraints fk_board_comment_ref foreign key(board_comment_ref)
--                                                    references comment_board(board_comment_no)
--                                                    on delete cascade   
);

select * from comment_board;


--review_comment
create table review_comment (
    review_comment_no number not null,
    review_comment_content varchar2(2000) not null,
    review_comment_date date default sysdate,
    per_no number not null,
    member_id varchar2(15) not null,
    
    constraints pk_review_comment_no primary key(review_comment_no),
    constraints fk_review_per_no foreign key (per_no) references performance(per_no) on delete cascade,
    constraints fk_review_member_id foreign key (member_id) references member(member_id) on delete set null
);
--=============== tickets계정으로 시퀀스 생성 ===============
create sequence performance_seq
increment by 1
start with 1
minvalue 1
maxvalue 10000
cycle;

create sequence comment_board_seq
increment by 1
start with 1
minvalue 1
maxvalue 10000
cycle;

create sequence schedule_seq;
create sequence review_comments_seq;
--=============== tickets계정으로 뷰 생성 ===============
create view wishlist_view as
select W.member_id, per_no, W.wish_date,
       P.per_title, P.per_img_original_filename, P. per_img_renamed_filename,
       P.theater_no, P.per_start_date, P.per_end_date
from wishlist W
    join performance P using(per_no);
    
create view recently_per_list_view as
select W.member_id, per_no, W.recently_date,
       P.per_title, P.per_img_original_filename, P. per_img_renamed_filename,
       P.theater_no, P.per_start_date, P.per_end_date, P.per_rating, P.per_time
from recently_per_list W
    join performance P using(per_no);

--내가 기대평 단 공연목록
create view comment_per_list_view as
select P.member_id, per_no, 
       P.per_title, P.per_img_original_filename, P. per_img_renamed_filename,
       P.per_start_date, P.per_end_date, P.per_rating, P.per_time,
       C.board_comment_writer, C.board_comment_content, 
       C.board_comment_date
from performance P
    join comment_board C using(per_no);    

select * from comment_per_list_view where board_comment_writer = 'honggd';
--commit;
--댓글 단 공연
select * 
from performance
join comment_board C using(per_no)
where board_comment_writer = 'honggd';
    
select * from comment_board where board_comment_writer='honggd';    


--=============== tickets계정으로 기본 insert 생성===============
--location
insert into 
    location
values (
    'L1',
    '서울'
);
insert into 
    location
values (
    'L2',
    '경기/인천'
);
insert into 
    location
values (
    'L3',
    '대전/충청/강원'
);
insert into 
    location
values (
    'L4',
    '부산/대구/경상'
);
insert into 
    location
values (
    'L5',
    '광주/전라/제주'
);
        -- location테이블 데이터 변경
update location set location_name='대전/세종/충청/강원' where location_code='L3';
update location set location_name='부산/대구/경상/울산' where location_code='L4';


--category
insert into 
    category
values (
    'C1',
    '뮤지컬',
    default,
    default
);
insert into 
    category
values (
    'C2',
    '연극',
    default,
    default
);
insert into 
    category
values (
    'C3',
    '콘서트',
    default,
    default
);
insert into 
    category
values (
    'C4',
    '클래식',
    default,
    default
);
insert into 
    category
values (
    'C5',
    '전시',
    default,
    default
);

--member
insert into 
    member
values(
    'admin',
    '$2a$10$NtnZ2wyGQWt3akDFUfqTW.cUAsdZYDfshc1698R1zZlbTIZbMYMo2',
    '관리자',
    'admin@naver.com',
    '01075695421',
    '서울특별시 강남구 140-47 ',
    '10동 9909호',
    '12345',
    'A',
    default,
    default
);
--admin 참고구문
delete member where member_id = 'company12';
select * from member;
commit;
--update member set member_role = 'A' where member_id = 'admin'; 

insert into 
    member
values(
    'honggd5',
    '$2a$10$Te9bO/6BuGCO3xY/Avis.emYCtKbYgZK3cM991zvKr2vWxo51jkd.',
    '홍길동',
    'honggd@naver.com',
    '01075695421',
    '서울특별시 한양구 ',
    '경복동 112-7',
    '23456',
    'U',
    default,
    default,
    default
);

insert into 
    member
values(
    'company13',
    '$2a$10$3qCOl8BCyaloCmZQt4mGzuuf.XB2AtKov1slPxiZ0fPE7yoUhFKLa',
    '판매자12',
    'company1@naver.com',
    '01075695421',
    '서울특별시 종로구 ',
    '혜화동 115-2',
    '56789',
    'C',
    default,
    default,
    default
);
--========================테스트 란=======================

--공연에 공연장주소 불러오기 하다만
--select p.per_title, t.name, t.address
--from  performance p
--    join theater t
--        on p.theater_no = t.no;

--delete member where member_id ='popo';
--select * from member;
--commit;

--select * from performance order by per_register_date desc;
--update performance set per_display='Y' where per_no=22;

-- select
--			*
--		from
--			recently_per_list_view
--		where
--			member_id = 'honggd' and ROWNUM <= 3
--		order by
--			recently_date desc;

--==================0930은지추가================

--theater테이블 컬럼명 변경!!!!!!!!!
alter table theater rename column no to theater_no;
alter table theater rename column location to theater_location;
alter table theater rename column city to theater_city;
alter table theater rename column address to theater_address;
alter table theater rename column name to theater_name;

--중복 공연장 데이터 삭제
delete from theater where theater_no = 174;

--view생성
create view performance_join_view as
select 
    P.per_no,
    P.member_id,
    P.category_code,
    C.category_name,
    P.location_code,
    L.location_name,
    P.per_title,
    P.per_director,
    P.per_actor,
    P.theater_no,
    T.theater_location,
    T.theater_city,
    T.theater_address,
    T.theater_name,
    T.total_seat,
    P.per_time,
    P.per_content,
    P.per_img_original_filename,
    P.per_img_renamed_filename,
    P.detail_img_original_filename,
    P.detail_img_renamed_filename,
    P.per_rating,
    P.per_display,
    P.admin_approval,
    P.per_register_date,
    P.per_start_date,
    P.per_end_date,
    P.sale_cnt,
    P.alone_sale
from 
    performance P  
        left join theater T 
            on P.theater_no = t.theater_no
        left join location L
            on P.location_code = L.location_code
        left join category C
            on P.category_code = C.category_code;
--====================================
--결제내역 뷰 테이블
select * from pay;
select * from ticket;

create view member_pay_list_view as
select Y.order_no, Y.tot_price, Y.pay_option, Y.pay_date, Y.member_id,
       Y.pay_yn, Y.cancel_yn, Y.seat_count, Y.sch_no, 
       S.sch_date_time, S.per_no,
       P.per_title, P.per_img_original_filename, P.per_img_renamed_filename,
       P.theater_no, P.per_start_date, P.per_end_date, P.per_rating, P.per_time,
       T.theater_location, T.theater_city, T.theater_address, T.theater_name
from pay Y
    left join schedule S 
        on Y.sch_no = S.sch_no 
    left join performance P 
        on S.per_no = P.per_no
    left join theater T 
        on P.theater_no = T.theater_no;

select  * from member_pay_list_view; 

--DROP VIEW "MEMBER_PAY_TICKET_VIEW";
create view member_pay_ticket_view as
select K.tic_no, K.tic_price, K.seat_no, K.seat_name,
       Y.pay_option, Y.pay_date, Y.member_id,
       Y.pay_yn, Y.cancel_yn, Y.sch_no, Y.order_no,
       S.sch_date_time, S.per_no,
       P.per_title, P.per_img_original_filename, P.per_img_renamed_filename,
       P.theater_no, P.per_start_date, P.per_end_date, P.per_rating, P.per_time,
       T.theater_location, T.theater_city, T.theater_address, T.theater_name,
       M.name, M.email, M.phone       
from ticket K
    left join pay Y
        on K.order_no = Y.order_no
    left join schedule S 
        on Y.sch_no = S.sch_no 
    left join performance P 
        on S.per_no = P.per_no
    left join theater T 
        on P.theater_no = T.theater_no
    left join member M 
        on K.member_id = M.member_id;
        
select  * from member_pay_ticket_view; 

insert into review_comment values(
		    review_comments_seq.nextval,
		    '또 보고 싶어요!!',
		    default,
		    6,
		    'koko'
		);
--======================================================

select * from theater;
--select * from location;
--select * from category;
select * from member;
--select * from category;
select * from performance;
select * from comment_board;
select * from review_comment;
select * from wishlist;
select * from schedule;
select * from seat;
select * from selected;
select * from pay;
select * from ticket;
--

delete selected where seat_no='1';

insert into 
    selected
values(
3, 'qwer',29

);
commit;
--select * from ticket;
select * from pay;
--select * from wishlist_view;
select * from recently_per_list;
--select * from recently_per_list_view;
select * from selected;



commit;
--rollback;




--select * from dba_users where username ='final';











