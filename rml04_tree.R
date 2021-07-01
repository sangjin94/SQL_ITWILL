# 의사결정 나무(decision tree) 알고리즘을 사용한 암 데이터 예측

# 필요한 패키지 로드
library(tidyverse)
library(C50)
library(gmodels)
search()

# 데이터 준비
url <- 'https://github.com/JakeOh/202105_itw_bd26/raw/main/datasets/wisc_bc_data.csv'
wisc_bc_data <- read.csv(url)
head(wisc_bc_data)

# diagnosis 변수를 factor 타입으로 변환
wisc_bc_data$diagnosis <- factor(wisc_bc_data$diagnosis,
                                 levels = c('B', 'M'),
                                 labels = c('Benign', 'Malignant'))
table(wisc_bc_data$diagnosis)

# 훈련 셋 80%, 테스트 셋 20%
tr_size <- round(569 * 0.8)

train_features <- wisc_bc_data[1:tr_size, 3:32]  # 훈련 특성
test_features <- wisc_bc_data[(tr_size + 1):569, 3:32]  # 테스트 특성

train_target <- wisc_bc_data[1:tr_size, 2]  # 훈련 레이블(타겟)
test_target <- wisc_bc_data[(tr_size + 1):569, 2]  # 테스트 레이블(타겟)

# decision tree 알고리즘 훈련
tree_clf <- C5.0(x = train_features, y = train_target)
summary(tree_clf)
plot(tree_clf)

# decision tree 알고리즘을 테스트 셋으로 평가
# 1) 테스트 셋의 예측값
test_predictions <- predict(tree_clf, test_features)
head(test_predictions)
# 2) 테스트 셋의 예측값과 실제값을 비교 -> 정확도
head(test_target)
mean(test_target == test_predictions)  #> 94.7%
# 오차(혼동) 행렬
CrossTable(x = test_target, y = test_predictions,
           prop.chisq = FALSE)
