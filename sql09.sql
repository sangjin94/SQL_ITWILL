-- JOIN: 두 개 이상의 테이블에서 검색을 해서 결과를 만드는 것. 
/* 
1. Oracle 문법
select 컬럼, ...
from 테이블1, 테이블2, ...
where join조건;
2. ANSI 표준 문법
select 컬럼, ...
from 테이블1 join종류 테이블2 
    on join조건;
*/

-- 사번, 이름, 부서번호, 부서이름 검색
-- inner join 두테이블중에서 함께 존재하는 요인들만 보여주겠다.(교집합)
--outer조인 종류 (left,right,full)
--조건에서 = != 가 들어가면 equi join ><가 들어가면 non equi join이다.
select emp.empno, emp.ename, emp.deptno, dept.dname
from emp, dept
where emp.deptno = dept.deptno;

-- 위의 Oracle 문법과 동일한 ANSI 표준 문법
select emp.empno, emp.ename, emp.deptno, dept.dname
from emp inner join dept
    on emp.deptno = dept.deptno;

-- join을 할 때 from의 테이블 이름에 별명을 줄 수 있음.
-- from에서 지정한 별명을 select절에서 사용할 수 있음.
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno;

select e.empno, e.ename, e.deptno, d.dname
from emp e inner join dept d
    on e.deptno = d.deptno;
    
insert into emp(empno, ename, deptno)
values(1004, '오쌤', 50);
commit;

--emp테이블에서 부서번호 50번인 오쌤은 inner join 결과에 없음.
--부서번호 50은 dept 테이블에 없기 때문에.
--dept 테이블에 있는 부서번호 40번 operation도 inner join 결과에 없음.
--emp테이블의 deptno 컬럼에는 40이 없기 때문에.

--left outer join
--ORACLE 방식
select e.empno, e.ename, e.deptno, d.dname
from emp e ,dept d 
where e.deptno= d.deptno(+); --오른쪽 데이터를 왼쪽에다가 붙이겠다

select e.empno, e.ename, d.deptno, d.dname --d.deptno에 데이터가없기떄문에 null로 나옴

from emp e ,dept d 
where e.deptno= d.deptno(+); --오른쪽 데이터를 왼쪽에다가 붙이겠다
--ANSI 표준방식
select e.empno, e.ename, e.deptno, d.dname
from emp e left outer join dept d
    on e.deptno=d.deptno;
    
--left outer join에서는 왼쪽 테이블 emp 에만 등장하는
--부서번호 50번에 대한 레코드도 함께 검색됨
--하지만 오른쪽테이블 dept에만 등장하는 부서번호 40번에대한 record는 검색되지않음.
--ORACLE 방식
select e.empno, e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno(+)=d.deptno; --왼쪽에서 오른쪽으로 붙일게요~
--2. ANSI 표준 문법
select e.empno, e.ename, d.deptno, d.dname
from emp e right outer join dept d
    on e.deptno=d.deptno;
--right outer join에서는 오른쪽 테이블 dept 에만 등장하는 40번 검색
--부서번호 50번에 대한 레코드는 함께 검색되지 않음.

-- full outer join 
--이방식은 ORACLE 문법은 없고(union을 사용하면 가능하긴함) ANSI표준 방식은 있기때문에 ANSI표준
--방식을 꼭알아야함.
select e.empno, e.ename, e.deptno, d.dname
from emp e full outer join dept d
    on e.deptno = d.deptno;

--   union을사용해 oracle 문법이용 full outer join을 표현할수있음.

select e.empno, e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno=d.deptno(+) --reft outer join
union
select e.empno, e.ename, d.deptno, d.dname
from emp e, dept d
where e.deptno(+)=d.deptno; --right outer join

--join 이름을 쓸 때 inner와 outer 는 생략가능!
--inner join = join
--left (outer) join
--right (outer) join
--full (outer) join

--cross join(cartesian product) 모든 가능한 경우의수를 다보여줌
select e.empno,e.ename,e.deptno,d.deptno,d.dname
from emp e, dept d;

--emp,dept 테이블에서 사번, 이름, 부서이름, 급여를 출력(inner join)
--급여가 2000이상인 직원들만 선택
--급여의 내림차순 정렬
select e.empno, e.ename,d.dname,e.sal
from emp e, dept d
where e.deptno=d.deptno and e.sal>=2000
order by e.sal desc ;
--ANSI 문법
select e.empno, e.ename,d.dname,e.sal
from emp e join dept d
on e.deptno=d.deptno
where e.sal>=2000
order by e.sal desc ;

--SELF JOIN
--사번,이름, 매니저 사번, 매니저 이름 검색
--oracle 방식
select e1.empno,e1.ename,e1.mgr,e2.ename as mgr_name
from emp e1,emp e2
where e1.mgr=e2.empno;
--ANSI 방식
select e1.empno,e1.ename,e1.mgr,e2.ename as mgr_name
from emp e1 join emp e2
on e1.mgr=e2.empno;

--3) oracle, leftjoin
select e1.empno,e1.ename,e1.mgr,e2.ename as mgr_name
from emp e1,emp e2
where e1.mgr=e2.empno(+);

--4)ANSI,leftjoin
select e1.empno,e1.ename,e1.mgr,e2.ename as mgr_name
from emp e1 left join emp e2
on e1.mgr=e2.empno;

--5) oracle, right join !> 매니저로 등록이 안된 직원들까지 전부출력됨.
select e1.empno,e1.ename,e1.mgr,e2.ename as mgr_name
from emp e1,emp e2
where e1.mgr(+)=e2.empno;

--6)ANSI,right join
select e1.empno,e1.ename,e1.mgr,e2.ename as mgr_name
from emp e1 right join emp e2
on e1.mgr=e2.empno;

select e1.empno, e1.ename, e1.mgr,e2.ename as mgr_name
from emp e1 full join emp e2
on e1.mgr=e2.empno
order by e1.empno;


--non-equi join
--emp테이블과 salgrade 테이블에서 사번,이름,급여,급여등급을 검색
--1)oracle
select e.empno,e.ename,e.sal,s.grade
from emp e , salgrade s
where  e.sal BETWEEN s.losal and s.hisal;
--2)ANSI
select e.empno,e.ename,e.sal,s.grade
from emp e join salgrade s
on  e.sal BETWEEN s.losal and s.hisal;

--3)oracle,left join 
select e.empno,e.ename,e.sal,s.grade
from emp e, salgrade s
where e.sal between s.losal(+) and s.hisal(+); --오른쪽에있는 컬럼 전부에 (+)을 붙임
----4)ANSI, left join
select e.empno,e.ename,e.sal,s.grade
from emp e left join salgrade s
on  e.sal BETWEEN s.losal and s.hisal;

-- emp, dept,salgrade 테이블에서 사번, 이름, 부서이름,급여,급여등급을 검색
--ORACLE
select e.empno,e.ename,d.dname,e.sal,s.grade
from emp e , dept d, salgrade s
where e.deptno=d.deptno(+)
and e.sal BETWEEN s.losal(+) and s.hisal(+);
--ANSI 표준문법
select e.empno,e.ename,d.dname,e.sal,s.grade
from emp e 
 LEFT join dept d on e.deptno = d.deptno
 LEFT join salgrade s on e.sal BETWEEN s.losal and s.hisal;
--LEFT와 RIGHT를 섞지말고 메인테이블을 먼저 작성후 메인테이블 방향으로 몰아준다.