-- subQuery (SQL질의문 속 SQL질의문)
-- den보다 급여가 많은 사람의 이름 & 급여 산출하기

select  first_name
        ,salary
from employees
where first_name = 'Den'; -- 11000

select  first_name
        ,salary
from employees
where salary > 11000;

-- 위 2개의 Query문을 1개로 병합 (subQuery 작성)

select  first_name
        ,salary
from employees
where salary > (select salary
                from employees
                where first_name = 'Den');

-- 급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?

select  first_name      "이름"
        ,salary         "급여"
        ,employee_id    "사원번호"
from employees
where salary = (select min(salary)
                from employees);

-- 평균 급여보다 적게 받는 사람의 이름, 급여를 출력

select  first_name  "이름"
        ,salary     "급여"
from employees
where salary < (select avg(salary)
                from employees);

-- subQuery를 적용하여 주말 이틀을 날렸던 practice02 - Q06을 푼다면
select to_char (start_date, 'YYYY-MM-DD DAY') "입사일"
from job_history
where (end_date - start_date) = (select max(end_date - start_date)
                                from job_history);
                                

-- 부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력
select  employee_id
        ,first_name
        ,salary
from employees
where department_id = 110;


-- + --

select  employee_id
        ,first_name
        ,salary
from employees
where salary = 12008
or salary = 8300;

-----------------------------
select  employee_id
        ,first_name
        ,salary
from employees
where salary in (select salary
                from employees
                where department_id = 110);

--> where 구문에 질문에 대하여
--> 2개 이상의 답변이 들어올 경우 부등호로 판정이 불가능 (질문을 통해 값을 찾아야 함)
--> 해결법 : in 구문을 사용함 (다중행 subQuery 찍먹)






