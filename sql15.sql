--call_chicken.csv 파일 다운로드
--테이블 이름 :call_chicken
-- 컬럼, call_date , call_day, gu, ages, gender, calls

create table call_chicken(
call_date date,
call_day varchar2(1 char),
gu varchar2(5 char),
ages varchar2(5 char),
gender varchar2(1 char),
calls number(4)
);

select * from call_chicken;

-- 1. 통화건수의 최댓값, 최솟값
SELECT max(calls),min(calls)
from call_chicken ;
-- 2.통화건수가 최댓값이거나 또는 최솟값인 레코드를 출력
select * from call_chicken
where calls = (select max(calls) from call_chicken)
or calls = (select min(calls) from call_chicken);
-- 3. 통화요일별 통화건수의 평균
SELECT call_day,round(avg(calls),1)
from call_chicken 
group by call_day
order by avg(calls) desc;
-- 4. 연령대별 통화건수의 평균
SELECT ages,round(avg(calls),1)
from call_chicken 
group by ages
order by avg(calls) desc;
-- 5. 통화요일별, 연령대별 통화건수의 평균
SELECT call_day,ages,round(avg(calls),1)
from call_chicken 
group by call_day, ages
order by avg(calls) desc;
-- 6. 구별, 성별 통화건수의 평균
SELECT gu,gender,round(avg(calls),1)
from call_chicken 
group by gu,gender
order by avg(calls) desc;
-- 7. 요일별, 구별, 연령대별 통화건수의 평균
SELECT call_day,gu,ages,round(avg(calls),1)
from call_chicken 
group by  call_day,gu,ages
order by avg(calls) desc;
-- 3~7 문제의 출력은 통화건수 평균의 내림차순 정렬,소수점 1자리까지 반올림