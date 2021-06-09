# 데이터프레임(Data Frame): 표 형태(행/열)로 데이터를 저장하는 타입.
#   데이터베이스의 테이블(table) 구조와 비슷.
#   데이터프레임의 컬럼은 한가지 타입의 자료들을 저장.
# observation(관찰값, 관측치): 데이터프레임의 행(row). 테이블의 레코드.
# variable(변수): 데이터프레임의 열(column).

stu_no <- 1:4  # 학생 번호
stu_name <- c('aaa', 'bbb', 'ccc', 'ddd')  # 학생 이름
score <- c(100, 50, 70, 80)  # 성적

# 번호, 이름, 성적을 저장하는 데이터프레임
students <- data.frame(stu_no, stu_name, score)
students

# df$col: 데이터프레임에서 특정 컬럼의 내용을 출력
students$stu_name
# select stu_name from students;

exam_scores <- data.frame(korean = c(90, 100, 80),
                          english = c(99, 88, 77),
                          math = c(10, 20, 30))
exam_scores


#파생변수: 데이터프레임이 가지고있는 변수들을 사용해서 새로운 컬럼을 추가하는것. 
exam_scores$total <-
  c(exam_scores$korean+exam_scores$english+exam_scores$math)
#exam_scores 데이터프레임에 세과목 평균을 파생변수로 추가
exam_scores$avg<-c(exam_scores$total/3)

# Ctrl+Shift+c: 주석(commnet) 토글
# Ctrl+space: 코드 자동완성 도와주기

#데이터 프레임의 내용을 파일(csv)로 저장하기 
write.csv(x = exam_scores,file = 'exam_score.csv')
#파일에 write할 객체(데이터프레임)
#파일 이름 (경로)

write.csv(x = exam_scores,file = 'exam_score2.csv',row.names = FALSE) #행 번호(이름)를 파일에 쓰지않음
