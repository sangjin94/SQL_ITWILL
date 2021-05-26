--테이블에서 조건을 만족하는 레코드(행) 검색
--select 컬럼,... from 테이블 where 조건;

--사원 테이블에서 10번 부서에서 일하는 사원들의 레코드를 검색
select * from emp where deptno=10;

--사원테이블에서 급여가 3000이상인 사원들의 레코드를 검색
select * from emp where sal>=3000;

-- 비교 연산: =(equal to), !=(not equal to),>(greater than),<(less than)
-- >=(greater than or equal to), <=(less than or equal to)
-- 논리 연산: and, or , not 
-- A and B 두개의 조건 동시만족, A or B 두개의 조건중 하나라도 만족

--사원 테이블에서 급여가 3000이상 4000이하인 사원들의 사번, 이름, 직책, 급여 검색
select empno, ename,job,sal from emp where sal>=3000 and sal<=4000;
select empno, ename,job,sal from emp where sal between 3000 and 4000;
--같은 결과지만 between 은 이상,이하 일 때만 가능, =가 없으면 and로 나눠서 써야함.

--사원 테이블에서 급여가 3000이상 (>=)이고, 5000 미만(<)인 사원들의 레코드 검색
select * from emp where sal>=3000 and sal<5000;
--and는 조건만 맞으면 여러번 사용가능 

--사원 테이블에서 급여가 1000이하 이거나 또는 5000이상인 직원들의 레코드
select * from emp where sal<=1000 or sal>=5000;

--사원 테이블에서 부서가 10번이 아닌 사원들의 사번, 이름, 부서번호를 검색
select empno,ename,deptno from emp where 10!=deptno;
-- !를 다른방법으로 표현하면 not을 사용
--select empno,ename,deptno from emp where not deptno =10;

--사원 테이블에서 10번 또는 20번 부서에서 근무하는 사원들의 레코드를 검색
select * from emp where deptno =10 or deptno = 20;
select * from emp where deptno in (10,20);
--in ( , , ,)  사용
--사원테이블에서 10번 또는 20번 또는 30번 부서에서 근무하는 사원들의 레코드 검색
select * from emp where deptno in (10,20,30);
select * from emp where deptno =10 or deptno = 20 or deptno=30;

-- 테이블에 저장된 값들은 대/소문자를 구분! 
-- oracle에서 문자열은 작은따옴표('')로 감싸줌.
-- 사원테이블에서 직책이 CLERK인 사원들의 레코드 검색
select * from emp where job = 'CLERK';
--CLERK이 아닌 사원들의 레코드 검색
select * from emp where job != 'CLERK';

--사원테이블에서
--1) 20번 부서에서 근무하거나 또는 SALESMEN 직책을 담당하는 사원의 
--부서번호,사번, 이름,직책을 검색
select deptno,empno,ename from emp where deptno=20 or job='SALESMEN';
--2)CLERK, ANALYST,MANAGER들의 사번, 이름, 직책, 급여 검색
select empno,ename,job,sal from emp where job in('CLERK','ANALYST','MANAGER');
--3)CLERK, ANALYST,MANAGER가 아닌 사원들의 사번,이름,직책,급여를 검색
select empno,ename,job,sal from emp where not job in('CLERK','ANALYST','MANAGER');