# SVM(Support Vector Machine) 알고리즘을 사용한 붓꽃 품종 예측측

#패키지 설치
# install.packages('kernlab') #kernel svm 알고리즘 구현패키지
library(kernlab)
library(tidyverse)

#데이터 준비
iris<-  datasets::iris
str(iris) #target 변수(species)은 factor타입!

# 데이터 탐색
# Petal.Length~Petal.Width 산점도 그래프
# 품종(Species) 에 따라서 점의 색깔을 다르게 표현
ggplot(data=iris,
       mapping = aes(x=Petal.Width,y= Petal.Length,
                     color=Species))+
  geom_point()

# 데이터 셋을 훈련 셋(80%)과 테스트 셋(20%) 으로 분리 -random sampling
set.seed(42) # 난수를 만드는 순서를 고정시킴.
idx<- sample(150)
idx
train_idx <- idx[1:120] 
test_idx<-idx[121:150]

train_set<-iris[train_idx,]
test_set<-iris[test_idx,]

table(train_set$Species)
table(test_set$Species)

# SVM 모델을 훈련 
svm_clf<- ksvm(x = Species~., # x= 공식 ( 종속변수 ~ 독립변수)
               data=train_set, # data =  훈련 셋
               kernel= 'vanilladot') # kernel : 커널 함수이름 .. vanilladot = 선형 
# kernel 함수 종류 : 
# vanilladot : 선형 커널 
# rbfdot: Gaussian RBF 커널 함수 
# polydot: 다항 커널 함수 
svm_clf

# 훈련 셋에서의 예측 결과
train_predictions <- predict(svm_clf,train_set) 
head(train_predictions) # 예측값
head(train_set$Species ) # 실제값

mean(train_set$Species==train_predictions) # 훈련 셋 정확도 98.3% 

CrossTable(train_set$Species,train_predictions,
           prop.chisq=FALSE)

# 테스트 셋에서의  SVM 모델 평가
test_predictions <- predict(svm_clf, test_set)
mean(test_set$Species== test_predictions) #96.7%
CrossTable(test_set$Species,test_predictions)

# 여러가지 커널 함수 비교
# 1) Gaussian RBF kernel
svm_rbf<- ksvm(x = Species~., # x= 공식 ( 종속변수 ~ 독립변수)
               data=train_set, # data =  훈련 셋
               kernel= 'rbfdot')
train_predictions2 <- predict(svm_rbf,train_set) 
head(train_predictions2) # 예측값
head(train_set$Species )
mean(train_set$Species==train_predictions2) #98.3%
#훈련 셋 정확도
test_predictions2 <- predict(svm_rbf,test_set) 
head(test_predictions2) # 예측값
head(train_set$Species )
mean(test_set$Species==test_predictions2)  #93.3%
#테스트 셋 정확도, confusion matrix
CrossTable(test_set$Species,test_predictions2,prop.chisq = FALSE)
# 2)polynomail kernel

svm_poly <- ksvm(x = Species~., # x= 공식 ( 종속변수 ~ 독립변수)
                 data=train_set, # data =  훈련 셋
                 kernel= 'polydot')
train_predictions3 <- predict(svm_poly,train_set)
mean(train_set$Species==train_predictions3)   #98.3%
test_predictions3 <- predict(svm_poly,test_set) 
head(test_predictions3) # 예측값
head(train_set$Species )
mean(test_set$Species==test_predictions3) #96.7%
#테스트 셋 정확도, confusion matrix
CrossTable(test_set$Species,test_predictions3,prop.chisq = FALSE)


#-----------------
# wisc_bc_data.csv 암데이터 예측


url<-('https://github.com/JakeOh/202105_itw_bd26/raw/main/datasets/wisc_bc_data.csv')

wisc_bc_data<-read.csv(url)
train_n<-round(nrow(wisc_bc_data)*0.8)
train_wisc<-wisc_bc_data[0:train_n,2:32]
test_wisc<-wisc_bc_data[(train_n+1):569,2:32]
wisc_bc_data$diagnosis<- as.factor(wisc_bc_data$diagnosis)
svm_clf_wisc<- ksvm(x = diagnosis~., # x= 공식 ( 종속변수 ~ 독립변수)
               data=train_wisc, # data =  훈련 셋
               kernel= 'vanilladot') 
train_predictions5 <- predict(svm_clf_wisc,train_wisc)
mean(train_wisc$diagnosis==train_predictions5)   #98.9%
test_predictions5 <- predict(svm_clf_wisc,test_wisc) 
head(test_predictions5) # 예측값
head(test_wisc$diagnosis)
mean(test_wisc$diagnosis==test_predictions5) #98.2%
