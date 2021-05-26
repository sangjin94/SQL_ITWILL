--sql 워크시트 생성 (alt + f10): 새 워크시트(접속) 생성
--csv(Comma-Sperated Values)파일 :
--테이블의 값들이 comma로 구분된 형식의 텍스트 파일.
--(모든 csv가 comma로 구분된것은 아님 tab이나 colon(:) 등을 사용해서 구분할수도있음) 



--테이블 구조 확인
desc dept;
desc salgrade;
desc emp;
--VARCHAR2 variable 캐릭터

--sql 명령어 (키워드) 대/소문자를 구분하지 않음. (대소문자중 하나만 일관성지켜서 작성)
--oracle 데이터베이스 시스템은 테이블 이름과 컬럼 이름을 대문자로 변환, 관리.

--oracle의 데이터 타입(유형)
-- (1) number: 숫자 타입  , number(38): 38자리 숫자까지 저장가능
-- ex) number(10,5): 숫자 10자리와 소수점 5자리 까지
-- (2)varchar2: variable-length characters. 가변길이 문자열.
-- ex) varchar2(26): 26글자까지 저장가능 
-- (3)date: 날짜/시간.

--테이블에서 데이터를 검색 
-- (1) projection: 데이틀에서 원하는 컬럼을 검색
--select 컬럼1, 컬럼2,... from 테이블이름;
select empno,ename from emp;
select empno,ename,hiredate,sal from emp;
select empno,ename,sal,hiredate from emp;
--모든 컬럼을 검색
select *from emp;
-- (2) selection: 테이블에서 조건을 만족하는 레코드(행)을 검색

-- select할 때 컬럼 이름의 별명을 작성(as)
-- select 컬럼이름 as 별명, ... from 테이블이름;
select empno as 사번,ename as 이름 from emp;

--사원 테이블에서 사번, 이름, 급여, 연봉을 검색
select empno,ename,sal,sal*12 as annual_sal from emp;

--사원 테이블에서 직책 검색
select job from emp;
--컬럼에서 중복되지 않게 검색 (distinct)
select distinct job from emp;
--distinct는 select 문에서 한번만, 모든 컬럼들의 이름 앞에 사용!
select distinct job,deptno from emp;
-- job과 deptno 을 합쳐서 중복되지않게

--select job, distinct deptno from emp; 오류(error)발생문장
-- distinct가 컬럼 중간에 껴있기 때문