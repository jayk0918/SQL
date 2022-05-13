-- 문제1.
-- 매니저가 있는 직원은 몇 명입니까? 아래의 결과가 나오도록 쿼리문을 작성하세요

select count(manager_id) "haveMngCnt"
from employees;

-- 문제2.
-- 직원중에 최고임금(salary)과 최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력 해 보세요.
-- 두 임금의 차이는 얼마인가요? “최고임금 – 최저임금”이란 타이틀로 함께 출력 해 보세요.

select  max(salary) "최고임금"
        ,min(salary) "최저임금"
        ,max(salary) - min(salary) "최고임금 - 최저임금"
from employees;

-- 문제3.
-- 마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요. 예) 2014년 07월 10일

select to_char(max(hire_date), 'YYYY"년" MM"월" DD"일"')
from employees;

-- 문제4.
-- 부서별로 평균임금, 최고임금, 최저임금을 부서아이디(department_id)와 함께 출력합니다.
-- 정렬순서는 부서번호(department_id) 내림차순입니다.

select *
from employees em, departments dp
group by department_id
;

select salary
from departments;









