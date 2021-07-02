# Decision Tree 알고리즘을 사용한 의료비 예측 (회귀)

#필요한 패키지 설치, 로드
#install.packages('rpart') #regression tree 알고리즘 
#install.packages('rpart.plot') # regression tree 시각화 
library(rpart)
library(tidyverse)
library(rpart.plot)  
library(ModelMetrics)

#데이터 준비 - 의료비 
url<- 'https://github.com/JakeOh/202105_itw_bd26/raw/main/datasets/insurance.csv'

insurance_df<- read.csv(url)
head(insurance_df)
str(insurance_df)

#훈련 셋(80%) ,테스트 셋 (20%) 분리
n<- nrow(insurance_df) # 전체 데이터 개수 
tr_size <- round(n*0.8) # 훈련 셋 데이터 개수
train_set<- insurance_df[1:tr_size,]
test_set <- insurance_df[(tr_size+1):n,]
# 훈련셋과 테스트 셋이 random 하게 (무작위로) 나눠져 잇는지 확인
summary(train_set$expenses)
summary(test_set$expenses)

# 회귀 의사결정 나무 알고리즘 훈련
# rpart: recursive partitioning
tree_reg <- rpart(formula = expenses ~ ., data = train_set)
summary(tree_reg)
tree_reg

# 훈련 셋의 expenses 평균
mean(train_set$expenses)
# 훈련 셋의 smoker 별 expenses 평균
train_set %>% 
  group_by(smoker) %>% 
  summarise(mean(expenses))

# 회귀 의사결정 나무 시각화
rpart.plot(tree_reg)

# regression tree 정보 출력
summary(tree_reg)
mean((train_set$expenses-13214.13)**2)

# 훈련 셋에서 평가 점수 - RMSE(root mean squared error)
train_predictions <- predict(tree_reg,train_set)
head(train_predictions)
rmse(train_set$expenses,train_predictions)

# 테스트 셋 예측값
test_predictions<- predict(tree_reg,test_set)
rmse(test_set$expenses,test_predictions)
