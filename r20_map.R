#지도 위에 데이터 표현하기

#지도 데이터(위도, 경도)를 가지고 있는 패키지 설치
install.packages('maps')

#ggplot2::coord_map() 함수가 필요로 하는 패키지 설치
install.packages('mapproj')

library(tidyverse)

#지도 데이터 불러오기 : ggplot2::map_data(map='지도이름')
#< 지도 데이터를 읽어서 데이터 프레임을 생성.

usa<- map_data(map = 'usa')
head(usa)
str(usa)

#usa 데이터 프레임 변수들:
#> long: longtitude(경도)
#>    영국 그리니치 천문대를 기준으로 동(+)/서(-) 방향의 좌표.
#> lat : latitude(위도)
#>    적도를 기준으로 남(-)/북(+) 방향의 좌표
#> group: 지도에서 함께 연결할 위도/경도 점들의 그룹(나라 ,주, 도시, ... )
#> order: 위도/경도 점들을 연결하는 순서

ggplot(data = usa,mapping = aes(x=long,y=lat,group=group))+
  geom_polygon(color='black',fill='white')+
  coord_map(projection = 'polyconic') #coord_quickmap() 도 비슷하게 가능

usa_state<- map_data(map='state')
head(usa_state)

ggplot(data = usa_state,mapping = aes(x=long,y=lat,group=group))+
  geom_polygon(color='black',fill='white')+
  coord_quickmap()

#map_data() 함수를 사용해서 세계지도를 그릴수 있는 데이터 프레임 생성.
#ggplot을 사용해서 지도를 그려보세요.
world<-map_data(map = 'world')
ggplot(data=world,mapping = aes(x=long,y=lat,group=group))+geom_polygon(color='black',fill='white')+
  coord_quickmap()

#map_data() 함수를 사용해서 세계지도에서 한국,중국,일본 region을 선택

#선택한 region들을 지도로 표현
asia<- map_data(map='world',region = c('South korea','North Korea','China','Japan'))
ggplot(data=asia,
       mapping = aes(x=long,y=lat,group=group))+
  geom_polygon(color='black',fill='white')+
  coord_map(projection = 'polyconic')

#미국 state의 지도정보
head(usa_state)
#usa_state 변수의 구분되는 값들
distinct(usa_state,region) #49개 주 이름 -소문자

#datasets::USArrests 예제 데이터 셋 - 범죄 통계 데이터
head(USArrests)
str(USArrests)
#> 50obsevations, 4 variables
#>미국 주 이름들이 컬럼(변수)이 아니라 행 이름으로 설정되어있음!
#> 지도 데이터와 범죄 통계 데이터를 merge(join)하기 위해서는 
#행 이름들을 컬럼(변수)으로 변환해야 할 필요가 있음.
us_arrests<- rownames_to_column(USArrests,var = 'state')
head(us_arrests)
str(us_arrests)

head(distinct(usa_state,region))

tail(us_arrests)
usa_state %>% distinct(region) %>% tail()

#us_arrests 데이터 프레임에서 주이름들을 모두 소문자로 변환
us_arrests$state <- tolower(us_arrests$state)
head(us_arrests)

# 지도 데이터와 범죄데이터를 join 해서 새로운 데이터 프레임을 만듦
df<- left_join(usa_state,us_arrests,by=c('region'='state'))
head(df)

#미국 주 지도 위에 Murder 발생 건수를 색깔로 표현
ggplot(data = df,
       mapping = aes(x=long,y=lat,group=group, fill =Murder))+
  geom_polygon(color='gray')+
  coord_quickmap()+
  scale_fill_continuous(low='white',high='red') #색 설정 낮을때 흰색 많으면 빨간색 

# 단계 구분도(Choropleth plot):
# 지도 위에 통계 값들을 색깔 단계로 구분해서 시각화한 그래프
# 인구,범죄, 질병 통계, ... 
# ggiraphExtra 패키지: 단계 구분도를 쉽게 그리기 위해 만들어진 패키지.
#install.packages('ggiraphExtra')

library(ggiraphExtra)
search()

ggChoropleth(data = us_arrests,
             map= usa_state,
             mapping = aes(map_id=state, fill = Murder),
             interactive = TRUE) #interactive 파라미터를 넣으면 애니메이션 기능처럼됨

# ggChoropleth 함수의 파라미터:
# data = 통계 값들을 가지고 있는 데이터 프레임
# > 지도 데이터의 region 컬럼과 join 할 수 있는 컬럼이 있어야 함.
# map= 지도 정보(long,lat,group,order,region) 가 있는 데이터프레임
# mapping = aes(...): 변수들의 값에 따라서 다르게 매핑(설정) 하는 내용.
#> map_id = map의 region가 join할 수 있는 data의 변수 이름. 
# interactive: 기본값은 FALSE. TRUE로 설정하면 interactive graph를 만듦.
