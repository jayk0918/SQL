-- 문제1.
-- 담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 이름, 매니저아이디, 커미션 비율, 월급을 출력하세요. (45건)

select  first_name
        ,manager_id
        ,commission_pct
        ,salary
from employees
where salary > 3000
and commission_pct is null
and manager_id is not null;

-- 문제2.
-- 각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여 (salary),
-- 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요
-- 조건절비교 방법으로 작성하세요
-- 급여의 내림차순으로 정렬하세요
-- 입사일은 2001-01-13 토요일 형식으로 출력합니다.
-- 전화번호는 515-123-4567 형식으로 출력합니다. (11건)

select  employee_id      "직원번호"
        ,first_name      "이름"
        ,salary          "급여"
        ,to_char(hire_date, 'YYYY-MM-DD DAY')   "입사일"
        ,replace(phone_number, '.', '-')        "전화번호"
        ,department_id  "부서번호"
from employees
where (department_id, salary) in (select department_id
                                         ,max(salary)
                                  from employees
                                  group by department_id)
order by salary desc;


-- 문제3
-- 매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
-- 통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자입니다.
-- 매니저별 평균급여가 5000이상만 출력합니다.
-- 매니저별 평균급여의 내림차순으로 출력합니다.
-- 매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-- 출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별 최대급여입니다. (9건)

select  info.manager_id     "매니저아이디"
        ,em.first_name      "매니저이름"
        ,info.avgsal        "매니저별 평균급여"
        ,info.minsal        "매니저별 최소급여"
        ,info.maxsal        "매니저별 최대급여"
from employees em, (select  cd.manager_id
                            ,round(avg(cd.salary), 0) avgsal
                            ,max(cd.salary) maxsal
                            ,min(cd.salary) minsal
                    from   (select  manager_id
                                    ,salary
                            from employees
                            where hire_date >= '05/01/01') cd
                    group by manager_id
                    having avg(salary) >= 5000
                    and manager_id is not null
                    order by avg(salary) desc) info

where em.employee_id = info.manager_id;




-- 문제4.
-- 각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명 (department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
-- 부서가 없는 직원(Kimberely)도 표시합니다. (106명)

select  info.employee_id        "사번"
        ,info.first_name        "이름"
        ,info.department_name   "부서명"
        ,emp.first_name         "매니저 이름"
from employees emp, (select  em.employee_id
                            ,em.first_name
                            ,dp.department_name
                            ,em.manager_id
                    from employees em, departments dp
                    where em.department_id = dp.department_id(+)) info
where emp.employee_id = info.manager_id;


-- 문제5.
-- 2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요

select  fin.employee_id      "사번"
        ,fin.first_name      "이름"
        ,fin.department_name "부서명"
        ,fin.salary          "급여"
        ,fin.hire_date       "입사일"

from (select rownum rn
            ,info.employee_id
            ,info.first_name
            ,dp.department_name
            ,info.salary
            ,info.hire_date

      from departments dp, (select employee_id
                                  ,first_name
                                  ,department_id
                                  ,salary
                                  ,hire_date
                            from employees
                            where hire_date >= '05/01/01'
                            order by hire_date asc) info
      where dp.department_id = info.department_id) fin

where rn >= 11
and rn <= 20;


-- 문제6.
-- 가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름 (department_name)은?

select  info.first_name || ' ' || info.last_name    "이름"
        ,info.salary                                "연봉"
        ,dp.department_name                         "부서 이름"

from departments dp, (select em.first_name
                            ,em.last_name
                            ,em.salary
                            ,em.department_id
                            ,maxhire.maxdate
                      from employees em, (select max(hire_date) maxdate
                                          from employees) maxhire
                      where em.hire_date = maxhire.maxdate) info

where dp.department_id = info.department_id;


-- 문제7.
-- 평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성(last_name)과
-- 업무(job_title), 연봉(salary)을 조회하시오.

select  fin.employee_id "직원번호"
        ,fin.first_name "이름"
        ,fin.last_name  "성"
        ,jb.job_title   "업무"
        ,fin.salary     "연봉"

from jobs jb, (select em.employee_id
                     ,em.first_name
                     ,em.last_name
                     ,em.salary
                     ,em.job_id

               from employees em, (select avginfo.department_id
                                   from (select  department_id
                                                ,avg(salary) avgsal
                                         from employees
                                         group by department_id) avginfo

                                         ,

                                  (select max(avgsal) maxsal
                                   from (select department_id
                                               ,avg(salary) avgsal
                                        from employees
                                        group by department_id)) maxinfo
                                        where avginfo.avgsal = maxinfo.maxsal) total

                where em.department_id = total.department_id) fin
                
where fin.job_id = jb.job_id;


-- 문제8.
-- 평균 급여(salary)가 가장 높은 부서는?

select dp.department_name

from departments dp, (select avginfo.department_id
                    from (select  department_id
                                ,avg(salary) avgsal
                          from employees
                          group by department_id) avginfo

                         ,

                   (select max(avgsal) maxsal
                    from (select department_id
                               ,avg(salary) avgsal
                        from employees
                        group by department_id)) maxinfo
                        where avginfo.avgsal = maxinfo.maxsal) total

where dp.department_id = total.department_id;


-- 문제9.
-- 평균 급여(salary)가 가장 높은 지역은?





-- 문제10.
-- 평균 급여(salary)가 가장 높은 업무는?









   