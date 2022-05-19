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

-- 참고(에러메세지)
-- - 오류 보고 -
/* ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다
-- 02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
-- *Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";오류 보고 -
ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다
02449. 00000 -  "unique/primary keys in table referenced by foreign keys"
*Cause:    An attempt was made to drop a table with unique or
           primary keys referenced by foreign keys in another table.
*Action:   Before performing the above operations the table, drop the
           foreign key constraints in other tables. You can see what
           constraints are referencing a table by issuing the following
           command:
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "tabnam";*/




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

drop table book;
drop table author;

-- sequence (은행 번호표)

create table author(
    author_id number(10)
    ,author_name varchar2(100) not null
    ,author_desc varchar2(500)
    ,primary key (author_id)
);

-- 상황부여 : author db에 수많은 data가 존재한다고 할 때
-- 현재는 author_id에 1, 2 등 직접 순서를 부여했지만 자료량이 많아 직접부여가 어려울 때

create sequence seq_author_id
increment by 1
start with 1
nocache;
-- 오류(빨간줄)표시는 dog무시해도됨 (버그인듯)
-- nocache : 캐시메모리를 남기지 않음(속도 차원)
-- sequence가 계속 동작하다가 끝났을 때 다음에 생성 예정이었던 seqence를 향후 재소환하지 않고 다시 1부터 시작함 

insert into author
values(seq_author_id.nextval, '박경리', '토지 작가');

insert into author
values(seq_author_id.nextval, '이문열', '삼국지 작가');

insert into author
values(seq_author_id.nextval, '기안84', '웹툰 작가');

insert into author
values(seq_author_id.nextval, '자까', '웹툰 작가');

select *
from author;

-- sequence 조회
select *
from user_sequences;

-- sequence 최근 번호
select seq_author_id.currval
from dual;

-- 다음 sequence 조회
-- 주의 : nextval은 실행할 때 마다 시퀀스가 증가함
-- 이 때문에 sequence가 연속적으로 숫자가 나오지 않고 중간에 구멍이 생길 수 있음
-- 하지만 sequence와 그에 연동된 pk에서 중요한건 '겹치지 않는' 것임, 시퀀스가 비거나 이상해도 신경쓰지 말 것
select seq_author_id.nextval
from dual;

-- sequence 삭제
drop sequence seq_author_id;
-- 번호표 발급 기계를 없앤것일 뿐 author 테이블에 영향을 주지 않음
-- 이미 부여된 sequence 번호 또한 존재함


insert into author
values(seq_author_id.nextval, '자까', '대학일기');

select *
from author;

commit;
-- 테이블 수정사항 최종반영 commend

insert into author
values(seq_author_id.nextval, '주호민', '머머리여행');

rollback;
-- 다른 내용을 넣었다가 commit 시점으로 회귀하고자 할 때 
-- insert / update / delete / select 4가지 요소만 확정 및 롤백 가능 (테이블 자체 손상은 복구 불가능)
-- cf) transaction
-- commit & rollback의 본래 용도는 실수를 되돌리는 수단이 아님 / 다만 기능이 그렇기에 이용할 수 있음
-- commit : '작업'의 단위
-- ex) 은행 이체 시 (commit)(-1000원) -> (+1000원)의 사이클이 돌아야 하는데
-- (-1000원) -> (오류) 이게 된다면 / (-1000원) -> (+1000원)의 사이클은 작업의 단위임
-- 오류가 발생했으므로 rollback -> commit시점으로 회귀하여 다시 작업에 들어가야 함(bugfix required)


-- 일괄실행 시나리오
drop table author;
drop sequence seq_author_id;

-- create table
create table author(
    author_id number(10)
    ,author_name varchar2(100) not null
    ,author_desc varchar2(500)
    ,primary key (author_id)
);

-- sequence
create sequence seq_author_id
increment by 1
start with 1
nocache;

-- author data insert
insert into author
values(seq_author_id.nextval, '박경리', '토지작가');

insert into author
values(seq_author_id.nextval, '이문열', '삼국지작가');

insert into author
values(seq_author_id.nextval, '자까', '웹툰작가');

-- update
update author
set author_name = '정다정'
    ,author_desc = '역전 야매요리'
where author_id = 3;

-- print
select *
from author;





