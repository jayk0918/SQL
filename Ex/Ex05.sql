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