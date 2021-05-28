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


- 과제: 
-- employees 테이블에서
-- 1. 사번이 179번인 사원의 레코드를 출력
select *
from employees
where employee_id = '179';
-- 2. 1에서 찾은 정보를 사용해서, 179번 사원의 직책 이름을 다른 테이블에서 검색, 출력
select job_title
from jobs
where job_id='SA_REP';
-- 3. 1에서 찾은 정보를 사용해서, 179번 사원이 일하는 부서의 정보를 다른 테이블에서 검색, 출력
select *
from departments
where department_id = '80';
-- 4. 1에서 찾은 정보를 사용해서, 179번 사원의 매니저 정보를 검색, 출력
select *
from employees
where employee_id='149';
--자동형변환 

-- departments 테이블에서
-- 5. manager_id가 존재하는 레코드들을 검색, 출력
select *
from departments where  manager_id is not null;
-- 6. 20번 부서의 레코드를 검색, 출력
select *
from departments
where department_id= '20';
-- 7. 6에서 찾은 정보를 사용해서, 20번 부서의 관리자 정보를 다른 테이블에서 검색, 출력
select *
from employees
where employee_id='201';

select * from emp order by sal; --오름차순 정렬이 기본이므로 asc는 생략 가능.

--emp 테이블을 sal의 내림차순(descending order)로 정렬해서 출력
select * from emp order by sal desc;

--emp 테이블을 deptno ~> sal의 오름차순 정렬 출력
select * from emp order by deptno,sal;
select * from emp order by deptno asc,sal desc;--각각 다르게 가능