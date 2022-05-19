drop table author;
drop table book;

drop sequence seq_author_id;
drop sequence seq_book_id;

-- create_author
create table author(
    author_id number(10)
    ,author_name varchar2(100) not null
    ,author_desc varchar2(500)
    ,primary key(author_id)
);

-- sequence_author
create sequence seq_author_id
increment by 1
start with 1;

-- insert_author
insert into author
values(seq_author_id.nextval, '김문열', '경북 영양');

insert into author
values(seq_author_id.nextval, '박경리', '경상남도 통영');

insert into author
values(seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author
values(seq_author_id.nextval, '기안84', '기안동에서 산 84년생');

insert into author
values(seq_author_id.nextval, '강풀', '온라인 만화가 1세대');

insert into author
values(seq_author_id.nextval, '김영하', '알쓸신잡');


-- create_book
create table book(
    book_id number(10)
    ,title varchar2(100) not null
    ,pubs varchar2(100)
    ,pub_date date
    ,author_id number(10)
    ,primary key(book_id)
    ,constraint book_fk foreign key(author_id)
    references author(author_id)
);

-- sequence_book
create sequence seq_book_id
increment by 1
start with 1;

-- insert_book
insert into book
values(seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);

insert into book
values(seq_book_id.nextval, '삼국지', '민음사', '2002-03-01', 1);

insert into book
values(seq_book_id.nextval, '토지', '마로니에북스', '2012-08-15', 2);

insert into book
values(seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);

insert into book
values(seq_book_id.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);

insert into book
values(seq_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5);

insert into book
values(seq_book_id.nextval, '오직두사람', '문학동네', '2017-05-04', 6);

insert into book
values(seq_book_id.nextval, '26년', '재미주의', '2012-02-04', 5);



-- edit
-- '김문열' -> '이문열'
update author
set author_name = '이문열'
where author_id = 1;

-- 강풀 author_desc 정보 -> '서울특별시'
update author
set author_desc = '서울특별시'
where author_id = 5;

-- additional experiment

delete from author
where author_id = 4;


-- 오류발생 : ora-02292 자식레코드 발견
-- author 테이블에 있는 기안84데이터는 book테이블에서 foreign key키로 활용되는 중 (종속성을 가지고 있음)


-- combain tables
select  b.book_id       "book_id"
        ,b.title        "title"
        ,b.pubs         "pubs"
        ,to_char(b.pub_date,'YYYY-MM-DD')     "pub_date"
        ,a.author_id    "author_id"
        ,a.author_name  "author_name"
        ,a.author_desc  "author_desc"
from author a, book b
where a.author_id = b.author_id;
