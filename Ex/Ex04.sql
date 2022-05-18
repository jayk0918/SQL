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