# 변수 타입에 따른 여러가지 그래프 종류(geometry)

# histogram(히스토그램): 연속형 변수의 분포를 시각화
g <- ggplot(data = mpg)

# 시내주행 연비 분포
g + geom_histogram(mapping = aes(x = cty), bins = 10)

# 고속도로 연비 분포
g + geom_histogram(mapping = aes(x = hwy), bins = 10,
                   color = 'black', fill = 'white')
#> color = 막대 테두리 색깔, fill = 막대 안쪽을 채우는 색깔


# 막대 그래프(bar plot): 카테고리(범주) 타입 변수의 분포
# 자동차 종류(class)별 데이터 개수
table(mpg$class)
g + geom_bar(mapping = aes(x = class))  # 세로 막대 그래프
g + geom_bar(mapping = aes(y = class))  # 가로 막대 그래프

# 자동차 연료(fl)별 데이터 개수
table(mpg$fl)
g + geom_bar(mapping = aes(x = fl, fill = fl))
#> 막대 채우기 색깔을 fl의 값에 따라서 다르게 매핑함.

g + geom_bar(mapping = aes(x = fl), fill = 'lightblue')
#> 모든 막대의 채우기 색깔을 'ligthblue' 한가지로 설정.

# 자동차 구동방식(drv)별 데이터 개수
table(mpg$drv)
g + geom_bar(mapping = aes(x = drv, fill = drv))


# box plot(상자 그림): 연속형 변수의 기술 통계량 시각화
#   최솟값, 1사분위값, 중앙값(median), 3사분위값, 최댓값
# 시내주행 연비 요약 & box plot
summary(mpg$cty)
g + geom_boxplot(mapping = aes(y = cty))
g + geom_boxplot(mapping = aes(x = cty))

# 고속도로 연비 요약 & box plot
summary(mpg$hwy)
g + geom_boxplot(mapping = aes(y = hwy))

# 자동차 구동방식별 시내주행 연비의 분포를 box plot으로 시각화
table(mpg$drv)
g + geom_boxplot(mapping = aes(x = drv, y = cty))

# scatter plot과 비교
g + geom_point(mapping = aes(x = drv, y = cty))

# 실린더 개수별 시내주행 연비 분포 시각화 - boxplot
table(mpg$cyl)
g + geom_boxplot(mapping = aes(x = as.factor(cyl), y = cty))
#> as.factor(변수): 변수를 factor(카테고리 타입 객체)로 변환.

# scatter plot과 비교
g + geom_point(mapping = aes(x = cyl, y = cty))
g + geom_point(mapping = aes(x = as.factor(cyl), y = cty))


# scatter plot(산점도 그래프): 두 변수 간의 상관관계를 시각화
# cty ~ displ 상관관계
g + geom_point(mapping = aes(x = displ, y = cty))

# hwy ~ cty 상관관계
g + geom_point(mapping = aes(x = cty, y = hwy))


# 하나의 ggplot 객체에 두개 이상의 geom 함수를 사용.
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) + 
  geom_point() +
  geom_smooth()  # 회귀 곡선(regression curve)

ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(color = drv))

ggplot(data = mpg, mapping = aes(x = displ, y = cty, color = drv)) +
  geom_point() +
  geom_smooth()

# hwy ~ displ scatter plot + 회귀 곡선
# 1) 점의 색깔은 drv에 따라서 다르게 매핑.
# 회귀 곡선의 색깔도 drv에 따라서 다르게 매핑.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth()

# 2) 점의 색깔은 drv에 따라서 다르게 매핑.
# 회귀 곡선의 선 스타일이 drv에 따라서 다르게 매핑. 선 색깔은 한가지.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(linetype = drv))

# 3) 점의 색깔, 회귀 곡선의 색깔, 회귀 곡선의 선 스타일 모두 
# drv 값에 따라서 다르게 매핑
ggplot(data = mpg, 
       mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(mapping = aes(linetype = drv))


# 막대 그래프: 카테고리 변수의 (데이터 개수) 시각화
# 자동차 구동방식별 빈도수
ggplot(data = mpg) +
  geom_bar(mapping = aes(x = drv))

# 자동차 class별, drv별 빈도수
ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), 
           position = 'dodge')
#> geom_bar() 함수의 position 파라미터:
#   (1) position = 'stack': 막대를 쌓아서 그림.
#     position의 파라미터의 기본값은 'stack'이므로, 생략가능.
#   (2) position = 'dodge': 막대들을 옆으로 나란히 그림.
#   (3) position = 'identity': 막대들을 겹쳐서 그림.
#     identity를 사용하면 뒤에 가려져서 보이지 않는 막대들이 생길 수 있음.
#     -> 막대를 약간 투명하게 만들면 가려진 막대들이 보임.

ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), 
           position = 'identity', alpha = 0.4)
#> alpha = 불투명도(0 ~ 1). 0은 투명. 1은 불투명.

# geom_bar() 함수의 position = 'fill':
# 그룹들 간의 비율을 막대로 표시. 모든 막대는 동일한 길이.
ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), 
           position = 'fill')

# line graph(선 그래프): 시계열(time-series) 데이터 시각화.
# 시계열 데이터: 시간에 따라서 값들이 변하는 데이터.
#   주식, 비트코인, 환율, 인구수, 감염자수, 날씨, ...

# ggplot2 패키지의 economics 예제 데이터 셋 사용.
str(economics)
head(economics)
tail(economics)

# 인구수(pop) 시계열 그래프
ggplot(data = economics) +
  geom_line(mapping = aes(x = date, y = pop))

# 실업자수(unemploy) 시계열 그래프
ggplot(data = economics) +
  geom_line(mapping = aes(x = date, y = unemploy))

# 개인저축률(psavert) 시계열 그래프
ggplot(data = economics) +
  geom_line(mapping = aes(x = date, y = psavert))

# economics 데이터 프레임에 인구대비 실업자 비율(unemprt) 파생변수 추가.
economics$unemprt <- (economics$unemploy / economics$pop) * 100
tail(economics)

# 실업자 비율 시계열 그래프
ggplot(data = economics) +
  geom_line(mapping = aes(x = date, y = unemprt))

# 개인저축률, 실업자 비율 시계열 그래프를 함께
ggplot(data = economics, mapping = aes(x = date)) +
  geom_line(mapping = aes(y = psavert, color = '저축률')) +
  geom_line(mapping = aes(y = unemprt, color = '실업률')) +
  ylab('Ratio')