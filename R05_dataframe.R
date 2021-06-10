# 데이터 프레임의 구조, 요약 정보 확인

exam<- read.csv(file = 'datasets/csv_exam.csv')
exam

# 데이터 프레임에서 데이터 일부만 출력
# head(df, n = 6 ): 데이터 프레임 df 에서 첫 6개 row(기본값 6)를 출력 
# tail(df,n=6): 데이터 프레임 df 에서 마지막 6개 row(기본값 6)를 출력 
#출력할 row의 개수는 파라미터 n으로 설정.

head(exam)
tail(exam,n = 5)

# str(df): 데이터프레임의 구조(structure)를 확인 -컬럼 이름, 타입,원소 일부,...
str(exam)

# 데이터 타입:
# int : integer. 정수
# dbl : double. 실수
# chr : character. 문자(열)
# logi: logical. 논릿값

# summary(df): 데이터 프레임의 기술 통계량(descriptive statistics)요약.
summary(exam)
# summary(df$var):특정 컬럼의 기술 통계량
summary(exam$math)
# summary() 함수가 보여주는 기술 통계량
# Min.: minimum , 최솟값
# Max: maximum , 최댓값
# Mean: 평균
# Median: 중앙값
#1st Qu.: frist Quartile, 1사분위 값
#3st Qu.: third Quartile, 3사분위 값


