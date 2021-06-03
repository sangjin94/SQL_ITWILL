-- join,group by 연습: oracle, ANSI 문법

--1. emp,dept 테이블에서 부서번호, 부서이름,
--부서별 사원수,부서별 급여 최솟값,부서별 급여 최댓값,급여평균을
--출력하고 소숫점이 있는 경우에는 소숫점 한자리까지 반올림해서 출력
--부서번호 오름차순 순서로 출력.
--oracle
select e.deptno,d.dname,count(*)as count_EMP,min(e.sal)as min_sal,max(e.sal) as max_sal,round(avg(e.sal),1)as avg_sal
from emp e, dept d
where d.deptno=e.deptno
GROUP BY e.deptno,d.dname
order by e.deptno;
--Ansi
select e.deptno,d.dname,count(*),min(e.sal),max(e.sal),round(avg(e.sal),1)
from emp e JOIN dept d
on d.deptno=e.deptno
GROUP BY e.deptno,d.dname
order by e.deptno;
--2.emp,dept 테이블에서
--부서번호, 부서이름, 사번, 이름, 직책,급여를 검색
--부서 테이블의 모든 부서번호/이름은 출력되야 됨
--부서번호 오름차순 순서로 출력
--oracle
select d.deptno,d.dname, e.empno, e.job, e.sal
from dept d, emp e
where d.deptno=e.deptno(+)
order by d.deptno;
--ANSI
select d.deptno,d.dname, e.empno, e.job, e.sal
from dept d left join emp e
on d.deptno=e.deptno
order by d.deptno;
-- 3. emp, dept, salgrade에서
-- 부서번호, 부서이름, 사번, 이름, 매니저사번, 매니저이름, 급여, 급여 등급을 검색
-- dept 테이블의 모든 부서 번호가 출력 되어야 함.(10, 20, 30, 40)
-- 매니저가 없는 사원의 정보도 출력되어야 함.(KING)
-- 출력 순서: 부서번호 오름차순 -> 사번 오름차순
select d.deptno as "부서번호",d.dname as "부서이름", e1.empno as "사번", e1.ename as "이름", e1.mgr, e2.ename, e1.sal, s.grade

from dept d, emp e1,emp e2, salgrade s
where d.deptno= e1.deptno (+)and e1.mgr=e2.empno(+) and e1.sal between s.losal(+) and s.hisal(+)
order by d.deptno, e1.empno;

--ANSI
select d.deptno as "부서번호",d.dname as "부서이름", e1.empno as "사번", e1.ename as "이름", e1.mgr, e2.ename, e1.sal, s.grade
from dept d
left join emp e1 on d.deptno= e1.deptno 
left join emp e2 on e1.mgr=e2.empno 
left join salgrade s on e1.sal between s.losal and s.hisal
order by d.deptno, e1.empno ;

-- 4. emp, dept 테이블에서
-- 부서 위치, 부서에서 근무하는 사원 수 검색(inner join)
-- 부서 위치, 부서에서 근무하는 사원 수 검색(outer join)
select d.loc, count(*) --inner join
from emp e, dept d
where e.deptno=d.deptno
group by d.loc;
select d.loc, count(e.deptno)--right join
from emp e, dept d
where e.deptno(+)=d.deptno
group by d.loc;

--ANSI
select d.loc, count(e.deptno) as "근무하는 사원수"
from emp e join dept d
on e.deptno=d.deptno
group by d.loc;

-- 5. emp, dept, salgrade 테이블에서
-- 직원 이름, 부서 위치, 급여, 급여 등급을 검색.
-- 급여는 3000 이상인 직원들만 선택.
-- 직원 이름 오름차순 정렬.
select e.ename, d.loc, e.sal,s.grade
from emp e, dept d, salgrade s
where e.sal>=3000 and e.deptno=d.deptno and e.sal BETWEEN s.losal and s.hisal
order by e.ename;
--ANSI
select e.ename, d.loc, e.sal,s.grade
from emp e 
join dept d on e.sal>=3000 and e.deptno=d.deptno
join salgrade s on e.sal BETWEEN s.losal and s.hisal 
order by e.ename;
-- where 사용
select e.ename, d.loc, e.sal,s.grade
from emp e 
join dept d on e.deptno=d.deptno
join salgrade s on e.sal BETWEEN s.losal and s.hisal 
where e.sal>=3000
order by e.ename;