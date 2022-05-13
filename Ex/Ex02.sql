-- nvl(컬럼명, null일때 치환할 값)
-- nvl2(컬럼명, null이 아닐때 치환할 값, null일때 치환할 값)

select  first_name
        ,commission_pct
        ,nvl(commission_pct, 0)
        ,nvl2(commission_pct, 100, 0)
        ,commission_pct
from employees;


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

-- case ~ end 문
select  employee_id
        ,first_name
        ,job_id
        ,salary
        ,case   when job_id = 'AC_ACCOUNT' then salary + salary * 0.1
                when job_id = 'SA_REP'  then salary + salary * 0.2
                when job_id= 'ST_CLERK' then salary + salary * 0.3
                else salary
        end realSalary
from employees;
        
-- decode() 문
-- 유사 swtich case
-- 모든 항목이 job_id의 조건이기 때문에 job_id를 생략하고 작성 가능
select  employee_id
        ,first_name
        ,job_id
        ,salary
        ,decode(job_id, 'AC_ACCOUNT', salary + salary * 0.1,
                        'SA_REP', salary + salary * 0.2,
                        'ST_CLERK', salary + salary * 0.3,
                salary) "realSalary"
from employees
where job_id = 'SA_REP';

-- [예제]
-- 직원의 이름, 부서, 팀을 출력하세요
-- 팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’
-- 60~100 이면 ‘B-TEAM’
-- 110~150 이면 ‘C-TEAM’
-- 나머지는 ‘팀없음’ 으로 출력하세요.

select  first_name "이름"
        ,department_id "부서"
        ,case   when department_id >= 10 and department_id <= 50 then 'A-TEAM'
                when department_id >= 60 and department_id <= 100 then 'B-TEAM'
                when department_id >= 110 and department_id <= 150 then 'C-TEAM'
                else '팀없음'
        end "팀"
from employees
order by department_id asc;






