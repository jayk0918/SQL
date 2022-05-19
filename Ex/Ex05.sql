-- 테이블 생성
create table book(
    book_id number(5)
    ,title varchar2(50)
    ,author varchar2(10)
    ,pub_date date
);

-- 컬럼 추가
alter table book add (pubs varchar2(50));

-- 컬럼 수정
alter table book modify(title varchar2(100)); -- title의 50자 -> 100자로 수정
alter table book rename column title to "subject"; -- 컬럼명 title -> subject로 수정 / 소문자를 원할때는 "" 안에 작성

-- 컬럼 삭제
alter table book drop (author);

-- 테이블 명 수정
rename book to article;

-- 테이블 삭제
drop table article;


-- 테이블관리 / 제약조건
-- not null : null 입력 불가(입력 시 오류발생)
-- unique : 입력 자체는 선택사항, but 입력 시 중복값 금지
-- primary key : not null + unique, 테이블당 딱 1개만 설정 가능 (주민등록번호), 그룹설정 가능

create table author(
    author_id number(10)
    ,author_name varchar2(100) not null
    ,author_desc varchar2(500)
    ,primary key(author_id)
);

-- DML(Data Manipulation Language)
-- insert

-- 묵시적 방법 (컬럼 이름 / 순서 지정 X) -> 테이블 생성 시 정의한 순서로 채워짐
insert into author
values (1, '박경리', '토지작가');

-- 명시적 방법 
insert into author(author_id, author_name)
values (2, '이문열');

insert into author(author_name, author_id)
values ('자까', 3);
-- 순서에 맞게 세팅만 해주면 문제 없음 
-- 3번째 값 'author_desc -> 설명란은 별도의 제약조건이 없어 null이라도 오류 아님

select *
from author;


-- foreign key : reference(참조자료) 테이블에 primary key와 연동
-- 보통 foreign key(fk)와 primary key(pk)는 (반드시 같아야 하는건 아니지만) 같게 세팅
-- 지워질 상황에 대하여 옵션을 사전에 설정할 수 있음
-- 옵션을 설정하지 않을 경우의 기본 옵션 : 에러메세지 & 삭제 X
-- on delecte cascade : 해당 fk를 가진 참조행도 삭제
-- on delete set null : 해당 fk를 null로 바꿈

create table book(
    book_id number(10)
    ,title varchar2(100) not null
    ,pubs varchar2(100)
    ,pub_date date
    ,author_id number(10)
    ,primary key(book_id)
    ,constraint book_fk foreign key(author_id) 
    references author(author_id)
    -- book_fk(fk의 booktable 내부 이름 세팅)
    -- foreign key(author_id) 외부로 나가는 fk의 이름
    -- reference (테이블명)(컬럼명) -> 연동하고자 하는 테이블의 pk
);


insert into book(book_id, title, pubs, pub_date, author_id)
values (1, '토지', '마로니에북스', '2012-08-15', 1);

insert into book
values (2, '삼국지', '민음사', '2002/03/01', 2);

select  b.title
        ,b.pubs
        ,b.pub_date
        ,a.author_name
from book b, author a
where b.author_id = a.author_id;


-- update (데이터 수정) -> 이미 등록된 데이터를 수정하는 것으로, insert와 구분할 것
update author
set author_desc = '삼국지 작가'
where author_id = 2;
-- 주의 : where절에서 특정해주지 않고 실행시킬 경우 모든 데이터가 입력한 내용으로 수정됨

-- delete (데이터 삭제)
delete from author
where author_id = 1;
-- 주의 : update와 마찬가지로 where절을 특정하지 않으면 모든 데이터가 폭★발

select *
from book;

delete from book;

