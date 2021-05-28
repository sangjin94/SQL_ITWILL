--함수(function): 입력값을 전달받아서 기능을 수행한 후 그 결과를 반환하는 것
--인수(argument): 함수에 전달하는 입력값. x값. 
--반환값(return value): 함수가 결과로 반환해주는 값. y값.



--문자열 함수 : 문자열을 조작해서 새로운 문자열을 반환해 주는 함수.
--upper(arg) : 입력받은 문자열(arg)를 대문자로 변환해서 반환하는 함수.
--lower(arg) : 입력받은 문자열(arg)를 소문자로 변환해서 반환하는 함수.
--initcap(arg) : 입력받은 문자열(arg)를 각 단어의 첫 글자만 대문자, 나머지는 소문자로 변환하는 함수

--dual: 함수 호출 결과를 출력하기 위한 더미 테이블 
SELECT
    upper('sql developer')
FROM
    dual;

SELECT
    lower('sql developer')
FROM
    dual;

SELECT
    initcap('sql developer')
FROM
    dual;

--emp테이블에서 사원이름을 모두 소문자로 변환해서 출력
SELECT
    lower(ename)
FROM
    emp; 
--emp 테이블에서 scott의 레코드를 검색
SELECT
    *
FROM
    emp
WHERE
    lower(ename) = 'scott';

SELECT
    *
FROM
    employees
WHERE
    lower(emp_name) LIKE '%michael%';

SELECT
    *
FROM
    employees
WHERE
    lower(job_id) LIKE '%sa%';
--레코드가 소문자인지 대문자인지 모르기 떄문에 전부 소문자로 바꾼후 검색


--substr(문자열, 시작인덱스, 문자갯수):
-- 문자열에서 시작인덱스에서부터 문자갯수만큼 잘라낸 문자열을 반환
--ex)
SELECT
    substr('Hello World', 0, 5)
FROM
    dual;

SELECT
    substr('Hello World', 1, 5)
FROM
    dual;

--substr() 함수를 사용할 때 잘라낼 문자갯수를 전달하지 않으면
--시작인덱스부터 문자열의 끝까지를 잘라냄
SELECT
    substr('http://www.google.com/', 8)
FROM
    dual;

SELECT
    substr('안녕하세요', 1, 3)
FROM
    dual;
--개인정보보호를 위해 주민번호 몇자리만 짤라내기위한 용도로 사용할수있음.

--length(문자열): 문자열의 문자 갯수를 반환.
--lengthb(문자열): 문자열이 차지하는 byte 수를 반환.
SELECT
    length('hello'),
    lengthb('hello')
FROM
    dual;

SELECT
    length('안녕하세요'),
    lengthb('안녕하세요')
FROM
    dual;

--lpad(문자열, 자릿수, 패딩문자) 왼쪽으로 패딩문자를 채워넣겠다
--rpad(문자열, 자릿수, 패딩문자) 오른쪽으로 패딩문자를 채워넣겠다
SELECT
    lpad('hello', 10, '*'),
    rpad('hello', 10, '*')
FROM
    dual;

--emp 테이블에서 사번과, 이름을 검색 출력
--이름은 첫 두글자만 출력하고, '*' 3개를 패딩으로 채워서 출력
SELECT
    empno,
    rpad(substr(ename, 1, 2), 5, '*') AS name
FROM
    emp;

--replace(문자열,before,after)
--문자열에 포함된 before 문자를 after문자로 변환
SELECT
    replace('jack and jue', 'j', 'bl')
FROM
    dual;
--문자열에 포함된 공백들을 제거하는 용도로 replace를 사용할수있다.
SELECT
    replace('hello   world   sql', ' ', '')
FROM
    dual;


-- 숫자관련함수
-- round(숫자): 반올림
-- trunc(숫자): 버림(truncate)
SELECT
    round(1234.5656, 2)
FROM
    dual;

SELECT
    trunc(1234.5656, 2)
FROM
    dual;

SELECT
    trunc(1234.5656, - 2)
FROM
    dual;


/*
사원 이름 5글자인 사원 정보 empno, ename을 출력.
사번은 앞 두 자리만 보여주고 나머지는 *로 출력
이름은 첫 글자만 보여주고 나머지는 *로 출력

(결과 예시)
empno mask_no ename mask_name
-----------------------------
 7369    73** SMITH S****
*/
SELECT
    empno,
    rpad(substr(empno, 0, 2), 4, '*')                               AS mask_no,
    ename,
    rpad(substr(ename, 0, 1), length(ename), '*')                   AS mask_name
FROM
    emp;
/*
사원들의 월 평균 근무일수는 21.5일이고, 하루 근무 시간을 8시간이라고 할 때,
사원들의 일 급여(day_pay), 시급(time_pay)를 계산하여 출력.
일 급여는 소숫점 세번째 자리에서 버림, 시급은 소숫점 두번째 자리에서 반올림
(결과 예시)
empno ename sal day_pay time_pay
--------------------------------
 7369 SMITH 800   37.20      4.7
*/
SELECT
    empno,
    ename,
    sal,
    trunc(sal / 21.5, 2)                   AS day_pay,
    round((sal / 21.5 / 8), 1)               AS time_pay
FROM
    emp;
    
    
--날짜 관련 함수 (add_months, months_between) 등
select sysdate from dual;
select add_months(sysdate,1) from dual;

--emp 테이블에서 사번, 이름,입사일,입사후 3달이 되는 시점 
--
select empno,ename,hiredate, add_months(hiredate,3)as hire_3
from emp;

select hiredate,trunc(months_between(sysdate,hiredate)) from emp;

select hiredate, round(hiredate,'MM'),trunc(hiredate,'YYYY')
from emp;


--타입 변환 함수 : to_char, to_number, to_date
select to_number('015,000,000','000,000,000') as "number"
from emp;
--(999,999)는 포멧 표현 999999까지 표현가능
-- 자리수가 맞으면 0으로도 가능.. 9는 자리수안맞아도 가능

select sysdate,to_char(sysdate,'DAY')
from dual;

--문자열 ~>날짜
select to_date('2021-05-28','yyyy-mm-dd'),to_date('05-28-21','mm-dd-yy')
from dual;

--emp 테이블에서 1987년 1월 1일 (포함) 이후에 입수한 사원들의 레코드 출력
select *
from emp
where hiredate >= to_date('1987-01-01','yyyy-mm-dd');

--null 값 대체 함수:
--nvl(컬럼, null 대체 값)
--nvl2(컬럼, null이 아닐때 대체할 값, null일 때 대체할값)
select comm, nvl2(comm,'TRUE',0)
from emp;
select comm, nvl(comm,0)
from emp;

--emp 테이블에서 사번,이름,급여, 연봉 (comm포함)을 출력
select empno,ename,sal,sal*12+nvl2(comm,comm,0) as annual_sal
from emp;

--emp테이블에서 연봉(comm포함)이 30000이상인 사원들의 사번, 이름,급여,수당,연봉
select empno,ename,sal,comm,(sal*12+nvl(comm,0)) as annual_sal
from emp;
where sal * 12 + nvl(comm, 0) >= 30000 ;

--comm이 null인 경우 null이 아닌 comm의 평균값으로 대체
select avg(comm) from emp; --avg 함수는 null값들을 제외하고 평균을 계산해줌.
select * from emp;
select nvl2(comm,comm,(select avg(comm) from emp))
from emp;
--단일행 함수와 그룹함수(다중행함수)는 함께 사용될 수 없음.
