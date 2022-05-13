-- 그룹함수
-- count()
select  count(*)
        ,count(first_name)
        ,count(commission_pct) "count(commission_pct)"
        -- commision_pct의 null값은 제외해서 count
        ,count(manager_id)
from employees;

select  count(*)
from employees
where salary > 16000;

-- sum()
select  count(*)
        ,sum(salary)
from employees;

-- avg()
select  avg(salary) "without null"
        -- null일 경우 평균계산에서 제외
        ,avg(nvl(salary , 0)) "with null -> 0"
        -- salary에 null값이 존재하고, 이를 0으로 치환하여 평균계산
        ,round(avg(salary),0)
from employees;

-- max() / min()
select  max(salary)
        ,min(salary)
        ,count(*)
from employees;


-- group by 절 (group으로 묶어서 연산)
select first_name
from employees
where salary > 16000
order by salary desc;

-- group by를 사용할 때 : select와 group by에 참여한 컬럼만을 차용해야 논리적으로 맞음
select  department_id
        ,job_id
        ,avg(salary)
        ,sum(salary)
        ,count(salary)
from employees
group by department_id, job_id
order by department_id asc;

-- 예제)
-- 연봉(salary)의 합계가 20000이상인 부서의 부서번호와, 인원수, 급여합계를 출력하세요
-- where절에는 그룹함수를 사용할 수 없음 (having 절 사용 필수)

select  department_id "부서번호"
        ,count(salary) "인원수"
        ,sum(salary) "급여합계"
from employees
group by department_id
having sum(salary) >= 20000
and sum(salary) <= 100000
and department_id = 90
order by department_id asc;

/*
select  first_name
        ,department_id "부서번호"
        ,count(salary) "인원수"
        ,sum(salary) "급여합계"
from employees
where salary >= 20000
group by    first_name
            ,department_id
            ,salary
order by department_id asc;
*/

select  department_id "부서번호"
        ,count(salary) "인원수"
        ,sum(salary) "급여합계"
from employees
group by department_id
having sum(salary) >= 20000
and sum(salary) <= 100000
and department_id = 90
-- and hire_date = '04/01/01' -> not a group by expression
order by department_id asc;


