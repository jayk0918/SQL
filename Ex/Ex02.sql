-- hr
-- join
-- EQUI join

select  first_name
        ,em.department_id
        ,department_name
        ,de.department_id
from employees em, departments de
-- em, de와 같이 별명 설정 가능(약자) -> 컬럼 이름의 모호성 해소
where em.department_id = de.department_id;
-- where 절에 join의 조건을 부여해야 함

-- 예제)
-- 모든 직원이름, 부서이름, 업무명을 출력하시오

select  em.first_name
        ,dp.department_name
        ,jb.job_title
from employees em, departments dp, jobs jb
where em.job_id = jb.job_id
and em.department_id = dp.department_id
and em.salary > 7000;