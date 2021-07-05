# SVM 알고리즘을 사용한 의료비 예측(회귀)

#필요한 패키지 로드
library(tidyverse) # 데이터 가공 , 전처리, 시각화
library(kernlab) # ksvm () 서포트 벡터머신 패키지
library(ModelMetrics) # MSE(), rmse() , mae()

search()

#데이터 준비
url<- 'https://github.com/JakeOh/202105_itw_bd26/raw/main/datasets/insurance.csv'
insurance_df<-read.csv(url)
head(insurance_df)

# ksvm() 함수에서는 문자열 타입의 변수들을 n차원 공간 상의 좌표로
# 표현할 수 있도록 숫자 타입 변수로 변환을 자동으로 수행함. 

# 훈련 셋, 테스트 셋 분리 (8:2 비율로 분리)
n<- nrow(insurance_df)
tr_size <- round(n*0.8)
train_set <- insurance_df[1:tr_size,]
test_set<- insurance_df[(tr_size+1):n,]

# 훈련 셋과 테스트 셋에서 타겟의 분포가 비슷한 지. 
summary(train_set$expenses)
summary(test_set$expenses)

#SVM 모델을 훈련 
svm_reg <- ksvm(x=expenses~.,data=train_set,
                kernel='vanilladot') # 선형 커널 함수
svm_reg # 회귀문제에서 목적함수는 오차들의 평균이 가장 적어지도록
# 오차를 계산해주는 함수

# 훈련 셋에서 평가 
train_predictions<- predict(svm_reg,train_set)
rmse(train_set$expenses,train_predictions) # >6667.049

# 테스트 셋에서 평가
test_predictions<- predict(svm_reg,test_set)
rmse(test_set$expenses,test_predictions) # 6577.713

#ksvm() 함수에서 kernel= 'rbfdot'으로 변경하고 결과 비교
svm_reg2 <- ksvm(x=expenses~., data=train_set,
                 kernel='rbfdot')
train_predictions2<- predict(svm_reg2,train_set)
rmse(train_set$expenses,train_predictions2) #[1] 4625.198
test_predictions2<- predict(svm_reg2,test_set)
rmse(test_set$expenses,test_predictions2) #[2] 5092.987
