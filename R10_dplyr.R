# dplyr 패키지를 사용한 데이터 탐색
search()
#select(): 데이터 프레임에서 원하는 컬럼(variable)(변수)를 선택.
#filter(): 데이터 프레임에서 조건을 만족하는 행 (관찰값)을 선택.
#arrange(): 데이터 프레임을 출력할 때, 변수를 기준으로 정렬하는것. (order by 와 비슷)
#mutate(): 파생 변수를 추가. 
#group_by(): 그룹별 묶기.
#summarize(), summarise() : 통계값 계산(통계 함수 적용)

#dplyr 패키지의 대부분의 함수들은 첫번째 argument로 데이터프레임을 전달함.
#dplyr 패키지의 대부분의 함수들은 새로운 데이터 프레임을 생성해서 리턴!
# 즉, 원본 데이터 프레임은 변경되지않는다. 

#필요한 패키지 로드
library(tidyverse)

#csv_exam.csv 파일을 읽어서 데이터 프레임 생성.
exam<- read.csv(file = 'datasets/csv_exam.csv')
exam

#select() 함수
#exam 데이터 프레임에서 id와 math를 출력
select(exam,id,math)

#exam 데이터 프레임에서 id, math, english, science를 선택
select(exam,id,math,english,science)
#exam데이터 프레임에서 class변수를 제외하고 모든변수 선택.
select(exam,-class)

#파이프(pipe)연산자 %>% : 
# dplyr패키지를 로드했을때 사용가능.
#data_frame %>% function():
# data_frame 을 function의 첫번쨰 argument로 전달해줌.
#ctrl+shift+M: 파이프 연산자
exam%>% select (id,math)
exam %>% select(-class)

#filter()함수
#exam 데이터 프레임에서 class가 1인 학생들의 observation 출력
#비교연산자: == ,!=,<,<=,>,>=
#논리 연산자: & (and), | (or), ! (not)
filter(exam,class ==1)
exam %>% filter(class==1)

#exam 데이터 프레임에서 class가 1또는 2인 obsercavion
exam %>% filter(class==1| class==2)

# 변수이름%in% 벡터 (or를 다른식으로 표현)
filter(exam,class%in% c(1,2))

#1반 학생중에서 수학점수가 50점이상인 observation
exam %>% filter(class==1&math>=50)
filter(exam,class==1&math>=50)

# 수학점수가 평균이상인 학생들의 id와 수학점수
#평균 : MEAN(exam$math)
subset <-filter(exam,math>=mean(exam$math)) 
#> 수학 점수가 평균 이상인 학생들만 갖는 데이터 프레임
select(subset,id,math)

exam %>% #exam데이터 프레임에서 
  filter(math>=mean(math)) %>% #수학점수가 평균 이상인 학생
  select(id,math) #id와 math를 선택하겠다.

#수학점수가 평균이상인 학생들의 id와 과학점수를 알고싶다.
exam %>% 
  filter(math>=mean(math)) %>%
  select(id,science)

# exam %>%
#   select(id,science) %>%
#   filter(math>=mean(math))
# 에러발생

#arrange()함수
#exam 데이터 프레임을 수학점수 오름차순으로 출력
arrange(exam,math)
#exam 데이터 프레임을 수학점수 내림차순으로 출력
arrange(exam,desc(math))
arrange(exam,-math)

#수학 점수 상위 5명출력
exam %>% #exam데이터프레임에서
  arrange(-math) %>% #수학 점수 내림차순 정렬
  head(n=5) #위에서 5개 행 선택
arrange(exam,-math) %>% head(n=5)
#수학 점수 하위 5명출력
arrange(exam,math) %>% head(n=5)
arrange(exam,-math) %>% tail(n=5)

#1반 학생들 중에서 수학점수 상위 2명의 id math science 출력
exam %>% 
  filter(class==1) %>%   
  arrange(-math) %>% head(n=2) %>%
  select(id,math,science)

#1,2반 학생들 중에서 수학 점수 상위 4명의 id,class,math,science 출력
exam %>%  filter(class==1|class==2) %>%  # class %in% c(1,2)
  arrange(-math) %>% head(n=4) %>%
  select(id,class,math,science)

# mutate() 함수 
mutate(exam,total = math+english+science)
#> mutate()함수는 원본 데이터 프레임 exam을 수정하는것이 아니라,
#파생변수가 추가된 새로운 데이터 프레임을 만들어서 리턴함.

#비교
exam$total<-exam$math+exam$english+exam$science
#이경우 exam DF의 원본이 수정이됨. 
exam <-read.csv(file = 'datasets/csv_exam.csv')
#exam 데이터 프레임에 세과목 총점(total), 평균 파생변수 추가
mutate(exam,
       total = math+english+science,
       average = total/3)
#원본데이터에 박제
exam$total<-(exam$math+exam$english+exam$science)
exam$average<-(exam$total)/3
exam

#summarise( )함수

#비교 
summary(exam)

#exam 데이터 프레임에서 math의 평균, 표준편차 계산
mean(exam$math) #평균 (mean)
sd(exam$math)   #표준편차(standard deviation)
median(exam$math) #중앙값(median)

summarise(exam, mean_math=mean(math),sd_math=sd(math))
exam %>% 
  summarise( mean_math=mean(math),sd_math=sd(math))
#변수(객체)<- 값
#함수(파라미터 = 값)

#1반 학생들의 과학 점수 평균과 표준편차
exam %>% filter(class==1) %>% summarise(mean(science),sd(science))

