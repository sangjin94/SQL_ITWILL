--그룹함수 (여러 행 함수)
--컬럼의 모든 값이 입력으로 전달되서 하나의 값을 반환하는 함수
--avg(평균), sum(합계), max(최댓값), min(최솟값),
--variance(분산), stddev(표준편차),...

select *from emp;
select ename, lower(ename) from emp; --단일행 함수

select sal from emp;

select sum(sal),round(avg(sal),2),max(sal),min(sal),trunc(stddev(sal)),trunc(variance(sal))
from emp; --다중행 함수(그룹 함수)

--그룹함수는 단일행 함수 혹은 컬럼과 함께 select 할 수 없음!
select sal from emp; -- 14개 rows
select sum(sal) from emp; --1개 rows
select sal, sum(sal) from emp; --에러 발생 문장
select nvl(comm,-1) from emp; -- 14개 rows
select max(comm) from emp; -- 1개 row
select nvl(comm,-1), max(comm) from emp; --에러 발생 문장

--그룹함수들은 기본적으로 null을 제외하고 기능을 수행함!
select comm from emp;
select avg(comm) from emp; --평균을 계산할 떄 null이 아닌 행인 4로 나눔!

--count(column): comlumn에서 null이 아닌 자료의 숫자를 반환.
select count(sal) from emp;
select count(comm) from emp;

select count(*) from emp;--테이블의 전체 row의 갯수
select count(distinct deptno) from emp; --구분되는(중복되지않는)자료의 갯수

--10번 부서에 근무하는 사원들의 급여 평균, 최솟값, 최댓값, 표준편차를 출력
--소숫점은 2자리 까지 출력

select trunc(avg(sal),2) as avg,min(sal) as min,max(sal) as max,trunc(stddev(sal),2) as stddev
from emp
where deptno=10;
--20번 부서에 근무하는 사원들의 급여 평균, 최솟값, 최댓값, 표준편차를 출력
--소숫점은 2자리 까지 출력

select 10 as deptno,trunc(avg(sal),2),min(sal),max(sal),trunc(stddev(sal),2)
from emp
where deptno=20;
--숫자하나만 입력해서 as 별명을 붙여서 10을 표현 가능,
--그룹함수라서 단일함수를 넣을수없기때문에 꼼수로 쓸수있다.

--부서별 급여의 평균
select 10 as deptno ,round(avg(sal),2) as mean from emp where deptno=10
union
select 20 as deptno ,round(avg(sal),2) as mean from emp where deptno=20
union
select 30 as deptno ,round(avg(sal),2) as mean from emp where deptno=30;

select deptno, round(avg(sal),2) from emp
group by deptno order by deptno;

--직책(job)별 급여,평균,최솟값,최댓값 출력,직원수, 소수점은 2자리까지만 출력
select job,trunc(avg(sal),2) as mean,min(sal) as MIN,max(sal) as MAX,count(job) as members
from emp
group by job 
order by job;

--부서별,직책별 부서번호, 직책,사원수 , 급여 평균을 검색
--출력할때 정렬기준: (1) 부서번호 ~> (2) 직책
--소수점이 있는경우 소숫점2자리까지만 출력
select deptno,job,count(*)as members,trunc(avg(sal),2) as sal
from emp
group by deptno,job order by deptno,job;

--입사연도별 입사연도, 사원수출력
select to_char(hiredate,'yyyy')as hireyear,count(*) 
from emp
group by To_Char(hiredate,'yyyy')
order by hireyear;
--select 구문에서 지정한 별명(alias)은
--where,group by,having 절에서는 사용할 수 없지만,
--order by에서는 사용할 수 있음!

