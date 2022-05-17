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
where salary in(select salary
                from employees
                where department_id = 110);

--> where 구문에 질문에 대하여
--> 2개 이상의 답변이 들어올 경우 부등호로 판정이 불가능 (질문을 통해 값을 찾아야 함)
--> 해결법 : in 구문을 사용함 (다중행 subQuery 찍먹)


-- 다중행

-- 부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력 (again)

select  employee_id
        ,first_name
        ,salary
from employees
where salary in(select salary
                from employees
                where department_id = 110);

-- 부서번호가 10인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력

select  employee_id
        ,first_name
        ,salary
from employees
where salary = (select salary
                from employees
                where department_id = 10);
--> 이 상황에서는 department_id가 10인 사람이 1명이기 때문에 돌아가지만
--> 나중에 10이라는 id를 가지게 되는 사람이 늘어날 경우 폭★파 하는 코드
--> 하나일 수도 있지만 여러개일 가능성이 있다는 염려가 있다고 판단되면 다중행으로 처리할 것

-- 각 부서별로 최고급여를 받는 사원을 출력하시오 (그룹함수)

select  department_id
        ,first_name
        ,salary
from employees
where (department_id, salary) in   (select department_id, max (salary)
                                    from employees
                                    group by department_id);

-- any(= or)
-- 부서번호가 110인 직원의 급여 보다 큰 모든 직원의
-- 사번, 이름, 급여를 출력

select  employee_id
        ,first_name
        ,salary
        ,department_id
from employees
where salary >any  (select salary
                    from    employees
                    where   department_id = 110);

-- all (= and)

select  employee_id
        ,first_name
        ,salary
from employees
where salary >all  (select salary
                    from employees
                    where department_id = 110);

/*
-- 각 부서별로 최고급여를 받는 사원을 출력하시오 (그룹함수)

select  department_id
        ,max(salary)
from employees
group by department_id;

select  em.first_name
        ,dp.department_name
        ,em.department_id
        ,em.salary
from employees em, departments dp
where em.department_id = dp.department_id;


select  info.first_name
        ,info.department_name
from    (select  department_id
                ,max(salary)
        from employees
        group by department_id) sal,
        
        (select  em.first_name
                ,dp.department_name
                ,em.department_id
                ,em.salary
        from employees em, departments dp
        where em.department_id = dp.department_id) info
        
where info.department_id = sal.department_id;
*/


-- 조건절 비교 vs 테이블 join
-- 각 부서별로 최고급여를 받는 사원의 이름을 출력하시오 (같은 문제, 다른 방법)

-- 조건절
select max(salary)
from employees
group by department_id;


select  first_name
        ,salary
        ,department_id
from employees
where (department_id, salary) in   (select  department_id
                                            ,max(salary)
                                    from employees
                                    group by department_id);



--> 좀 전 문제에서 최고급여를 받는 사원 이름은 받았는데, 부서 '이름'은 나오지 않고 id로만 나와 있는 상태
--> upgrade해서 이름(employee) + max(salary)(employee) + 부서이름(department) 조합으로 출력해보기

select  info.first_name || ' ' || info.last_name "풀네임"
        ,info.salary                             "급여"
        ,dep.department_name                     "부서이름"
        
from    (select first_name
                ,last_name
                ,salary
                ,department_id
         from employees
         where (department_id, salary) in
         
        (select department_id
                ,max(salary)
          from employees
          group by department_id)) info
        
        ,
        
        (select department_id
                ,department_name
          from departments) dep

where info.department_id = dep.department_id
order by info.salary desc;

