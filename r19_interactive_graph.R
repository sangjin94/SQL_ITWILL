#interactive graph

#필요한 패키지 설치
install.packages('plotly')
#패키지 홈페이지 : 'http://plotly.com/r/'

#패키지를 로드 
library(tidyverse)
library(plotly)
search()

#ggplot2::mpg 데이터 셋을 시각화

#hwy~displ 산점도 그래프
# 1) ggplot 그래프 작성, 저장 -> ggplot()에 전달.
g<-ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ,y=hwy,color=drv))
ggplotly(g)

# 2)plot_ly() 함수를 사용해서 interactive graph 그리기
plot_ly(data=mpg,x= ~displ,y=~hwy, color=~drv,
        type = 'scatter')

#hwy~dospl
#점의 색깔은 drv에 따라서, 점의 모양은 class 에 따라서 다르게 설정
g<-ggplot(data=mpg)+
  geom_point(mapping = aes(x=displ,y=hwy,color=drv,shape=class))
g
ggplotly(g)

plot_ly(data = mpg,x=~displ,y=~hwy,color = ~drv,symbol = ~class,type = 'scatter')

#drv별 hwy의 boxplot
g<- ggplot(data = mpg)+geom_boxplot(mapping = aes(y=hwy,x=drv))
ggplotly(g)

plot_ly(data = mpg,y=~hwy,x=~drv,type = 'box')

#ggplot2::economics 데이터 셋을 사용
head(economics)

#인구수(pop) 시계열 그래프 
g<- ggplot(data = economics)+
  geom_line(mapping = aes(x=date,y=pop))
ggplotly(g)

plot_ly(data=economics,x=~date,y=~pop,mode = 'lines')

#개인저축률 (psavert) 시계열 그래프
g<- ggplot(data = economics)+
  geom_line(mapping = aes(x=date,y=psavert))
ggplotly(g)

plot_ly(data=economics,x=~date,y=~psavert,mode = 'lines')

#선그래프를 그릴때 type='scatter' 생략가능

#economics 데이터 프레임에 실업률(단위%) 파생변수를 추가
economics$unemploy_ratio<- (economics$unemploy/economics$pop)*100
#실업률 시계열 그래프
g<- ggplot(data = economics)+
  geom_line(mapping = aes(x=date,y=unemploy_ratio))
ggplotly(g)

plot_ly(data=economics,type='scatter',mode='lines',x=~date,y=~unemploy_ratio)


#개인저축률 ,실업률을 하나의 그래프에
g<- ggplot(data = economics)+
  geom_line(mapping = aes(x=date,y=unemploy_ratio))+geom_line(mapping = aes(x=date,y=psavert))
ggplotly(g)
#공통되는 변수는 ggplot 항에 입력후 다른변수는 geom에 따로 입력할수 있다.  
g<- ggplot(data= economics,mapping = aes(x=date))+geom_line(mapping = aes(y=unemploy_ratio,color='unemploy_ratio'))+geom_line(mapping = aes(y=psavert,color='psavert'))+
  ylab('Ratio')
g
plot_ly(data = economics,type = 'scatter',mode='lines',x=~date,y=~psavert,name = "개인 저축률") %>% 
  add_trace(y=~unemploy_ratio,name='실업률')

# plot_ly () 함수
#> type='scatter',mode='markers': 산점도그래프
#> type='scatter',mode='lines': 선그래프
#> type='scatter',mode='lines+markers': 선 그래프+ 마커(점)