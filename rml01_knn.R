#kNN(k-Nearest Neighbors, k- 최근접 이웃) 알고리즘을 사용한

#붓꽃(iris) 품종 분류(예측)

#필요한 패키지 설치
install.packages('class')   #classification(분류) -> knn()함수 사용
install.packages('gmodels') #혼동(오차)행렬 - CrossTable()사용

#필요한 패키지 로드
library(tidyverse)
library(class)
library(gmodels)
search()

?datasets::iris #help(도움말) 페이지지

iris<- datasets::iris
head(iris)
str(iris)

# 데이터 탐색(exploration)
# 탐색적 데이터 분석(EDA: exploratory data analysis)

summary(iris) #변수가 factor 일경우 각레벨별로 몇개가있는지 세어준다(count).
#수치형 데이터 - 기술 통계량, factor 타입 데이터 -빈도수

#데이터의 분포- 상자그림, 히스토그램
#붓꽃 품종별 4개 특성(S.L,S.W,P.L, P.W)의 boxplot을 그려보세요.
ggplot(iris)+
  geom_boxplot(mapping = aes(x= Species,y=Sepal.Length))
ggplot(iris)+
  geom_boxplot(mapping = aes(x= Species,y=Sepal.Width))
ggplot(iris)+
  geom_boxplot(mapping = aes(x= Species,y=Petal.Length))
ggplot(iris)+
  geom_boxplot(mapping = aes(x= Species,y=Petal.Width))

#petal.Length~Petal.Width 산점도 그래프
ggplot(iris)+
  geom_point(mapping=aes(x=Petal.Width,y=Petal.Length,color=Species))

#kNN 알고리즘 적용 예측
# 1) iris 데이터 프레임을 특성(features)과 타겟(target)으로 분리.
# 2) 전체 데이터 셋을 훈련셋과 테스트셋으로 나눔. 
# 인덱스를 사용해서 데이터 프레임에서 원소를 선택하는 방법
# data_frame[row_index,column_index]
iris[1,1] #> 1번쨰 행, 1번쨰 열의 원소
iris[1:2,1] #>1~2번쨰 행, 1번째 열의 원소
iris[1,1:2] #> 1번째 행, 1~2번쨰 열의 원소 
#범위연산자 (start:end)를 사용할때, 시작값과 끝나는값을 생략하면 
#처음부터 마지막까지 의미
iris[1:3,1:4] #1~3번째 행, 1~4번째 열의 원소
iris[c(1,3,5),] #1,3,5 행의 모든 컬럼 
iris[c(1,3,5)] # 1,3,5 번째 Column의 모든 row m
#data_frame[column_index] = data_frame[,column_index]

#전체 데이터 셋을 단순히 순서대로 1~100행, 101~150 행으로 나누면
#virginica 품종은 훈련이 되지 않는 문제가 발생. ==> 훈련 데이터가 편향되었다고 한다. 
iris[1:50,] #> setosa
iris[51:100,] #>versicolor
iris[101:150,] #> virginica

# 층화(임의)추출(stratified sampling):
# 전체 데이터에서 훈련 셋이 편향되지 않도록, 
# 각 클래스에서 고르게 샘플들을 추출해서 훈련 셋을 만드는것. 

# 임의 추출(random sampling):
# 전체 데이터를 무작위로 섞어서 훈련 셋을 만드는것. 

sample(10)

#sample(n) :1~n까지 정수를 무작위로 섞어서 반환.

idx<- sample(150) #1~150 정수가 무작위로 섞인상태
train_row <- idx[1:120] #훈련셋으로 사용할 행 번호
test_row <- idx[121:150] # 테스트 셋으로 사용할 행 번호
train<- iris[train_row,] #훈련 셋
test<- iris[test_row,] #테스트 셋

table(train$Species)
table(test$Species)

# 훈련 셋/ 테스트 셋의 특성과 타겟을 분리 
train_features<- train[,1:4] #훈련 셋 특성들 (features)
train_target<- train[,5] # 훈련 셋 타겟 (target)

test_features<- test[,1:4] #테스트 셋 특성들
test_target<- test[,5] #테스트 셋 타겟

# knn 알고리즘에 훈련 셋 특성/타겟, 테스트 셋 특성을 적용해서 
# 테스트 셋의 타겟을 예측
test_predictions <- knn(train = train_features,
                        cl=train_target,
                        test= test_features,
                        k=3)
test_predictions #테스트 셋의 예측값 

# 테스트 셋의 예측값과 실제값을 비교
test_predictions == test_target

mean(test_predictions == test_target) # 정확도


