#ggplot2:: ggplot() 함수를 사용한 데이터 시각화 

library(tidyverse)
search()

#ggplot()함수 사용방법: ggplot() + geom_xxx() + 옵션들 + ...
# (1) ggplot(): 그래프를 그릴 준비
# (2) geom_function(): 그래프 종류 (geometry function)
# (3) 옵션 함수: 배경테마 , 폰트 , ...
ggplot(data=mpg)

# cty(시내주행연비) ~ displ(배기량) 산점도 그래프 (scatter plot)
ggplot(data = mpg, mapping = aes(x=displ, y = cty)) + 
  geom_point()

#ggplot()d의 parameter:
# data= 데이터프레임
# mapping = aes() : x축, y축 매핑, 색상 매핑, 스타일 매핑, ...

#aes()함수: aesthetic function (심미적 함수)
# 데이터 프레임의 "변수들을 사용"해서 그래프의 심미적인 요소들을 설정.
# 데이터 프레임의 "변수의 값에 따라서" 달라지는 색깔,모양,크기 등을 설정
ggplot(data = mpg)+geom_point(mapping = aes(x=displ,y=cty))

# cty~displ, 점의 색깔은 구동방식(drv)에 따라 다르게 표현
ggplot(data= mpg,mapping = aes(x=displ,y=cty,color=drv))+geom_point()
# 같은 명령  
ggplot(data= mpg)+geom_point(mapping = aes(x=displ,y=cty,color=drv))
  
#aes()에서의 color 설정과 aes()밖에서의 color 설정 비교
ggplot(data = mpg,mapping = aes(x=displ,y=cty))+geom_point(color='blue') #점을 파란색으로 찍겠다.


ggplot(data = mpg,mapping = aes(x=displ,y=cty))+geom_point(mapping=aes(color='blue')) #<~ 블루라는 변수를 기준으로 색을 구분하겠다.

