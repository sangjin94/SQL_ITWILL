# 데이터 프레임 파악하기(탐색적 데이터 분석)

# 필요한 패키지를 메모리에 로딩.
library(tidyverse)
# 로딩된 패키지 확인
search()

# ggplot2:: mpg 예제 데이터 셋을 사용.
# mpg 데이터 프레임의 첫 5개 row를 출력
# mpg :  mile per gallon(mile/gallon)
head(mpg,n=5)
#> tibble: 데이터 프레임을 확장한 (더많은 기능을 가지고 있는) 자료구조.

tail(mpg,n=5)

# 데이터 프레임 구조
str(mpg)
# 기술 통계량 요약
summary(mpg)
#> 수치 데이터: 최소값, 최댓값, 평균, 중앙값,...
#> 문자열 데이터 : null이 아닌 데이터의 갯수 

# Quick plot을 이용한 데이터 시각화(visualization)
# 시내주행 연비(mpg$cty)
summary(mpg$cty)
# 히스토그램 (histogram): 연속형 변수의 최솟값과 최댓값 사이의
#범위를 (일정한) 구간으로 나눠서, 그 구간 안에 포함된 데이터의 
#개수를 막대로 표시한 그래프.
qplot(x = cty,data = mpg,bins=8)
#> bins = 막대의 개수

# box plot(상자 그림)
qplot(y=cty,data=mpg,geom = 'boxplot')
#> geom = 그래프 종류
qplot(x=cty,data=mpg,geom = 'boxplot')

#고속도로 연비 (MPG$hwy)
# summary
summary(mpg$hwy)
# histogram
qplot(x = mpg$hwy)
# boxplot
qplot(x = mpg$hwy,geom='boxplot')

# 범주형(category type) 변수 시각화- 카테고리별 빈도수(개수)
table(mpg$manufacturer)
# 막대 그래프  
qplot(x = mpg$manufacturer)

# 자동차 구동방식 (mpg$drv)
#도수분포표
table(mpg$drv)
#막대 그래프
qplot(x=mpg$drv) #세로 막대 그래프
qplot(y=mpg$drv,geom='bar') #가로 막대 그래프

# 두 변수의 상관 관계
# 배기량과 시내주행 연비사이의 관계 
#cty~displ 산점도 그래프 # y~x
qplot(x = mpg$displ,y=mpg$cty)
qplot(x = displ,y=cty,data = mpg)

#배기량과 고속주행 연비(hwy)~배기량(displ) scatter plot
qplot(x = displ,y=hwy,data = mpg)
#hwy~cyl(실린더 개수)scatter plot
qplot(x = cyl,y=hwy,data = mpg)

table(mpg$cyl)

#hwy~displ 관계에서 cyl를 점의 색깔
qplot(x=displ,y=hwy,data=mpg,color=as.factor(cyl))
 