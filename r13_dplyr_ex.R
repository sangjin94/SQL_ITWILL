# ggplot2::midwest 데이터 셋 - Help 페이지에서 내용 확인.
# poptotal(인구수), popadults(성인 인구수), popasian(아시아계 인구수)
# 1) '인구 대비 미성년 인구 백분율' 파생 변수를 추가.
# 2) 미성년 인구 비율이 높은 상위 5개 county와 백분율을 출력.
# 3) 미성년 인구 비율 등급 파생 변수를 추가. 각 등급의 빈도수.
#    40% 이상 large, 30 ~ 40% 미만 middle,  30% 미만 small
# 4) '인구 대비 아시아계 인구 백분율' 파생 변수를 추가하고, 상위 10개 지역의
# state, county, 아시아계 인구 비율을 출력.
#> midwest에는 이미 percasian 변수가 있습니다. 그 값과 비교해보세요.

library(tidyverse)
search()

# 데이터 프레임 확인
head(midwest)
View(midwest)
str(midwest)

# 1) 미성년 인구 비율(% 단위) 파생변수 추가
midwest_df <- midwest %>% 
  mutate(child_pct = ((poptotal - popadults) / poptotal) * 100)

# 2) 미성년 인구 비율이 높은 상위 5개 county와 비율
midwest_df %>% 
  arrange(-child_pct) %>% 
  head(n = 5) %>% 
  select(county, child_pct)

# 3) 미성년 인구 비율 등급(large, middle, small)
midwest_df <- midwest_df %>% 
  mutate(child_pct_grade = ifelse(child_pct >= 40, 'large',
                                  ifelse(child_pct >= 30, 'middle', 'small')))

# 미성년 인구 비율 등급 빈도수
table(midwest_df$child_pct_grade)
count(midwest_df, child_pct_grade)

# 4) 아시아계 인구 비율 상위 10개 county
midwest_df %>% 
  mutate(asia_pct = (popasian / poptotal) * 100) %>% 
  arrange(-asia_pct) %>% 
  head(n = 10) %>% 
  select(state, county, asia_pct, percasian)
