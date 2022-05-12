/* select문 기본 */

/* select 절
    from 절(table) */
    
-- 모든 컬럼 조회하기
select *
from employees; 

select *
from departments;

-- 특정 컬럼 조회하기
select  employee_id,
        first_name,
        last_name
from employees;

-- 예제)
-- 사원의 이름(first_name)과 전화번호 입사일 연봉을 출력하세요
select  first_name
        ,phone_number
        ,hire_date
        ,salary
from employees;

-- 사원의 이름(first_name)과 성(last_name) 급여, 전화번호, 이메일, 입사일을 출력하세요
select  first_name
        ,last_name
        ,salary
        ,phone_number
        ,email
        ,hire_date
from employees;
-- (,)를 앞에 붙여 오류 방지

-- 별명 부여하기
-- 사원의 이름(first_name)과 전화번호 입사일 급여 로 표시되도록 출력하세요
select  first_name "이름"
        ,phone_number "전화번호"
        ,hire_date "입사일"
        ,salary "급여"
from employees;

-- 사원의 사원번호 이름(first_name) 성(last_name)급여 전화번호 이메일 입사일로 표시되도록 출력하세요
-- as는 생략 가능 (쓰는게 정석이지만 많이 스킵하는 편)
-- 별명을 ""로 감쌀 경우 정확하게 그 문자&공백을 표기함
-- 영어 별명의 경우 ""로 감싸지 않으면 무조건 대문자로 표기함
select  first_name as 이름
        ,last_name as 성
        ,salary as "Salary"
        ,phone_number hp
        ,email "이  메  일"
        ,hire_date 입사일
from employees;

-- 연결연산자(컬럼 붙이기)
select  first_name
        ,last_name
from employees;

-- || 사용
select  first_name || last_name
from employees;

-- || 사이에는 ''(작은따옴표) 사용, ""(큰 따옴표) 사용시 error
select  first_name || ' ' || last_name
from employees;

select first_name || ' hire date is ' ||hire_date 입사일자
from employees;

-- 산술 연산자 활용 (+ - / *)
select  first_name
        ,salary
        ,salary * 12
        ,(salary+300) * 12
from employees;

select job_id * 12
from employees;
-- invalid number error
-- 유효 숫자가 책정되지 않음(job_id)

-- 예제)
-- 전체직원의 정보를 다음과 같이 출력하세요

/* 성명(first_name last_name)
급여
연봉(급여 *12)
연봉2(급여*12+5000)
전화번호
*/

select  first_name || '-' ||last_name 성명
        ,salary 급여
        ,salary * 12 연봉
        ,(salary * 12) + 5000 연봉2
        ,phone_number 전화번호
from employees;

-- where 절
-- =, !=, >, <, >=, <= 사용

select first_name
from employees
where department_id = 10;

-- 연봉이 15000 이상인 사원들의 이름과 월급을 출력하세요
select  first_name
        ,salary / 12
from employees
where salary >= 15000;

-- 07/01/01 일이후에 입사한 사원들의 이름과 입사일을 출력하세요
select  first_name || '-' || last_name name
        ,hire_date
from employees
where hire_date > '07/01/01';

-- 이름이 Lex인 직원의 연봉을 출력하세요
select salary
-- 끝내기 전에 이름이 Lex가 맞는지 first_name도 출력해 볼 것
from employees
where first_name = 'Lex';

-- 조건이 2개 이상일 경우
-- 예제) 연봉이 14000이상 17000이하인 사원의 이름과 연봉을 구하시오 (and 활용)

select  first_name
        ,salary
from employees
where salary >= 14000
and salary <= 17000;

-- 연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요 (or 활용)
select  first_name
        ,salary
from employees
where salary <= 14000
or salary >= 17000;
-- null;

-- 입사일이 04/01/01에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select  first_name
        ,hire_date
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';

-- between 연산자 활용(특정구간 값 출력, 이상&이하 개념)
-- 처리 속도가 느린 편 / 처리할 데이터의 양이 많아질 경우 이슈가 될 수 있음
select  first_name
        ,salary
from employees
where salary between 14000 and 17000;

-- in 연산자 활용 (여러 조건 검사)
select first_name, last_name, salary
from employees
where first_name in ('Neena', 'Lex', 'John');

/*
where first_name = 'Neena'
or first_name = 'Lex'
or first_nam = 'John';  
*/

-- 예제)
-- 연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오

select  first_name
        ,salary
from employees
where salary in (2100, 3100, 4100, 5100);

select  first_name
        ,salary
from employees
where salary = 2100
or salary = 3100
or salary = 4100
or salary = 5100;

-- like 연산자
select  first_name
        ,last_name
        ,salary
from employees
where first_name like 'L%';
-- 해석 : like(~와 같은) + first_name에 'L'이라는 글자가 포함된 모든 결과값 출력
-- 'L'뒤에 %는 무엇이 오든 상관이 없다는 의미 (공백도 가능)

select  first_name
        ,last_name
        ,salary
from employees
where first_name like 'L___';
-- 'L'뒤에 _(underbar)는 L뒤에 오는 글자개수를 특정짓는 기호 (위에는 3개가 설정됨)

select  first_name
        ,last_name
        ,salary
from employees
where first_name like '%s%';
-- first_name에 s가 존재하면 모두 출력

-- [예제]
-- 이름에 am 을포함한 사원의 이름과 연봉을 출력하세요

select  first_name
        ,salary
from employees
where first_name like '%am%';

-- 이름의 두번째 글자가 a인 사원의 이름과 연봉을 출력하세요

select  first_name
        ,salary
from employees
where first_name like '_a%';

-- 이름의 네번째 글자가 a인 사원의 이름을 출력하세요

select first_name
from employees
where first_name like '___a%';

-- 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요

select first_name
from employees
where first_name like '__a_';

-- null(값이 부재) vs 0 (값이 존재)
select  first_name
        ,salary
        ,commission_pct
        ,salary * commission_pct
from employees
where salary between 13000 and 15000;

-- is null / is not null
select  first_name
        ,salary
        ,commission_pct
        ,salary * commission_pct
from employees
where commission_pct is null;
-- where commission_pct = null; 이라고 할 경우 ㄹㅇ로 null이라는 값을 찾음

select  first_name
        ,salary
        ,commission_pct
        ,salary * commission_pct
from employees
where commission_pct is not null;


-- [예제]
-- 커미션 비율이 있는 사원의 이름과 연봉 커미션 비율을 출력하세요

select  first_name
        ,commission_pct
from employees
where commission_pct is not null;

-- 담당매니저가 없고 커미션 비율이 없는 직원의 이름을 출력하세요

select first_name
from employees
where manager_id is null
and commission_pct is null;

-- order by (정렬) - 연산/출력 에너지 소모 큼
/*  select
    from
    where(optional)
    order
*/
select  first_name
        ,salary
from employees
order by salary desc;
-- desc : 내림차순

select  first_name
        ,salary
from employees
order by salary asc;
-- asc : 오름차순 (생략은 가능하나 작성하는것을 권고)

select  first_name
        ,salary
from employees
where salary >= 9000
order by salary desc;

-- [예제]
-- 부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요

select  department_id
        ,salary
        ,first_name
from employees
order by department_id asc;

-- 급여가 10000이상인 직원의 이름 급여를 급여가 큰 직원부터 출력하세요

select  first_name
        ,salary
from employees
where salary >= 10000
order by salary desc;

-- 부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요

select  department_id
        ,salary
        ,first_name
from employees
order by department_id asc, salary desc;
-- 복수의 정렬조건에는 ,(comma)로 구분하여 나열



-- 단일행 함수
-- 1) 문자함수
-- INITCAP(컬럼명) - 첫 문자 대문자 출력
select  email
        ,initcap(email) "email2"
        ,department_id
from employees
where department_id= 100;


-- LOWER / UPPER (컬럼명) - 입력값 일괄변경_ 소문자 / 대문자
select  first_name
        ,lower(first_name)
        ,upper(first_name)
from employees
where department_id= 100;

-- SUBSTR(컬럼명, 시작위치_포함, 글자개수) - 문자열에서 특정길이 문자열 추출
select  first_name
        ,substr(first_name,1,3)
        ,substr(first_name,-3,2)
from employees
where department_id= 100;


-- L(left)/R(right)PAD (컬럼명, 자리수, '채우고자 하는 문자')
-- 자리수에서 설정한 값만큼 data가 설정됨
-- ex) first_name에서 이름의 자리수가 5개이면 채우려는 문자는 5개만큼 채워지고,
-- 자리수가 4개일 경우 6개가 채워지는 원리
select  first_name
        ,lpad(first_name,10,'*')
        ,rpad(first_name,10,'*')
from employees;

-- REPLACE (컬럼명, 찾을 문자, 바꿀 문자) - 치환
select  first_name
        ,replace(first_name, 'a', '*')
from employees
where department_id=100;

select  first_name
        ,replace(first_name, substr(first_name,2,3), '***' )
from employees
where department_id=100;


-- dual (가상의 테이블) 테스트용으로 활용됨
select substr('921024-1234565', 8, 1)
from dual;

-- 2) 숫자함수
-- ROUND(숫자, 출력을 원하는 자릿수) - 반올림
select  round(123.346, 2) r2
        ,round(123.456, 0) r0
        ,round(123.456, -1) "r-1"
from dual;

-- TRUNC(숫자, 출력을 원하는 자릿수) - 버림
select  trunc(123.346, 2) r2
        ,trunc(123.456, 0) r0
        ,trunc(123.456, -1) "r-1"
from dual;


-- 3) 날짜함수
-- SYSDATE() -> 현재 날짜&시간 출력
select sysdate
from dual;

select months_between('22/05/12', '22/01/01')
from dual;

select months_between(sysdate, hire_date)
from employees
where department_id= 110;

select  first_name name
        ,round(months_between(sysdate, hire_date), 0) "days"
from employees
where department_id= 110;


-- 변환함수
-- TO_CHAR(숫자, '출력모양') 숫자 -> 문자형 전환
select  first_name
        ,to_char(salary*12, '99999') "SAL"
        -- 9(기호, 의미 X) : 자리수 표시 (99999 : 5자리만큼 표시)
from employees
where department_id=110;


select  first_name
        ,to_char(salary*12, '099999') "SAL"
        -- 0 : 빈자리 채우기용 (기호, 의미 X)
from employees
where department_id=110;

select  to_char(9876, '99999')
        ,to_char(9876, '099999')
        ,to_char(9876, '$99999')
        ,to_char(9876, '9999.99') "소수점"
        -- 소수점 자리를 메길 때 정수부분의 자리수가 맞아야 함
        ,to_char(9876, '99,999') "1000 구분기호"
        -- ,(천 단위) 구분기호
from dual;


-- 날짜 변환
select  sysdate,
        to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS DAY DDTH') "24시간"
from dual;

select  sysdate,
        to_char(sysdate, 'YY-MM-DD HH:MI:SS') "12시간"
        -- MM : 하루를 12시간단위로 표기
from dual;

select  sysdate,
        to_char(sysdate, 'YYYY"년" MM"월" DD"일" HH24:MI:SS DAY DDTH') "24시간"
from dual;
-- "년","월","일"과 같이 기본 기호(/,-과 같은)를 제외하고는 ""로 묶어서 작성해야 인식













