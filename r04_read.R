#파일 (csv,xls,xlsx 등)을 읽어서 데이터프레임 생성하기

#파일 경로(path) 표기 방법:

# 1. 절대경로( absolute path):
# 최상위 디렉토리(root directory)에서부터 파일이 있는 위치까지 모두 표기하는 방법.
# C:\study\lab_r\exam_score2.csv  <~윈도우 버전
# /Users/abc/documents/exam_scores2.csv <~ mac,리눅스 버전

# 2. 상대 경로(relative path):
# 현재 작업 디렉토리( CWD: current working directory)를 기준으로 파일이 있는 위치까지 찾아서 표기하는 방법.
# CWD가 C:\study\lab_r인 경우, exam_score2.csv
# CWD가 C:\study 인 경우, lab_r\exam_score2.csv

#상대 경로 표기법에서 
#  .: 현재 디렉토리 
# ./exam_score2.csv
# ..: 상위 디렉토리
#  ../abc.txt


#디렉토리 구분자: MS Windwos는 '\'를 사용.
# 윈도우즈를 제외한 다른 모든 os는 '/'를 사용.
#따옴표('',"")안에서 '\'는 특별한 의미를 갖지 않기때문에,
#디렉토리 구분자로 '\'를 사용하는 것은 권장하지 않음!
#R에서는 OS에 상관없이 디렉토리 구분자를 '/'를 사용하는 것을 권장.
file.path<- 'C:/study/lab_r/exam_score2.csv'
file.path

# CSV 파일을 읽어서 데이터 프레임 생성하기
df <- read.csv(file = './exam_score2.csv')
df

#./datasets/csv_exam.csv 파일을 읽어서 exam1 데이터프레임 생성

exam1<-read.csv(file='datesets/csv_exam.csv')
exam1
emp <- read.csv(file = '../EMP.csv',
                header= FALSE,
                col.names = c('empno','ename','job','mgr','hiredate','sal','comm','deptno'))
# header 파라미터 : csv 파일에 헤더 정보(컬럼 이름 )가 포함되어 있는지 여부를 설정.
# header의 기본값은 TRUE(파일에서 첫번째 라인을 컬럼 이름으로 사용)
# header = FALSE: 파일의 첫번째 라인부터 데이터로 취급.
# col.names 파라미터 : 데이터프레임의 컬럼 이름을 vector로 만들어줌. 

emp

# 엑셀 파일(xls,xlsx)을 읽고 쓰기 위해서는 별도의 패키지를 설치해야함. 
# install.packages('패키지이름')
# R studio 메뉴 > tool > install packages.. ~>패키지 이름 입력 ~> install
install.packages('tidyverse')

