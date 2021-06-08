--
--1) https://github.com/JakeOh/202105_itw_bd26/raw/main/lab_oracle/gapminder.tsv 파일 다운로드.
--2) 파일의 내용을 저장할 수 있는 테이블을 생성.
--   테이블 이름: GAPMINDER
--   컬럼: COUNTRY, CONTINENT, YEAR, LIFE_EXP, POP, GDP_PERCAP
--3) SQLDeveloper의 데이터 임포트 기능을 사용해서 파일의 내용을 테이블에 임포트
--4) 테이블에는 모두 몇 개의 나라가 있을까요?
select count(DISTINCT(country)) from gapminder;
--5) 테이블에는 모두 몇 개의 대륙이 있을까요?
select count(DISTINCT(continent)) from gapminder;
--6) 테이블에는 저장된 데이터는 몇년도부터 몇년도까지 조사한 내용일까요?
select min(year)||'~'||max(year) as 조사기간 from gapminder;
--7) 평균 수명이 최댓값인 레코드(row)를 찾으세요.
select * from gapminder where lifeexp =(select max(lifeexp) from gapminder);
--8) 인구가 최댓값인 레코드(row)를 찾으세요.
select * from gapminder where pop =(select max(pop) from gapminder);
--9) 1인당 GDP가 최댓값인 레코드(row)를 찾으세요.
select * from gapminder where gdppercap =(select max(gdppercap) from gapminder);
--10) 우리나라의 통계 자료만 출력하세요.
select * from gapminder where country='Korea, Rep.';
--11) 연도별 1인당 GDP의 최댓값인 레코드를 찾으세요.
select *
from gapminder g1,(SELECT year, MAX(gdppercap) gdp 
    FROM gapminder
    GROUP BY year) g2
where g1.year=g2.year and g1.gdppercap= g2.gdp;

--12) 대륙별 1인당 GDP의 최댓값인 레코드를 찾으세요.
select *
from gapminder g1,(select continent, max(gdppercap) gdp 
    from gapminder
    group by continent) g2
where g1.continent=g2.continent and g1.gdppercap= g2.gdp;
--13) 연도별, 대륙별 인구수를 출력하세요.
select year,continent,sum(pop) 
from gapminder
group by year,continent
order by sum(pop) desc; 
--    인구수가 가장 많은 연도와 대륙은 어디인가요?
2007년 asia
--14) 연도별, 대륙별 평균 수명의 평균을 출력하세요.
select year,continent,round(avg(lifeexp),1)
from gapminder
group by year,continent
order by avg(lifeexp) desc;
--    평균 수명이 가장 긴 연도와 대륙은 어디인가요?
2007 oceania
--15) 연도별, 대륙별 1인당 GDP의 평균을 출력하세요.
select year,continent,round(avg(GDPPERCAP),1)
from gapminder
group by year,continent
order by avg(GDPPERCAP) desc;
--    1인당 GDP의 평균이 가장 큰 연도와 대륙은 어디인가요?
2007	Oceania
--*** 수업 외 내용 ***
--16) 13번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
SELECT *
  FROM (select year,continent,sum(pop) 
from gapminder
group by year,continent
order by sum(pop) desc) as result
PIVOT ( year,continent FOR  continent
IN ('asia','africa','Americas','Africa','Europe','Oceania') )AS pivot_result;
--17) 14번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
--18) 15번 문제의 결과에서 대륙이름이 컬럼이 되도록 출력하세요.
--파일이름 : 안상진.sql 
--이메일 :jake.oh.lecture@gmail.com

--다음주 월요일 까지
