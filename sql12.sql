--DDL(Data Definition language)  : CREATE,DROP,ALTER, TRUNCATE
/* 테이블 생성
create table 테이블 이름 ( 
컬럼이름 데이터타입, 
)
*/
-- 테이블 이름 : students
--컬럼 이름/ 데이터 타입
--(1) sid: 학생 아이디, 숫자(number)(2자리)
--(2) sname: 학생 이름, 문자열(varchar2 10 byte
--(3) birthday:학생 이름, 날짜(date) 
create table students ( 
    sid number(2),
    sname varchar2(10),
    birthday date);   
    
--students 테이블의 구조 확인(컬럼, null 여부, 데이터 타입)
desc students;

--DQL(Data Query Language):Select
select * from students;

--DML(date manipulation language): insert, update, delete
/* INSERT:테이블에 레코드(행) 추가
insert into 테이블이름(컬럼1,컬럼2,...) values (값1,값2,..);
*/
insert into students(sid,sname) values(1,'곽기현');
select * from students;
insert into students(sid,sname,birthday) values(2,'김도연',to_date('2021-02-04','yyyy-mm-dd'));
select * from students;

--insert 구문에서 삽입하는 컬럼의 순서는 테이블 생성시 순서를 따르지않아도됨.
--컬럼의 순서와 values에서 전달한 값들의 순서만 같으면 됨.
insert into students(sname,sid) values('김보민',3);

--테이블의 모든 컬럼에 값을 insert하는 경우에는 컬럼 이름들을 생략할 수 있음. 
--values에서는 값들의 누락없이 테이블 생성시 컬럼 순서대로 값을 전달하면 됨.
insert into students values(4,'김수빈',to_date('2021-06-03','yyyy-mm-dd'));

--insert 구문에서 발생할 수 있는 오류들
insert into students values (5,'오쌤'); --에러
insert into students values (5,'오쌤',null); -- 정상작동
insert into students values (6,sysdate,'오쌤'); --sysdata는 문자로 바뀔수있지만 '오쌤'은 날짜데이터로 변환불가능
insert into students (sname,sid) values (6,'오쌤'); -- 문자를 숫자로 변환이 안됨
insert into students (sname) values ('아이티윌'); --컬럼의 값이 너무 큰 에러
--영문,숫자,특수기호 :1byte
--한글: 2 or 3byte(한글 windows 10 ,oracle 11g xe)

--insert into ~values~; 구문은 1행(row)씩 삽입한다.
--insert into ~select~; 구문은 여러행을 한번에 삽입.테이블 내용 복사(다른테이블의 내용을 가져와서 이테이블에 넣는개념)
create table students2(
sid number(2),
sname varchar2(10),
birthday date);

--students 테이블의 모든 행을 students2테이블에 삽입
insert into students2 select *from students;
select * from students;

--TCL(Trancsaction control language): Commit, Rollback
commit; --작업 내용 (insert,update,delete 등)을 데이터베이스에 영구적으로 저장.

--테이블 컬럼의 기본값(default)
create table citizens(
    cid     number(2), --숫자 2자리
    cname   varchar2(5 char), --문자열 5글자까지 (char 를 안쓰고 생략할경우 byte로 인식)
    age     number(3) default 0 --숫자3자리 , 기본값은 0 
);

insert into citizens (cid, cname) values ( 10, '안녕하세요');
select * from citizens;

insert into citizens values (20,'오쌤',null);

insert into citizens values (30,'오쌤');--오류발생 ,, default 값이 있더라도 컬럼이름을 다 명시하고 작성해야함.

--데이터베이스 서버의 현재사진을 default로 사용하는 컬럼
create table ex_01( 
ex_id number(2), ex_date date DEFAULT sysdate); --date가 default 값일때.

insert into ex_01(ex_id) values (1);
select * from ex_01; --insert가 된 시간이 자동으로 입력됨

