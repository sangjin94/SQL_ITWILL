#wisc_bc_data.csv: 위스콘신 대학 유방암 데이터 프레임
#kNN 알고리즘을 사용해서 암 유무를 예측

#필요한 패키지 로드
library(tidyverse) #데이터 전처리, 가공, 시각화, ...
library(class) #classification: knn함수
library(gmodels) # CrossTable() 함수 - 오차(혼동) 행렬

search()

#데이터 준비
file_path<-('https://github.com/JakeOh/202105_itw_bd26/raw/main/datasets/wisc_bc_data.csv')
wisc_bc_date<- read.csv(file_path)
head(wisc_bc_date)
tail(wisc_bc_date)
str(wisc_bc_date)   # diagnosis 가 LABEL, TARGET 이다. 
summary(wisc_bc_date) # 기술 통계량 요약

# diagnosis 변수에 있는 값들
table(wisc_bc_date$diagnosis)

#> B(Benign): 양성 종양(암이 아님.)
#> M(Malignant): 악성 종양(암이다.)

#diagnosis 변수를 factor 타입으로 변환 (factor 타입을 생성)

wisc_bc_date$diagnosis <- factor(wisc_bc_date$diagnosis,
                                 levels = c('B','M'),
                                 labels=c('Benign','Malignant'))
#위의 명령어와 as.factor 와의 차이 = levels,labels 를 설정하지못함.
# as.뭐시기() 종류의 함수들: 데이터의 타입을 변환하는거임 , 생성하는게아님
# as.character(),as.integer(),as.numeric(),as.date.frame(),as.factor()

# 데이터 셋을 특성(features)과 타겟(target)으로 분리
# id(환자 아이디)는 ML에서 사용되면 안되기 때문에 제거
head(wisc_bc_date)
features<- wisc_bc_date[,3:32] # 모든 행들, 3~32번쨰 열들
target<-wisc_bc_date[,2] #모든 행들, 2번째 열

# 데이터 셋의 80%를 훈련 셋, 20%를 테스트 셋으로 사용
# target이 정렬된 상태가 아니기 때문에, random sampling(임의 추출)을 사용하지 않고,
# 순서대로 분리해도 괜찮음. 이미 데이터들이 랜덤하게 섞여있음.

tr_size<-round(569*0.8) #훈련 셋의 관찰값 개수
#훈련/테스트 특성들
train_set <- features[1:tr_size,] # 1~455 행
test_set<-features[(tr_size+1):569,]# 456~569 행

#훈련/테스트 레이블(타겟)
train_target <- target[1:tr_size]
test_target<-target[(tr_size+1):569]

#훈련/테스트 레이블이 편향되지 않고 임의로 섞여 있는 지 확인
table(train_target)
prop.table(table(train_target))

table(test_target)
prop.table(table(test_target))

#knn 알고리즘 적용 (k=1 일때)
test_predictions<- knn(train = train_set,
                       cl=train_target,
                       test = test_set,
                       k= 1)

#knn 알고리즘 평가
mean(test_predictions==test_target) # 94.7% 의 정확도를 나타냄
CrossTable(x=test_target, #오차행렬 만들어봐서 어느부분에서 틀렸는지 확인
           y=test_predictions,
           prop.chisq = FALSE)

# 다른 k값의 결과와 비교 ( k=3 일때)
test_predictions<- knn(train = train_set,
                       cl=train_target,
                       test = test_set,
                       k= 3)
mean(test_predictions==test_target) # 95.6% 의 정확도를 나타냄
CrossTable(x=test_target, 
           y=test_predictions,
           prop.chisq = FALSE)
# 다른 k값의 결과와 비교 ( k=11 일때)
test_predictions<- knn(train = train_set,
                       cl=train_target,
                       test = test_set,
                       k= 11)
mean(test_predictions==test_target) # 93.8% 의 정확도를 나타냄
CrossTable(x=test_target, 
           y=test_predictions,
           prop.chisq = FALSE)

# 모든 특성들을 표준화 (standardization) 후 knn 알고리즘을 적용
# 원래는 train_set 에서만 평균과 표준편차를 구한 후 표준화를 진행후 계산해야한다.
# 원래목적이 test_set을 예측하기위함이기 때문.
standardize<- function(x){
  #x: 숫자 벡터
  mean<-mean(x) #숫자 벡터의 평균을 계산
  std<-sd(x) #숫자 벡터의 표준편차를 계산
  return((x-mean)/std)} #표준화한 결과를 반환환

features_standardized<- as.data.frame(lapply(features,standardize))
summary(features_standardized) #모든 평균이 0이됨

#표준화된 특성들을 사용해서 k=3,k=11 결과 비교
train_set_std<-features_standardized[1:tr_size,] # 표준화된 훈련 셋
test_set_std<-features_standardized[(tr_size+1):569,] #표준화된 테스트 셋

test_predictions<- knn(train = train_set_std,
                       cl=train_target,
                       test = test_set_std,
                       k=3)   #k=3
mean(test_predictions==test_target) # 96.5 % 의 정확도
CrossTable(x=test_target, 
           y=test_predictions,
           prop.chisq = FALSE)

test_predictions<- knn(train = train_set_std,
                       cl=train_target,
                       test = test_set_std,
                       k=11)  #k=11
mean(test_predictions==test_target) # 95.6 % 의 정확도
CrossTable(x=test_target, 
           y=test_predictions,
           prop.chisq = FALSE)
