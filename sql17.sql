-- DML(Data manipulation language)
-- insert: 테이블에 레코드(행)을 삽입(추가)
-- update: 테이블의 특정 컬럼의 값을 변경(갱신)
-- delete: 테이블의 레코드(행)을 삭제

--TCL(Transaction Control Language) commit, rollback
--commit: 테이블의 변경 내용(insert, update, delete)을 데이터 베이스에 영구히 저장. 
--DML은 commit 명령 수행 후 데이터베이스에 반영됨.
--DDL은 자동 commit;
--rollback : 최종 commit 상태로 되돌리기.

--insert into 테이블이름(컬럼,...) values(값,...);
--update 테이블이름 set 컬럼=값,... where 조건;
--delete from 테이블이름 where 조건;

select * from emp;

--emp 테이블의 모든 sal을 100으로 수정

update emp set sal = 100;
rollback; --최종 commit 상태로 되돌리기

--emp 테이블서 smith의 sal 을 1000으로 업데이트
update emp set sal = 1000 where ename='SMITH';

-- 사번이 7499인 직원의 급여를 2000, 수당을 500으로 업데이트
update emp set sal=2000, comm=500 where empno=7499;

--DDL(create,drop,alter)는 자동 commit;

--평균 급여보다 적은 급여를 받는 직원들의 급여를 10%인상
update emp set sal=sal*1.1 where sal<(select avg(sal) from emp);
--매니저가 king인 직원들의 수당을 100으로 업데이트
update emp set comm=100 
where mgr=(select empno from emp where ename = 'KING');
-- RESEARCH 부서에서 근무하는 직원들의 수당으로 50으로 업데이트
update emp set comm=50 where deptno=(select deptno from dept where dname='RESEARCH');
-- SCOTT의 급여를 KING의 급여와 동일하게 업데이트
update emp set sal=(select sal from emp where ename='KING') where ename='SCOTT';    
-- 직책이 SALESMAN인 직원들의 급여를 ALLEN의 급여와 동일하게 업데이트
update emp set sal=(select sal from emp where ename='ALLEN') where job='SALESMAN';
-- MILLER의 급여와 수당을 SMITH와 동일하게 업데이트
update emp set sal=(select sal from emp where ename='SMITH'),comm=(select comm from emp where ename='SMITH')
where ename='MILLER';
--위랑 아래와 같다
update emp set (sal,comm)=(select sal,comm from emp where ename='SMITH')
where ename='MILLER';
-- comm이 NULL인 직원들의 comm을 -1로 업데이트
update emp set comm='-1' where comm is null;
-- 10번 부서에서 입사일이 가장 늦은 직원보다 더 늦게 입사한 직원의
-- 부서 번호를 30번으로 업데이트
update emp set deptno=30 where hiredate>(select max(hiredate) from emp where deptno=10);

-- 10번 부서의 가장 늦은 입사일보다 더 늦게 입사한 직원의 
-- 부서를 OPERATIONS 부서로 업데이트
update emp set deptno=(select deptno from dept where dname='OPERATIONS') where hiredate>(select max(hiredate) from emp where deptno=10);
--위의 작업 내용을 데이터베이스 영구히 저장
commit;

--테이블 행(레코드)삭제 

delete from emp; --where 조건절이 없으면 테이블의 모든행을 삭제

--사번이 1004인 직원의 레코드(행) 삭제
delete from emp where empno=1004;
-- ALLEN의 레코드 삭제
delete from emp where ename='ALLEN';

insert into emp(empno, ename) values (1004,'오쌤');

--급여등급이 5인 사원들의 레코드를 삭제
delete from emp where sal 
between (select losal from salgrade where grade=5)
and(select hisal from salgrade where grade=5) ; 
rollback;
--join을 이용
delete from emp where empno in(select empno
from emp e join salgrade s
    on e.sal between s.losal and s.hisal
where s. grade= 5);