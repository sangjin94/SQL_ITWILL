#install.packages('패키지이름')
#  CRAN(R패키지 중앙 저장소)에 등록된 패키지를 다운받고 설치.
# CRAN에 등록되어 있지 않고, 개인/단체 저장소(github)에 저장된 패키지를
#설치할 필요가 있을 수도 있음.
# devtools::install_github() 함수를 사용해서 github에 저장된 패키지를 
#설치할 수 있음.
install.packages("devtools")

devtools::install_github('cardiomoon/kormaps2014')

library(tidyverse)
library(ggiraphExtra)
library(kormaps2014)

search()

#kormaps2014 패키지에 포함된 한국 지도 데이터
head(kormap1)
str(kormap1)
str(kormap2)
kormap2<-kormap2
#ggplot을 사용해서 kormap1~3 지도를 표현
ggplot(data=kormap1,mapping = aes(x=long,y=lat,group=group))+
  geom_polygon(fill='white',color='black')+
  coord_quickmap()
ggplot(data=kormap2,mapping = aes(x=long,y=lat,group=group))+
  geom_polygon(fill='white',color='black')+
  coord_quickmap()
ggplot(data=kormap3,mapping = aes(x=long,y=lat,group=group))+
  geom_polygon(fill='white',color='black')+
  coord_quickmap()
str(kormap2)
head(kormap2)
#kormap2 데이터 프레임을 사용해서 서울 지도표현.
kormap2 %>% filter(str_starts(kormap2$sigungu_cd,'11'))%>%
  ggplot(mapping = aes(x=long,y=lat,group=group))+ 
  geom_polygon(fill='white',color='black')+
  coord_quickmap()

#kormap1 지도위에 korpop1 데이터를 시각화
head(korpop1)

#kormap1 과 korpop1 데이터 프레임을 left_join.
#join 기준 컬럼 : code
df<- left_join(kormap1,korpop1,by='code')
head(df)

ggplot(data = df,mapping = aes(x=long,y=lat,group=group))+
  geom_polygon(mapping = aes(fill=총인구_명),color='darkgray')+
  coord_quickmap()+
  scale_fill_continuous(low='white',high='darkorange')

# ggchotopleth 함수 이용 - 전국 시도별 인구수 지도에 표시
ggChoropleth(data= korpop1,
             map=kormap1,
             mapping=aes(map_id=code,fill=총인구_명),
             interactive=TRUE)
# kormap2 지도 데이터 korpop2 인구 데이터를 사용해서 
#전국의 시군구별 인구수를 지도에 표시
#ggplot, ggchoropleth
ggChoropleth(data = korpop2,
             map = kormap2,
             mapping = aes(map_id=code,
                           fill=총인구_명),
             interactive=TRUE)
df2<- left_join(kormap2,korpop2,by=c('region'='code')) %>% filter(str_starts(region,'11'))
ggplot(df2,mapping = aes(x=long,y=lat,group=group))+
  geom_polygon(mapping=aes(fill=총인구_명),color='white')+
  coord_quickmap()+
  scale_fill_continuous(low='white',high='red')

#kormap2 지도 데이터 korpop2 인구 데이터를 사용해서
#서울의 구별 인구수를 지도에 표시 

  ggplot(df2,mapping = aes(x=long,y=lat,group=group))+
  geom_polygon(mapping=aes(fill=총인구_명),color='white')+
  coord_quickmap()+
  scale_fill_continuous(low='white',high='red')
#ggplot, ggchoropleth
  ggChoropleth(data= df2,
               map = df2,
               mapping = aes(map_id=code,
                             fill=총인구_명),
               interactive=TRUE)
