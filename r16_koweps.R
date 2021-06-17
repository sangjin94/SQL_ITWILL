# 복지 패널 데이터 분석

library(tidyverse)

#Rdata 파일을 메모리 (Global Env.)에 로드(load)
load(file = 'datesets/koweps.Rdata')

#로드한 데이터 프레임 확인
head(koweps)
head(welfare)

#welfare 데이터 프레임 사용
welfare
#성별에 따른 월소득 격차가 있는지?
#성별 월소득의 평균 계산, 시각화
#NA가 껴있으면 월소득 평균은 NA가 됨.
welfare %>% 
  group_by(gender) %>% 
  summarise(mean_income=mean(income,na.rm=T)) %>% #na.rm 파라미터 : na들을 제거하고 계산할지 말지
  ggplot()+geom_col(mapping = aes(y=mean_income,x=gender,fill=gender))

#  연령대에 따라서 소득의 변화가 있을까?
# 나이(age,2015년도 기준 나이) 변수 추가
welfare$age<- 2015 - welfare$birth
welfare
#나이별 인구수 
welfare %>% group_by(age) %>% count()
table(welfare$age)
ggplot(data = welfare)+geom_bar(mapping = aes(x=age))
#나이별 월소득 평균
welfare %>% 
  group_by(age) %>% 
  summarise(mean_income=mean(income,na.rm=T))
#NaN: Not a number          

income_by_age<- welfare %>% 
  filter(!is.na(income)) %>%  #< income이 na가 아닌 사람들을
  group_by(age) %>%  #age로 그룹을 나누고
  summarise(mean_income=mean(income)) #연령별 소득평균

ggplot(data=income_by_age)+geom_line(mapping = aes(x=age,y=mean_income))

#평균 월소득이 가장 높은 나이를 찾으세요.
max_income<- income_by_age %>% arrange((-mean_income)) %>%  head(n=1)
#나이별 월소득 line graph에 평균 월소득 최댓값을 함께 표시하세요.
ggplot(data=income_by_age)+
  geom_line(mapping = aes(x=age,y=mean_income))+
   geom_vline(xintercept = 52,color='red',linetype='dashed')+
geom_hline(yintercept =319,color='darkgreen',linetype='dotted')
#vline: vertical line(수직선)
#xintercept: x절편. 직선이 x축과 만나는 좌표.
#hline: horizontal line(수평선)
#yintercept: y절편. 직선이 y축과 만나는 좌표.

  
#age별 gender별 월소득 평균을 계산하고 line graph를 그리세요.
#gender 별로 선의 색깔이 다르게 표현하세요.
age_gender_income<-
welfare %>% 
  filter(!is.na(income)) %>%
  group_by(age, gender) %>%
  summarise(mean_income=mean(income))

ggplot(data = age_gender_income)+geom_line(mapping =aes(x=age,y=mean_income,color=gender))

#연령대별 인구수 -> 연령대별 평균 월소득 -> 연령대별 성별 평균 월소득
#연령대 파생변수 추가(age_range)
#20-(age10), 20~29(age20),30~39(age30),40~49(age40)
#50~59(age50), 60~69(age60),70~79(age70),80+(age80)
welfare$age_range<- ifelse(welfare$age<20,'age10',
                           ifelse(welfare$age<30,'age20',
                                  ifelse(welfare$age<40,'age30',
                                         ifelse(welfare$age<50,'age40',
                                                ifelse(welfare$age<60,'age50',
                                                       ifelse(welfare$age<70,'age60',
                                                              ifelse(welfare$age<80,'age70','age80')))))))
table(welfare$age_range)                                                                    
income_by_agerange<- welfare %>%
  group_by(age_range) %>%
  summarise(mean_income=(mean(income,na.rm=T))) 
#혹은
income_by_agerange<- welfare %>%
  filter(!is.na(income)) %>% 
  group_by(age_range) %>%
  summarise(mean_income=(mean(income))) 
#그래프 그리기
ggplot(data=income_by_agerange)+
  geom_col(mapping = aes(x=age_range,y=mean_income))

income_by_agerange_gender<- welfare %>%
  filter(!is.na(income)) %>% 
  group_by(age_range,gender) %>%
  summarise(mean_income=(mean(income))) 

ggplot(income_by_agerange_gender)+  geom_col(mapping = aes(x=age_range,y=mean_income,fill=gender),position = 'dodge')

save(koweps,welfare,file = 'datesets/koweps2.Rdata')
