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


-- rownum

-- 급여를 가장 많이 받는 5명의 직원 이름 출력하기
-- 급여 순 정렬

select  rownum
        ,ot.employee_id
        ,ot.first_name
        ,ot.salary
from (select  employee_id
        ,first_name
        ,salary
        from employees
      order by salary desc) ot
where rownum >=1 
and rownum <=5
order by salary desc;


-- rownum 숫자(순서)부여기준 : row를 읽었을 때

-- 1등이 아닌, 중간 등수에서부터 구할 경우
-- 위 코드가 먹히지 않는 이유 -> rownum을 검사하는 과정에서 1이라는 숫자가 순서상 먼저 부여된다
-- 이 때, 중간등수는 1등이 아니므로 1이 false로 처리되는데
-- 문제는 rownum이 false처리된 첫 자료를 버리고 두번째 자료를 다시 처음 검증하는 순서로 인식하여 1이 다시 부여됨
-- 결론 : rownum이 1로 무한부여되다가 자료 검증이 끝날 때 까지 모조리 false처리됨 => 자료가 나올 수가 없음

select  rn -- rn으로 별명을 부여하지 않고 / rownum을 생으로 쓸 경우 / rownum 고유 기능을 작동하여 또 다시 rownum이 부여됨
        ,first_name
        ,salary
from    (select  rownum rn
                ,employee_id
                ,first_name
                ,salary
         from  (select employee_id
                     ,first_name
                     ,salary
                from employees
                order by salary desc))
where rn>=3
and rn<=5;


-- 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은?

select  rn
        ,first_name
        ,hire_date
        ,salary
from (select  rownum rn
             ,first_name
             ,hire_date
             ,salary

      from (select  first_name
                    ,hire_date
                    ,salary
            from employees
            where hire_date >= '07/01/01'
            and hire_date <= '07/12/31'
            order by salary desc))
where rn >=3
and rn <= 7;