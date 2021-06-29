# kNN(k-Nearest Neighbors, k-최근접 이웃) 알고리즘을 사용한 
# 붓꽃(iris) 품종 분류(예측)

# 필요한 패키지 설치
# install.packages('class')  # classification(분류) -> knn() 함수 사용
# install.packages('gmodels')  # 혼동(오차) 행렬 - CrossTable() 사용

# 필요한 패키지 로드
library(tidyverse)
library(class)
library(gmodels)
search()


# 1. 데이터 셋 준비 -----
?datasets::iris  # help(도움말) 페이지
iris <- datasets::iris  # datasets 패키지의 iris 데이터를 메모리에 복사.
head(iris)
tail(iris)
str(iris)


# 2. 데이터 탐색(exploration) -----
# 탐색적 데이터 분석(EDA: exploratory data analysis)
summary(iris)
#> 수치형 데이터 - 기술 통계량, factor 타입 데이터 - 빈도수

table(iris$Species)

# 데이터의 분포 - 상자 그림, 히스토그램
# 붓꽃 품종별 4개 특성(S.L, S.W, P.L, P.W)의 boxplot을 그려보세요.
ggplot(data = iris) +
  geom_boxplot(mapping = aes(x = Species, y = Sepal.Length))

ggplot(data = iris) +
  geom_boxplot(mapping = aes(x = Species, y = Sepal.Width))

ggplot(data = iris) +
  geom_boxplot(mapping = aes(x = Species, y = Petal.Length))

ggplot(data = iris) +
  geom_boxplot(mapping = aes(x = Species, y = Petal.Width))

# 변수 간의 상관 관계
# Petal.Length ~ Petal.Width 산점도 그래프.
# 점의 색깔을 붓꽃의 품종에 따라서 다르게 표현.
ggplot(data = iris) +
  geom_point(mapping = aes(x = Petal.Width, y = Petal.Length,
                           color = Species))


# 3. kNN 알고리즘 적용 예측 -----
# 1) iris 데이터 프레임을 특성(features)과 타겟(target)으로 분리.
# 2) 전체 데이터 셋을 훈련 셋과 테스트 셋으로 나눔.

# 인덱스를 사용해서 데이터 프레임에서 원소를 선택하는 방법
# data_frame[row_index, column_index]
iris[1, 1]  #> 1번째 행, 1번째 열의 원소
iris[1:2, 1]  #> 1~2번째 행, 1번째 열의 원소
iris[1, 1:2]  #> 1번째 행, 1~2번째 열의 원소
iris[1:3, 1:4]  #> 1~3번째 행, 1~4번째 열의 원소
iris[c(1, 3, 5), ]  #> 1, 3, 5번 행의 모든 열의 원소

# data_frame[column_index] = data_frame[, column_index]
iris[1]  #> 1번째 열의 모든 원소
iris[1:4]  #> 1~4번째 열의 모든 원소
iris[c(1, 3, 5)]  #> 1, 3, 5번째 열의 모든 원소

# 전체 데이터 셋을 단순히 순서대로 1~100행, 101~150행로 나누면
# virginica 품종은 훈련이 되지 않는 문제가 발생. ==> 훈련 데이터 편향
iris[1:50, ]  #> setosa
iris[51:100, ]  #> versicolor
iris[101:150, ]  #> virginica

# 층화 (임의) 추출(stratified sampling):
# 전체 데이터에서 훈련 셋이 편향되지 않도록, 
# 각 클래스에서 고르게 샘플들을 추출해서 훈련 셋을 만드는 것.

# 임의 추출(random sampling):
# 전체 데이터를 무작위로 섞어서 훈련 셋을 만드는 것.

idx <- sample(150)
# sample(n): 1 ~ n까지 정수를 무작위로 섞어서 반환.
idx  # 1~150 정수들이 무작위로 섞인 상태
train_row <- idx[1:120]  # 훈련 셋으로 사용할 행 번호
test_row <- idx[121:150] # 테스트 셋으로 사용할 행 번호
train <- iris[train_row, ]  # 훈련 셋
test <- iris[test_row, ]  # 테스트 셋

table(train$Species)
table(test$Species)

# 훈련 셋/테스트 셋의 특성과 타겟을 분리
train_features <- train[, 1:4]  # 훈련 셋 특성들(features)
train_target <- train[, 5]  # 훈련 셋 타겟(target)
head(train_features)
head(train_target)

test_features <- test[, 1:4]  # 테스트 셋 특성들
test_target <- test[, 5]  # 테스트 셋 타겟

# kNN 알고리즘에 훈련 셋 특성/타겟, 테스트 셋 특성을 적용해서
# 테스트 셋의 타겟을 예측
test_predictions <- knn(train = train_features,
                        cl = train_target,
                        test = test_features,
                        k = 3)
test_predictions  # 테스트 셋의 예측값

# 테스트 셋의 예측값과 실젯값을 비교
test_predictions == test_target
sum(test_predictions == test_target)  
#> TRUE(예측값과 실젯값이 일치한 것들)의 개수
mean(test_predictions == test_target)  
#> 정확도 = 예측이 맞은 개수 / 전체 개수

# k = 11인 경우 정확도
test_predictions2 <- knn(train = train_features,
                         cl = train_target,
                         test = test_features,
                         k = 11)
mean(test_predictions2 == test_target)

# Confusion Matrix(오차 행렬, 혼동 행렬, 혼돈 행렬)
CrossTable(x = test_target,       # 실젯값
           y = test_predictions,  # 예측값
           prop.chisq = FALSE)

CrossTable(x = test_target,
           y = test_predictions2,
           prop.chisq = FALSE)

# 특성 스케일링: 정규화(normalization), 표준화(standardization)
# 변수(특성)들마다 다른 단위와 크기를 비슷한 스케일로 변환하는 것.
# 거리를 계산할 때 모든 특성들이 비슷한 영향을 미칠 수 있도록 하기 위해서.
# 정규화(normalization):
#   변수의 최솟값을 0, 최댓값을 1로 변환.
#   모든 값들이 0 ~ 1 범위의 값이 되도록 변환.
# 표준화(standardization): z-score 표준화
#   변수의 평균이 0, 표준편차가 1이 되도록 변환.

v1 <- 1:5
v1

# 정규화
v1_min <- min(v1)
v1_min

v1_max <- max(v1)
v1_max

v1_normalized <- (v1 - v1_min) / (v1_max - v1_min)
v1_normalized

v2 <- seq(10, 50, 10)
v2

v2_normalized <- (v2 - min(v2)) / (max(v2) - min(v2))
v2_normalized

# 표준화
v1

v1_mean <- mean(v1)
v1_mean

v1_std <- sd(v1)
v1_std

v1_standardized <- (v1 - v1_mean) / v1_std
v1_standardized
mean(v1_standardized)
sd(v1_standardized)

v2
v2_standardized <- (v2 - mean(v2)) / sd(v2)
v2_standardized
mean(v2_standardized)
sd(v2_standardized)

# iris 데이터 셋을 표준화
# iris의 특성 4개에 모두 같은 함수를 적용

# R에서 함수 작성 방법
# 함수이름 <- function(파라미터) {함수의 기능을 작성}
standardize <- function(x) {
  return((x - mean(x)) / sd(x))
}

standardize(v1)
standardize(v2)

df <- data.frame(v1 = seq(1, 5, 1),
                 v2 = seq(10, 50, 10))
df

# lapply(데이터프레임, 함수): 
#   데이터 프레임의 모든 컬럼(변수)에 함수를 적용한 결과를 리턴.
lapply(df, standardize)
df_standardized <- data.frame(lapply(df, standardize))
df_standardized

# iris 데이터 셋을 특성과 타겟으로 분리
features <- iris[, 1:4]
target <- iris[, 5]

head(features)
head(target)

features_standardized <- data.frame(lapply(features, standardize))
head(features_standardized)
summary(features_standardized)


# R의 데이터 타입
# vector: 한가지 타입의 데이터 여러개를 1차원으로 저장하는 자료 구조.
num_vector <- c(1, 2, 10, 20)  # 숫자 벡터
char_vector <- c('a', 'b', '가', '나')  # 문자열 벡터

# matrix: 한가지 타입의 데이터 여러개를 2차원으로 저장하는 자료 구조.
num_mat <- matrix(data = 1:12, nrow = 3, ncol = 4)
num_mat

# array: 한가지 타입의 데이터 여러개를 3차원 이상으로 저장하는 자료 구조.
# data frame: 각각의 열(column)마다 다른 타입의 데이터를 저장할 수 있는
# 2차원 모양의 자료 구조.
df <- data.frame(v1 = c(1, 2, 3),
                 v2 = c('a', 'b', 'c'))
df
df$v1

# list: key-value 쌍으로 데이터 저장
my_list <- list(v1 = 100, 
                v2 = c(1, 3, 5),
                v3 = df)
my_list


df <- data.frame(v1 = 1:5, v2 = seq(10, 50, 10))
df
# lapply, rapply 비교
result <- lapply(df, standardize)
result  # 리스트
result$v1
result$v2

result2 <- rapply(df, standardize)
result2

