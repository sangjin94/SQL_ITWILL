#복지 패널 데이터 분석 -지역 별 통계 
#필요한 라이브러리 로드
library(tidyverse)
search()

load(file = 'datasets/koweps.Rdata')

head(welfare)

#지역별 인구수, 시각화
region_pop<-
  welfare %>% group_by(region_code) %>% count()
ggplot(region_pop)+
  geom_col(mapping = aes(x=reorder(region_code,n),y=n,fill=region_code))
#지역별 성별 인구수, 시각화(성별 인구수, 성비 )
region_gender_pop <-welfare %>% group_by(region_code,gender) %>% count()
ggplot(region_gender_pop)+geom_col(mapping = aes(x=region_code,y=n,fill=gender),position = 'dodge') #두개의 막대가 옆으로 나란히 배치. 인구수를 표현
ggplot(region_gender_pop)+geom_col(mapping = aes(x=region_code,y=n,fill=gender),position = 'stack') #stack 은 기본값.

ggplot(region_gender_pop)+geom_col(mapping = aes(x=region_code,y=n,fill=gender),position = 'fill') #모든 막대의 길이가 1로 동일하다
#1을 기준으로 비율을 나타내줌. 성비를 색깔로 표현
region_gender_pop %>% 
  pivot_wider(names_from = gender,values_from = n) %>% 
  mutate(Female_Ratio=Female/(Male+Female)) #성비의 수치를 표현하기위해서는 피봇을 만든후
#변수를 새로 생성해주면 된다. 


#지역별,연령대별 인구수 -> pivot
welfare %>% 
  group_by(region_code,age_range) %>%
  count() %>%
  pivot_wider(names_from = age_range,values_from = n)
ggplot(data = welfare)+
  geom_bar(mapping = aes(y=region_code,fill=age_range),position ='fill')
#지역별,연령대별,성별인구수 -> 지역별 통계가 행(row)가 되도록 pivot
welfare %>% 
  group_by(region_code,age_range,gender) %>% 
  count() %>% 
  pivot_wider(names_from =c(age_range,gender),values_from = n) #두개의 변수를 가지고서 컬럼이름을 만들기 위해서 C()을 사용해야함

#welfare 데이터 프레임에 ages 파생변수를 추가
# ages='young',if age<30
# ages='middle', if age<60
# ages='old', if age>=60 
# 파생변수 ages 를 factor로 변환
welfare$ages<- ifelse(welfare$age<30,'young',
                      ifelse(welfare$age<60,'middle','old'))

welfare$ages<-factor(x=welfare$ages,
       levels =c('young','middle','old'))
#level과 동일한 label을 사용하는 경우 labels 파라미터는 생략.

table(welfare$ages)

#지역별, ages 별 인구수 테이블
welfare %>% group_by(region_code,ages) %>% count() %>% 
ggplot()+ geom_col(mapping = aes(y=region_code,x=n,fill=ages),position = 'fill')
# 지역별, ages의 비율 막대 그래프 

#지역별 평균 월소득, 시각화
welfare %>% filter(!is.na(income)) %>% 
  group_by(region_code) %>%
  summarise(mean_region=mean(income)) %>% 
  ggplot()+geom_col(mapping = aes(y=reorder(region_code,mean_region),x=mean_region,fill=region_code))

#지역별 ages별 평균 월소득, 시각화
welfare %>%
  filter(!is.na(income)) %>% 
  group_by(region_code,ages) %>% 
  summarise(mean_income=mean(income)) %>% 
ggplot()+geom_col(mapping = aes(x=region_code,y=mean_income,fill=ages),position = 'dodge')

#지역별 성별 평균 월소득 ,시각화
welfare %>%
  filter(!is.na(income)) %>% 
  group_by(region_code,gender) %>% 
  summarise(mean_income=mean(income)) %>% 
  ggplot()+geom_col(mapping = aes(x=region_code,y=mean_income,fill=gender),position = 'dodge')
table(welfare$job_code)
#지역별 직종별 평균 월소득
welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(region_code,job) %>% 
  summarise(mean_income=mean(income))
#서울지역에서 평균 월소득 상위 5개 직종
welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(region_code,job) %>% 
  summarise(mean_income=mean(income)) %>% 
  filter(region_code=='서울') %>% 
  arrange(-mean_income) %>% head(n=5)
#부산/경남/울산 지역에서 평균 월소득 상위 5개 직종
welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(region_code,job) %>% 
  summarise(mean_income=mean(income)) %>% 
  filter(region_code=='부산/경남/울산') %>% 
  arrange(-mean_income) %>% head(n=5)
#강원/충북 지역에서 평균 월소득 상위 5개 직종
welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(region_code,job) %>% 
  summarise(mean_income=mean(income)) %>% 
  filter(region_code=='강원/충북') %>% 
  arrange(-mean_income) %>% head(n=5)
