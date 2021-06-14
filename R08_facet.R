#Faceting: 한 개의 plot을 카테고리별로 행과 열을 나눠서 여러개의 그래프를 그리는 것.
library(tidyverse)
search()

head(mpg)

#drv별 cty ~ displ
ggplot(data = mpg) + geom_point(mapping = aes(x=displ,y=cty,color=drv))

ggplot(data=mpg)+ geom_point(mapping = aes(x=displ,y=cty,color=drv))+
  facet_wrap(facets =  ~drv)

ggplot(data=mpg)+ geom_point(mapping = aes(x=displ,y=cty,color=drv))+
  facet_grid(facets = . ~drv)
#facet 에서 비어있는칸에 . 을 넣어주어햐함
ggplot(data=mpg)+ geom_point(mapping = aes(x=displ,y=cty,color=drv))+
  facet_grid(facets = drv ~ . ) 
#facet_wrap():행 또는 열 한방향으로만 칸을 나눌 수 있음.
#facet_grid():행,열 방향 모두 칸을 나눌 수 있음.

#drv별,cyl별 hwy~displ 산점도 그래프
ggplot(data = mpg)+geom_point(mapping = aes(x=displ,y=hwy))+
  facet_grid(facets =drv ~cyl)

#drv별 hwy의 box plot
ggplot(data = mpg)+geom_boxplot(mapping = aes(x=drv,y=hwy))

ggplot(data = mpg)+geom_boxplot(mapping = aes(y=hwy))+facet_grid(facets = .~drv)

ggplot(data = mpg)+geom_boxplot(mapping = aes(x=hwy))+facet_grid(facets = drv~ .)
