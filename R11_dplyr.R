# ggplot2::mpg 데이터 프레임 사용
library(tidyverse)
search()
mpg
# cyl 가 4인 자동차들의 고속도로 연비 평균
mpg %>% filter(cyl==4) %>% summarise(mean_hwy=mean(hwy))
#자동차 종류(class) 가 'compact' 인 자동차들의 고속도로 연비 평균
mpg %>% filter(class=="compact") %>% summarise(mean_hwy=mean(hwy))

#자동차 종류가 'suv' 인 자동차 hwy 평균, 표준편차
mpg %>% filter(class=='suv') %>% summarise(mean_hwy=mean(hwy),sd_hwy=sd(hwy))

#제조사의 빈도수-table
#빈도수가 가장 높은 제조사 2개의 hwy의 평균
table(mpg$manufacturer) 
mpg %>% filter(manufacturer=='dodge')%>% summarise(mean(hwy))
mpg %>% filter(manufacturer=='toyota')%>% summarise(mean(hwy))

#mutate() 함수를 사용. mean_mpg 파생변수(시내연비,고속도로 연비의 평균) 추가
mpg %>% mutate(mean_mpg= (cty+hwy)/2)

#suv 자동차들 중에서 시내연비와 고속도로 연비의 평균 상위5개 모델의
#제조사 모델명, 배기량, 시내연비 , 고속도로 연비, 평균
mpg %>% #mpg 데이터 프레임에서
  filter(class=='suv') %>% #자동차 종류가 suv인 부분집합
  mutate(mean_mpg= (cty+hwy)/2) %>% #파생변수 추가
  arrange(-mean_mpg) %>% #파생변수 내림차순 정렬
  head(n=5) %>% #위에서 5개
  select(manufacturer,model,displ,cty,hwy,mean_mpg)

#ifelse()함수
#ifelse(조건식, 조건을 만족할때 사용할 값,조건을 하지못할때 사용할 값)

numbers<-c(5,0,-1,100)
ifelse(numbers>0,'양수','양수아님')

ifelse(numbers>0,'positive',
       ifelse(numbers==0,'zero','negative'))



# csv_exam.csv 파일을 읽고 데이터 프레임을 생성
# 파생변수 average 추가 - 세과목 평균
# 파생변수 grade를 추가
#   grade = 'A', if 세과목 평균 >= 80
#   grade = 'B', if 세과목 평균 >= 60
#   grade = 'C', if 세과목 평균 < 60
exam <-read.csv(file = 'datasets/csv_exam.csv')
exam %>%
  mutate(average=(science+math+english)/3) %>% 
  mutate(grade=ifelse(average>=80,'A',ifelse(average>=60,'B','C')))

# mpg 데이터 프레임에서
# 파생변수 mean_mpg(시내 연비와 고속도로 연비의 평균) 추가
# 파생변수 grade_mpg 추가
#   grade_mpg = 'A', if mean_mpg >= 30
#   grade_mpg = 'B', if mean_mpg >= 20
#   grade_mpg = 'C', if mean_mpg >= 10
#   grade_mpg = 'D', if mean_mpg < 10
# manufacturer, model, cty, hwy, mean_mpg, grade_mpg를 출력
# mean_mpg 내림차순 정렬
mpg %>% 
  mutate(mean_mpg=(cty+hwy)/2) %>% 
  mutate(grade_mpg=ifelse( mean_mpg >= 30,'A',ifelse( mean_mpg >= 20,'B',ifelse( mean_mpg >= 10,'C','D')))) %>% 
  select( manufacturer, model, cty, hwy, mean_mpg, grade_mpg) %>% 
  arrange(mean_mpg)
