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
from employees
where first_name = 'Lex';




