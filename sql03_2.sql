--문자열도 크기(대소)비교가 가능: 알파벳(사전) 순서
--<A<B<C<a<b<c
SELECT
    ename
FROM
    emp
WHERE
    ename >= 'C';

-- 날짜도 크기비교 가능 1월 1일보다 1월 2일이 더 크다. 
-- 년도비교후 월 비교후 일 비교후 시간 비교후 분 비교후 초
SELECT
    *
FROM
    emp
WHERE
    hiredate >= '1981/12/01'
ORDER BY
    hiredate;

--특정 문자(열)로 시작하는 단어 검색
SELECT
    ename
FROM
    emp
WHERE
    ename LIKE 'A_%';
-- %와 _ 의 차이점은 %는 없어도되고 여러글자가 와도되고 _는 딱 한글자만 
SELECT
    ename
FROM
    emp
WHERE
    ename LIKE '_DAMS';

--사원 이름 중에 'E'가 포함된 사원들의 레코드 검색
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%E%';
 
--집합 연산자 : 합집합(union), 교집합(intersection), 차집합(minus)
SELECT
    *
FROM
    emp
WHERE
    deptno = 20; -- 결과 : 5개 row 
SELECT
    *
FROM
    emp
WHERE
    sal >= 3000; -- 결과 : 3개 row 
-- (1)과 (2)를 동시에 만족하는 결과(교집합): 2개 row
SELECT
    *
FROM
    emp
WHERE
        deptno = 20
    AND sal >= 3000;

--교집합
SELECT
    *
FROM
    emp
WHERE
    deptno = 20
INTERSECT
SELECT
    *
FROM
    emp
WHERE
    sal >= 3000;

--합집합
SELECT
    *
FROM
    emp
WHERE
    deptno = 10; --결과 3개 
SELECT
    *
FROM
    emp
WHERE
    deptno = 20; --결과 5개
SELECT
    *
FROM
    emp
WHERE
    deptno = 10
    OR deptno = 20;

결과 8개
--합집합 다른방법(union)
select * from emp where deptno=10
union
select * from emp where deptno=20;

--is not null , is null 연산자
select *from emp where comm=null; --0개 row
select * from emp where comm is not null; --4개 row
select * from emp where comm is null;--10개 row

--1) 30번 부서에서 일하는, 직책이 SALESMAN 인 직원들의
-- 사번, 이름, 급여, 부서번호를 검색
select empno,ename,sal,deptno
from emp
where deptno='30' and job='SALESMAN';
-- 2)20,30번 부서에서 일하는 직원들 중에서 급여가 2000을 초과하는 
-- 직원들의 사번,부서번호, 이름, 급여를 검색
select empno,deptno,ename,sal
from emp
where deptno in(20,30) and sal>2000;
--3) 수당이 없는 직원들 중에서, 매니저가 있고, 직책이 MANAGER 또는 CLERK인 
--직원들의 모든 정보를 검색

SELECT    *
FROM    emp
WHERE
    comm IS NULL
    AND mgr IS NOT NULL
        AND ( job = 'MANAGER'
              OR job = 'CLERK' ) ;

SELECT *
FROM emp
WHERE    comm IS NULL
    AND mgr IS NOT NULL
        AND job in ('MANAGER','CLERK') ; 
    
 