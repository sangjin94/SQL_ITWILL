# 2015년 한국 복지 패널 데이터 분석

#필요한 패키지 설치
#haven: spss,stats,sas통계 프로그램에서 사용하는 파일을
#R에서 사용(read)할 때 필요한 패키지
install.packages('haven')

#필요한 패키지를 메모리에 로드.
library(tidyverse)
library(haven)
library(readxl)
search()

#koweps_hpc10_2015_beta1.sav 파일:
# SPSS 프로그램에서 데이터를 저장한 파일
#koweps_codebook.xlsx 파일: sav파일의 변수들을 설명한 파일.
#성별, 연령,직종, 월수입 등을 분석

#파일을 읽어서 데이터 프레임 생성

koweps <- read_sav(file = 'datasets/Koweps_hpc10_2015_beta1.sav')
str(koweps)

#변수 (컬럼) 이름 변경 -> 관심있는 변수만 선택
#dplyr::rename(df,new_variable_name = old_variable_name)

#h10_g3--> gender(성별)
#h10_g4--> birth(태어난 연도)
#h10_eco9> job_code(직종 코드)
#h10_reg7> region_code(전국을 7개 권역으로 나눈 지역 코드)
#p1002_8aq1> income(월소득)

welfare <-koweps %>% 
  rename(gender=h10_g3,
         birth=h10_g4,
         job_code=h10_eco9,
         region_code=h10_reg7,
         income=p1002_8aq1) %>% 
  select(gender,birth,job_code,region_code,income)
#데이터 일부 확인
head(welfare)
tail(welfare)

#성별 (gender) 인구수
table(welfare$gender) #> 분할표
count(welfare,gender) #> 데이터 프레임

#factor 타입: 범주(카테고리)를 표현하는 변수
welfare$gender<-factor(welfare$gender, #factor 타입으로 변환할 객체
                       levels = c(1,2), #변환할 객체가 가지고 있는 값들
                       labels = c('Male','Female')) #각각의 값에 붙여줄 레이블 
#welfare$gender<- ifelse(welfare$gender==1,'Male','Female')
#>숫자 타입 변수를 문자열 타입변수로 변환해도 된다.

table(welfare$gender)
str(welfare)

#성별 시각화
welfare%>%ggplot()+
  geom_bar(mapping =
             aes(x=gender,fill=gender))

gender_count<-count(welfare,gender) 
gender_count %>%   ggplot()+geom_col(mapping = 
                      aes(x=gender,y=n,fill=gender))
#pie 차트 사용
ggplot(data=gender_count)+geom_col(mapping = aes(x='',y=n,fill=gender))+
  coord_polar(theta = 'y')

#소득(income) 탐색
summary(welfare$income)
#>최솟값, 1사분위값, 중앙값, 평균, 3사분위값, 최댓값, NA개수 출력

#코드북 엑셀 파일을 보면, 소득의 정상 범위 1~9998
#1미만, 9998초과 인 소득값을 NA로 변경
welfare$income <-ifelse(welfare$income < 1,NA,
                        ifelse(welfare$income>9998,NA,
                               welfare$income))
#위를 | 사용하면
welfare$income <-ifelse(welfare$income < 1|welfare$income>9998,NA,welfare$income)
                        
#소득 시각화 ->> box plot, histogram

ggplot(data = welfare)+
  geom_boxplot(mapping = aes(y=income))
#>히스토그램과 비교할 때 좋음.
#>right-skewed(오른쪽 치우침) 분포-오른쪽으로 꼬리가 긴 분포
#>첨도 : 그래프가 얼마나 뾰족하나? 왜도 : 그래프가 어디로 치우쳐져있나? 
ggplot(data = welfare)+
  geom_histogram(mapping = aes(x=income),bins = 30)
head(welfare)
str(welfare)

#태어난 연도(birth) 탐색
summary(welfare$birth)

#지역코드(region_code) 탐색
summary(welfare$region_code)
table(welfare$region_code)

#region_code 변수를 facor로 변환
#labels
#1: 서울
#2: 수도권(인천/경기)
#3: 부산/경남/울산
#4: 대구/경북
#5: 대전/충남
#6: 강원/충북
#7: 광주/전남/전북/제주도
welfare$region_code<- factor(welfare$region_code,levels = c(1,2,3,4,5,6,7), #1:7 seq(1,7)
                             labels = c('서울',
                                        '수도권(인천/경기)',
                                        '부산/경남/울산',
                                        '대구/경북',
                                        '대전/충남',
                                        '강원/충북',
                                        '광주/전남/전북/제주도'))
table(welfare$region_code)
welfare %>% 
ggplot()+geom_bar(mapping = aes(y=region_code))

#직종코드 (job_code) 탐색
summary(welfare$job_code)
table(welfare$job_code)
library(readxl)
#koweps_codebook.xlsx 파일의 두번째 시트('직종 코드')를 읽어서 데이터 프레임을 생성
#welfare 데이터 프레임과 위에서 생성한 데이터 프레임을 left join
koweps_job <- read_xlsx(path = 'datasets/Koweps_Codebook.xlsx',sheet = '직종 코드')
koweps_job
welfare<- left_join(welfare,koweps_job, by = c('job_code'='code_job'))

#NA이면 true(1) NA가 아니면 FALSE(0)이다. 
sum(is.na(welfare$job_code)) #Job_code의 NA개수
sum(is.na(welfare$job)) # job의 NA개수

#현재까지 작업된 내용들 (Global Environment에 생성된 객체들)을 
#파일에 저장 -> 나중에 파일에 저장 된 내용을 메모리로 로드 할 수 있음.
save(koweps,welfare,file = 'datasets/koweps.Rdata')
