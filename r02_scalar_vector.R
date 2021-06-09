#scalar(스칼라):한개의 값이 저장된 객채(object),변수(variable)
#vector(벡터): 한가지 타입(유형)의 여러개 값이 저장된 객체.

#scalar의 예:
x<-100 #x는 숫자 1개를 저장하고 있는 스칼라
name<-'오쌤' # name: 문자열 한개를 저장하고 있는 스칼라
#R에서 문자열은 작은따옴표('') 또는 큰 따옴표""로 묶음.
is_big<- TRUE #is_big : 논리값(logical type: TRUE,FALSE) 한개를 저장하는 스칼라
is_big <- (5>3)
is_big <- (5<3)

#비교연산자: >, >=,<,<=,==,!=
is_same <-(3==5)

#vector의 예:
# c(): combine
# 함수 (function): 기능
# argument(인수): 함수를 호출할 때 함수에게 전달하는 값.
# parameter(매개변수,인자): argument들을 저장하기 위해서 선언하는 변수.
# return value(반환값): 함수가  기능을 수행한 후 그 결과로 반환하는 값.

numbers <- c(1,2,3,10,20,100)
#numbers: 숫자(numeric values) 6개를 저장하는 백터
numbers

student_names <- c('안상진','김태현','장윤희')
#student_names: 문자열(characters,string) 3개를 저장하는 벡터
student_names

booleans <- c(TRUE,FALSE,FALSE,TRUE)
#booleans : 논리값 4개를 저장하는 벡터.
booleans

# 벡터의 인덱스(index):벡터에서 원소(element)들이 저장된 위치.
#벡터 numbers에서 첫번쨰원소만 선택
numbers[1]

#numbers의 4번쨰 원소를 선택
numbers[4]

#특정 인덱스 범위(range) 안에 있는 원소들을 선택
numbers[2:4] # 2<=index <=4

#특정 인덱스들에 있는 원소들을 선택
numbers[c(1,3,5)]

#인덱스의 원소를 제외하고 나머지 선택
numbers[-4]
#numbers에서 인덱스 1,2을 제외하고 나머지 모든 원소를 선택
numbers[c(-2:-1)]
numbers[c(-2,-1)]

#seq(): sequence 함수
#함수 호출 방법 1: 파라미터 이름들을 생략하고, argument들만 전달
evens <- seq(2,10,2) #2부터 10까지 2씩 증가하는 수열
evens
#함수 호출 방법 2: 어떤 파라미터에 어떤 값(argument)를 전달할지 지정.
odds<- seq(from=1,to=9,by=2)
odds
#파라미터(from,to,by)와 argument(20,2,11)를 모두 기술하는경우에는,
#argument의 순서가 중요하지않음.
odds2<- seq(by=2,from=11,to=20)
odds2
#함수들 중에는 parameter의 기본값이 미리 설정되어 있는 경우가 있음.
#optional parameter:기본값이 설정된 파라미터.
#optional parameter에 argument를 전달하면 기본값이 무시되고 
#전달된 argument를 사용.
#optional parameter에 argument를 전달하지 않으면,
#기본값이 사용됨.

#seq()함수에서 from 파라미터의 기본값은 1. by 파라미터의 기본값은 1.
numbers<- seq(from=2,to=10)
numbers
numbers<- seq(to=10)
numbers

#10부터 1까지 1씩 감소하는 수열
countdown<- seq(from=10,to=1,by = -1)
countdown

#범위 연산자(:)
numbers<-1:10 #seq(from=1,to=10)
numbers

# vector와 vector의 연산:
# 같은 위치(인덱스)에 있는 원소들끼리 연산을 수행.
numbers1 <- c(1, 10, 100)
numbers2 <- c(2, 4, 6)
numbers1 + numbers2

# vector와 scalar의 연산:
# vector의 모든 원소에 연산이 수행됨.
numbers1 + 2