#복지 패널 데이터 분석 -직종, 성별, 월소득

#라이브러리 로드
library(tidyverse)
library(ggthemes)

# Rdata 파일을 로드
load(file = 'datasets/koweps.Rdata')

head(welfare)

#가장 많은 사람이 종사하는 직종 상위 10개 이름과 종사자 수
#시각화

top_job<-
welfare %>%
  filter(!is.na(job)) %>% #job이 NA가 아닌 데이터들을 선택
  count(job) %>%  #group_by(job) %>% summarise(n=n(): 직종별 종)
  arrange(-n) %>% #변수 n값의 내림차순 정렬
  head(n=10) #상위 10개 행 선택

ggplot(top_job)+geom_col(mapping = aes(y=reorder(job,n),x=n,fill=job))

#남성이 가장 많이 종사하는 직종 상위 10개 직종이름과 종사자 수
#시각화
male_job<-
welfare %>%filter(!is.na(job)&gender=='Male') %>% count(job) %>% arrange(-n) %>% head(n=10)
ggplot(male_job)+geom_col(mapping = aes(y=reorder(job,n),x=n,fill=job))

#여성이 가장 많이 종사하는 직종 상위 10개 직종이름과 종사자 수
#시각화
female_job<-
  welfare %>%filter(!is.na(job)&gender=='Female') %>% count(job) %>% arrange(-n) %>% head(n=10)
ggplot(female_job)+geom_col(mapping = aes(y=reorder(job,n),x=n,fill=job))
#종사자 수가 성별로 차이가 많은 직종 상위 10개

#1)여성 숫자 -남성숫자 내림차순 정렬상위 10개
#2)남성 숫자 -여성숫자 내림차순 정렬상위 10개
Job_gender<-
welfare %>% 
  filter(!is.na(job)) %>% #직업이있는 데이터만 선택
  count(job,gender) %>% #job별, gender별 종사자 수
  pivot_wider(names_from = gender,values_from = n) %>% 
  #names_from: 컬럼 이름으로 사용할 값이 있는 변수
  #values_from: pivot 테이블에 채워질 값들이 있는 변수
  replace(is.na(.),0) %>%  #pivot 테이블의 모든 NA를 0으로 바꾸겠다.
  mutate(diff=Female-Male)# 파생변수(남녀 종사자 수 차이)추가 
Job_gender %>%   
arrange(-diff) %>% head(n=10) 
###############################################################################         
#여성 종사자 비율이 높은 직종 상위 10개
Job_gender %>% 
  mutate(female_ratio = Female/(Female+Male)) %>% 
  arrange(-female_ratio) %>%  head(n=10)
#남성 종사자 비율이 높은 직종 상위 10개
#job_gender 데이터 프레임에 파생변수 추가
#female_ratio= female/(female+male)
Job_gender %>% 
  mutate(male_ratio = Male/(Female+Male)) %>% 
  arrange(-male_ratio) %>%  head(n=10)

#직종별 평균 월소득 상위10개 직종 이름, 시각화
job_income_top<-
welfare %>% 
  filter(!is.na(job)&!is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income=mean(income)) %>% arrange(-mean_income) %>% head(n=10)
ggplot(job_income_top)+
  geom_col(mapping = aes(y=reorder(job,mean_income),x=mean_income,fill=job))
#직종별 평균 월소득 하위10개 직종 이름, 시각화
job_income_bot<-
welfare %>% 
  filter(!is.na(job)&!is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income=mean(income)) %>% arrange(mean_income) %>% head(n=10)
ggplot(job_income_bot)+
  geom_col(mapping = aes(y=reorder(job,mean_income),x=mean_income,fill=job))
#직종별 종사자 수 20명 이상인 직종에서 평균 월소득 상위 하위10개
job_20<-
welfare %>% 
  filter(!is.na(job)&!is.na(income)) %>%  
  group_by(job) %>% count() %>% filter(n>20)
#상위 10개
left_join(job_20,welfare,by="job") %>%
  filter(!is.na(income)) %>% 
  group_by(job) %>% summarise(mean_income=mean(income)) %>% arrange(-mean_income) %>% head(n=10)
#하위 10개
left_join(job_20,welfare,by="job") %>%
  filter(!is.na(income)) %>% 
  group_by(job) %>% summarise(mean_income=mean(income)) %>% arrange(mean_income)%>% head(n=10)
#남성 평균 월소득 상위 10개 직종
male_income_avg<-
welfare %>%filter(!is.na(job)&!is.na(income)&gender=='Male') %>% 
  group_by(job) %>% 
  summarise(mean_income=mean(income),n=n()) %>% 
  arrange(-mean_income)
male_income_avg %>% head(n=10)
#여성 평균 월소득 상위 10개 직종
female_income_avg<-
welfare %>%filter(!is.na(job)&!is.na(income)&gender=='Female') %>% 
  group_by(job) %>% 
  summarise(mean_income=mean(income),n=n()) %>%
  arrange(-mean_income)
female_income_avg %>% head(n=10)
#남성평균 월소득 상위 10개직종. 직종별 남성인구가 10명이상인 경우.
male_income_avg %>% filter(n>10) %>% head(n=10)
#여성평균 월소득 상위 10개직종. 직종별 여성인구가 10명이상인 경우.
female_income_avg %>% filter(n>10) %>% head(n=10)



