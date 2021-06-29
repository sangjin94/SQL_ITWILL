# 의사결정 나무 (decision tree) 알고리즘을 사용한 붓꽃 품종 예측

# 패키지 설치- decision tree 알고리즘을 구현한 패키지 
# install.packages('C50')

#패키지 로드
library(tidyverse)
library(C50)
library(gmodels)
search()

#데이터 준비 
iris<- datasets::iris
head(iris)

#features, target 분리

features <- iris[,1:4]
target<- iris[,5]

# 훈련 셋 80%(120 obs.), 테스트 셋 20%(30 obs)
idx<- sample(150)
train_idx<- idx[1:120] # 120개 랜덤 인덱스
test_idx<- idx[121:150] # 30개의 랜덤 인덱스

train_features<- features[train_idx,]
test_features<- features[test_idx,]

train_target<- target[train_idx] #훈련 레이블 
test_target<- target[test_idx] #테스트 레이블

#훈련/테스트 셋의 레이블이 편향되지 않았는 지 확인
table(train_target)
table(test_target)

# 머신 러닝 알고리즘 훈련- 의사결정 나무 분류기 (decision tree)
tree_clf <- C5.0(x= train_features, #x= 훈련 특성
                 y= train_target)  #y= 훈련 타겟
tree_clf
summary(tree_clf) # decision tree 훈련 결과 요약
plot(tree_clf) #decision tree 훈련 결과 시각화

# 테스트 셋에서의 정확도, 오차행렬 계산 -> 평가
test_predictions<- predict(tree_clf,  # 1번쨰 argument는 훈련이 끝난 머신러닝 모델
                           test_features) #2번째 argument는 테스트 특성 
summary(test_predictions)
mean(test_predictions==test_target)
CrossTable(x=test_target,
           y=test_predictions,
           prop.chisq = FALSE)
# 훈련셋의 정확도가 테스트셋의 정확도보다 높을경우 : 과대적합.
# 테스트셋의 정확도가 훈련셋의 정확도보다 높을경우 : 과소적합
