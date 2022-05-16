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


-- <null>을 다룰 때
-- left join
select *
from employees em left outer join departments dp
on em.department_id = dp.department_id
;

-- left join(오라클 전용 문법 (+))
select  em.first_name
        ,em.department_id
        ,dp.department_name
        ,dp.department_id
from employees em, departments dp
where em.department_id = dp.department_id(+);


-- right join
select *
from employees em right outer join departments dp
on em.department_id = dp.department_id;


-- right join(오라클 전용 문법 (+))
select  em.first_name
        ,em.department_id
        ,dp.department_name
        ,dp.department_id
from employees em, departments dp
where em.department_id(+) = dp.department_id;

-- right join -> left join으로 전환 (from 구절의 순서 변환)
select *
from departments dp left outer join employees em
on em.department_id = dp.department_id
;

-- full outer join (모두를 기준으로 잡을 때_합집합)
select  em.first_name
        ,em.department_id
        ,dp.department_name
        ,dp.department_id
from employees em full outer join departments dp
on em.department_id = dp.department_id;
-- on em.department_id(+) = dp.department_id(+)는 사용할 수 없는 문법

-- self join (본인 테이블 복제 -> 별칭지정 필수)
select  employee_id
        ,first_name
        ,salary
        ,manager_id
from employees;

select  emp.employee_id
        ,emp.first_name
        ,emp.salary
        ,emp.phone_number
        ,man.manager_id
        ,man.first_name
        ,man.phone_number
from employees emp, employees man
where emp.manager_id = man.employee_id(+);

