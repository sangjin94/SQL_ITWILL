--sub query

--emp 테이블에서, 전체 직원의 급여의 평균보다 
--더 많은 급여를 받는 직원들의 레코드를 검색
--1)전체 직원의 급여 평균
select avg(sal) from emp;

--2)평균보다 급여를 더 많이 받는 직원
select * from emp
where sal > (select avg(sal) from emp);

--emp테이블 에서 ,allen보다 적은 급여를 받는 직원들의 사번, 이름 ,급여
select empno, ename,sal from emp
where sal<(select sal from emp where lower(ename)='allen');

--emp 테이블에서 allen과 같은 직책의 직원들의 사번,이름,부서번호, 직책, 급여를 출력
select empno, ename,job,sal from emp
where job=(select job from emp where ename='ALLEN');

--salesman의 급여 최댓값보다 더 많은 급여를 받는 직원들의 사번, 이름, 급여, 직책을 출력
 select empno, ename,sal,job from emp
 where sal>(select max(sal) from emp where job='SALESMAN');  
 
-- 연봉 = sal*12+comm
--연봉을 계산할 때 comm이 null인 경우에는 0으로 변환해서 계산.
-- WARD의연봉보다 더 많은 연봉을 받는 직원들의 
-- 사번, 이름 , 급여, 수당 ,연봉을 출력
--연봉의 내림차순 정렬해서 출력.

select empno, ename,sal,nvl(comm,0)as comm, sal*12+nvl(comm,0)  as year_sal from emp
where sal*12+nvl(comm,0)>(select sal*12+nvl(comm,0) from emp where ename='WARD')
order by sal*12+nvl(comm,0) desc;

--각 부서에서 급여가 가장 적은 직원들의 레코드를 검색
--1)각 부서의 급여 최솟값
select min(sal) from emp group by deptno;
--2) 급여가 950또는 800 또는 1300인 직원들의 레코드
select * from emp where sal in (950,800,1300);
-- 1),2)의 결과를 sub query를 사용해서 합침.
select * ,from emp
where sal in (select min(sal) from emp group by deptno);

--10번 부서에서 급여가 1300인 직원
--또는, 20번 부서에서 급여가 800인 직원
--또는, 30번 부서에서 급여가 950인 직원
select * from emp
where (deptno,sal) in (select deptno, min(sal) from emp group by deptno);

--각 부서에서 급여가 최댓값인 직원들의 레코드 검색
--부서번호 오름차순 정렬
select * from emp
where (deptno,sal) in (select deptno,max(sal) from emp group by deptno)
order by deptno;





-- 1. 20번 부서에서 근무하는 직원들 중에서
-- 30번 부서에 없는 직책을 가진 직원들의 레코드를 출력
select * from emp
where deptno=20 and job not in (select distinct job from emp
where deptno=30); 

--차집합 이용
select * from emp
where job in (
select job from emp where deptno = 20
minus
select job from emp where deptno = 30)
;


-- 2. 급여 최댓값인 직원의 이름과 급여를 출력
select ename,sal
from emp
where sal=(select max(sal)from emp);

-- 3. JONES보다 급여를 더 많이 받는 직원들의 이름과 급여를 출력
select ename,sal
from emp
where sal>(select sal from emp where ename='JONES');

-- 4. SCOTT과 같은 급여를 받는 직원들의 이름과 급여를 출력
select ename,sal
from emp
where sal=(select sal from emp where ename='SCOTT');

-- 5. 4번 결과에서 SCOTT은 제외하고 출력
select ename,sal
from emp
where sal=(select sal from emp where ename='SCOTT') and ename != 'SCOTT';

-- 6. DALLAS에서 근무하는 사원들의 이름과 급여를 출력
--서브쿼리 emp테이블과 dept테이블 이용
select ename,sal
from emp
where deptno=(select deptno from dept where loc='DALLAS');

-- 7. ALLEN보다 늦게 입사한 사원들의 이름과 입사날짜를 최근 입사일부터 출력
select ename, hiredate
from emp
where hiredate>(select hiredate from emp where ename='ALLEN')
order by hiredate desc;

-- 8. 매니저가 KING인 직원들의 사번과 이름을 출력
select empno,ename
from emp
where mgr=(select empno from emp where ename='KING');

-- 9. 관리자인 직원들의 사번, 이름, 부서번호를 출력
select empno,ename,deptno
from emp
where empno in (select distinct mgr from emp);

-- 10. 관리자가 아닌 직원들의 사번, 이름, 부서번호를 출력
select empno,ename,deptno
from emp
where empno in(select empno from emp minus select distinct mgr from emp);
--혹은
select empno,ename,deptno
from emp
where empno not in (select distinct mgr from emp where mgr is not null);
--
select empno,ename,deptno
from emp
where empno not in (select distinct nvl(mgr,-1) from emp);
--col in (a,b) : col = a or col = b  라는뜻
--col not in (a,b) : col !=a and col !=b 라는 뜻 드모르간의 법칙
--col in (1,null):col=1 or col=null  <~ null과 =의 비교는 항상 false 가나옴
--col not in (1,null): col !=1 and col !=null <~ 이것도 무조건 false
-- null 은 = , != 로 비교할수 없다.  is null, in not null
--null 값만 없애면 값이 나오기때문에 nvl(column,number)로 바꿔서 출력도 가능

--다중  subquery에서 ALL 과 ANY
--any는 조건을 만족하는것중 하나라도 : or같은 개념
--10번 부서 직원들의 급여
select sal from emp where deptno=10;

select * from emp 
where sal < (select sal from emp where deptno=10); --에러발생

select * from emp 
where sal < all(select sal from emp where deptno=10);
--where sal <all(2450,5000,1300)
--where sal <2450 and sal<5000 and sal <1300

select * from emp 
where sal < (select max(sal)  from emp where deptno=10);
--where sal <any(2450,5000,1300)
--where sal <2450 or sal<5000 or sal <1300