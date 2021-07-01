# 선형 회귀 (linear regression)을 이용한 의료비 예측

#필요한 패키지 로드
library(tidyverse)
library(ModelMetrics)
search()

#데이터 준비 
url<- 'https://github.com/JakeOh/202105_itw_bd26/raw/main/datasets/insurance.csv'
insurance_df<-read.csv(url,stringsAsFactors = TRUE) # 모든 문자열타입을 factor로 바꾸는 것.
# 모든 문자열을 factor로 바꾸면 사람이름을 factor로 바꿔버리기떄문에 상황봐가면서 사용

head(insurance_df)

# bmi(body mass index) = 몸무게/ 키^2 (kg/m^2)
# expenses : 의료비 지출 - 관심 변수, 종속 변수
# age,sex, bmi , children,smoker - 설명 변수, 독립 변수
# expenses~ age + sex + bmi + children + smoker + region
# expenses = b0+ b1 * age +b2 * sex+ b3 * bmi
#             +b4 * children +b5 * smoker +b6 * region
# 선형 회귀를 하려면 모든 변수들은 숫자 타입이어야 함!
# 문자열 타입을 factor 타입으로 변환하면, 
# lm()함수는 factor 타입을 숫자(0,1,..)로 변환해서
# 회귀식의 계수들을 찾아줌.

table(insurance_df$sex)
table(insurance_df$smoker)
table(insurance_df$region)
str(insurance_df)

#read.csv() 함수를 사용할 때 stringAsFactors= FALSE 인 경우에
#insurance_df$sex<- factor(insurance_df$sex)
#insurance_df$sex<- factor(insurance_df$sex,levels = c()) 코드를 실행

summary(insurance_df)

# 데이터 탐색

# 각 변수의 분포 시각화

# 변수들 간의 상관 관계 시각화 
#expneses ~ age, expenses~ bmi, ... 산점도 그래프

# graphics:: pairs() 함수: 산포도 행렬(scatter plot matrix, pair plot)
pairs(insurance_df[c('age','bmi','children','expenses')])
pairs(insurance_df)

install.packages('psych')
library(psych) #> psych::pairs.panels() 함수를 사용하기 위해서 
# 향상된 산포도 행렬(pair plot)
# 산점도 그래프, 히스토그램, 상관 계수
pairs.panels(insurance_df[c('age','bmi','children','expenses')])

# cor(x,y): 변수 x와 y 의 상관 계수 계산
cor(insurance_df$age,insurance_df$expenses) #나이와  비용의 상관계수 
# -1<= 상관계수 <= 1
# 상관계수가 +1에 가까울수록 양의 상관관계가 크다고 말함.
# 상관계수가 -1에 가까울수록 음의 상관관계가 크다고 말함
# 상관계수가 0에 가까울 수록 상관관계가 없다(작다)고 말함. 
# (주의) 상관관계과 인과관계는 다름! 


# 전체 데이터 셋을 훈련 셋(80%)과 테스트 셋(20%)로 분리
n<- nrow(insurance_df) # 전체 샘플 개수
tr_size <- round(n*0.8) # 훈련데이터 샘플 개수
train_set<- insurance_df[1:tr_size,] # train set 훈련셋 
test_set<- insurance_df[(tr_size+1):n,] # test set 테스트 셋 

# 모델 훈련
# expenses ~ age + sex + bmi + children + smoker + region
lin_reg1<- lm(formula = expenses ~ . ,
              data = train_set)
summary(lin_reg1) # adjusted R^2 = 0.7467

# 선형 모델에서 훈련 셋의 예측값
train_predictions <- predict(lin_reg1,train_set)  # predict(훈련된 모델, 예측하고 싶은 모델)
head(train_predictions) # 예측 값 일부
head(train_set$expenses) # 실제 값 일부
head(lin_reg1$residuals) # 잔차=실제값 -예측값 일부

# 훈련 셋 평가 점수
rmse(train_set$expenses,train_predictions) #> 6030.798 
#오차들의 제곱의 평균의 제곱근

#테스트 셋 예측값
test_predictions <- predict(lin_reg1,test_set)
head(test_predictions) #예측값
head(test_set$expenses) #실제값

#테스트 셋 평가 점수
rmse(test_set$expenses,test_predictions) #> 6096.883 
# 오차는 작을수록 좋다. 
# 일반적으로 훈련 셋의 평가 점수가 테스트셋의 평가 점수보다 좋은 경우가 많다. 
# 과대적합(over-fitting, over-fitted) : 
# 훈련 셋의 평가 점수가 테스트 셋의 평가 점수보다 크게 차이가 나도록 좋은 경우. 

# 선형 모델을 변경 후 평가
# expenses ~ age + sex + bmi + smoker
lin_reg2<- lm(formula = expenses~age + sex+ bmi+smoker,
              data = train_set)
summary(lin_reg2)  # adjusted R^2 = 0.7441 

# 훈련 셋 평가 
train_predictions2<- predict(lin_reg2,train_set)
rmse(train_set$expenses,train_predictions2) #> 6073.699

#테스트 셋 평가
test_predictions2<-predict(lin_reg2,test_set)
rmse(test_set$expenses,test_predictions2) #>6126.623

# 비선형 항을 추가한 모델
# expenses ~ age + age^2 + sex + bmi + smoker
insurance_df$age_square <- insurance_df$age**2 #파생 변수 추가
head(insurance_df$age_square)
train_set<-insurance_df[1:tr_size,]
test_set <- insurance_df[(tr_size+1):n,]
lin_reg3<- lm(formula = expenses~age+age_square+sex+bmi+smoker,
              data = train_set)
summary(lin_reg3) # 회귀 모형이 얼마나 유의한지 확인 < Adjusted R-squared 0.7451

train_predictions3 <- predict(lin_reg3,train_set)

rmse(train_set$expenses,train_predictions3) #> 6058.983

test_predictions3<- predict(lin_reg3,test_set)

rmse(test_set$expenses,test_predictions3) #> 6104.617

# bmi 변수의 값에 따른 파생 변수 추가
insurance_df$overweight <- ifelse(insurance_df$bmi>=30,1,0)
# overweight =1 if bmi>= 30, overweight=0 if bmi <30
# model4: expenses~.
train_set<- insurance_df[1:tr_size,]
test_set<- insurance_df[(tr_size+1):n,]
lin_reg4 <-lm(formula = expenses~.,
              data = train_set)
summary(lin_reg4)     # Adjusted R-squared 0.7525
train_predictions4<- predict(lin_reg4,train_set)
rmse(train_set$expenses,train_predictions4) # rmse 5956.374

test_predictions4<- predict(lin_reg4,test_set)
rmse(test_set$expenses,test_predictions4) #rmse 5951.843

# model5: expenses~ age+ age_square + bmi + smoker
#                   + overweight + overweight*smoker
lin_reg5 <-lm(formula = expenses~age+age_square+bmi+smoker+overweight+overweight*smoker,
              data = train_set)
summary(lin_reg5) # Adjusted R-squared 0.8559

train_predictions5<-predict(lin_reg5,train_set)
rmse(train_set$expenses,train_predictions5) # rmse 4552.887

test_predictions5 <- predict(lin_reg5,test_set)
rmse(test_set$expenses,test_predictions5) #rmse 4400.227
