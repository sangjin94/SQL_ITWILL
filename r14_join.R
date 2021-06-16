#join: inner, left,right,full

library(tidyverse)
search()

emp <- data.frame(empno=c(101,102,103),ename=c('scott','king','allen'),deptno=c(10,20,40))

emp

dept <- data.frame(deptno=c(10,20,30),dname=c('HR','IT','SALES'))

dept

#inner_join(left_df,right_df,by) 
#left_df %>% inner_join(right_df,by)
#join 조건 by 에 전달하는 컬럼(변수) 이름이 두 테이블에서 같은경우,
#by는 생략해도 됨.

inner_join(emp,dept,by='deptno')
inner_join(emp,dept)
emp %>% inner_join(dept)

#left_join(df1,df2,by=)
#df1 %>% left_join(df2,by)
emp %>% left_join(dept)
#> NA( NOT Available): 결측값, 누락값. sql에서 NULL.

#right_join
right_join(emp,dept)
# <NA> <> 표시가있을때는 문자열의 결측값 없으면 숫자

#full_join
full_join(emp,dept)

#join할 때 join 조건 컬럼의 이름이 서로 다른 경우:
dept2<- data.frame(dno=c(10,20,30),dept_name=c('영어','총무','인사'))
dept2                   

emp %>% inner_join(dept2,by=c('deptno'='dno'))
emp %>% left_join(dept2,by=c('deptno'='dno'))
emp %>% right_join(dept2,by=c('deptno'='dno'))
emp %>% full_join(dept2,by=c('deptno'='dno')) %>% 
  rename('부서번호'=deptno)

# by= c('x1'='y1','x2'='y2') 여러 관계가 있을수도 있기때문에 

#emp 데이터 프레임에 mgr 변수를 추가
emp$mgr<-c(102,NA,102) 
inner_join(emp,emp,by=c('mgr'='empno'))

#join 연습
fuel <- data.frame(fl=c('c','d','e','p','r'),price=c(2.3,2.4,2.1,2.7,2.2))

fuel

#mpg와 fuel 데이터 프레임을 innerjoin 을 하세욥
#그 결과에 price_per_mile 파생변수 추가
# price_per_mile :도심 1마일을 주행할때 드는 연료비?
# model, cty,fl,price,price_per_mile
mpg %>%
  inner_join(fuel) %>% 
  mutate(price_per_mile=price/cty) %>%
  select(model,cty,fl,price,price_per_mile)

#두개이상의 데이터프레임을 join:
#df1 %>% inner_join(df2, by) %>% inner_join(df3,by) %>% ...

#데이터 프레임의 행(row) 합치기 : bind_row()
students_1<- data.frame(stu_id=1:3,
                        stu_name=c('a','b','c'))
students_2<- data.frame(stu_id=4:6,
                        stu_name=c('d','e','f'))
bind_rows(students_1,students_2)
students_1 %>% bind_rows(students_2)
