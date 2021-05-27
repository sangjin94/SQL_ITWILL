--employees 테이블의 구조확인
DESC employees;
--employees 테이블에서 이름이 J로 시작하는 사원들의 사번, 이름을 검색
SELECT    employee_id,
    emp_name
FROM    employees
WHERE    emp_name LIKE 'J%';
--employees 테이블에서 이름에 E 또는 e가 포함된 사원들의 사번과 이름을 검색
SELECT    employee_id,
    emp_name
FROM    employees
WHERE    ( emp_name LIKE '%E%'
      OR emp_name LIKE '%e%' );

--employees 테이블에서 전화번호가 011로 시작하는 사원들의 사번, 이름 전화번호를 검색
SELECT    employee_id,
    emp_name,
    phone_number
FROM    employees
WHERE    phone_number LIKE '011%';


--employees 테이블에서 급여가 3000이상 5000이하인 사원들의 사번, 이름, 급여를 검색
select employee_id, emp_name, salary
from employees
where salary >= 3000 and salary <= 5000;

select employee_id, emp_name, salary
from employees
where salary between 3000 and 5000;

--employees 테이블에서 수당이 있는 사원들의 사번, 이름, 급여, 1년연봉을 검색
--commision_pct는 수당의 퍼센티지를 의미.(수당미포함) 1년 연봉의 몇%인지를 의미.
--수당포함 연봉= 월급*12+수당=월급*12+(월급*12)*pct
select employee_id, emp_name, salary, salary*12*(1+commission_pct) as annualsal
from employees
where commission_pct is not null;