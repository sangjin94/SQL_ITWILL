--DDL: create, drop, truncate, alter

-- drop: 테이블의 모든 레코드를 삭제하고, 테이블도 삭제
--truncate: 테이블의 모든 레코드를 삭제.

-- delete: 테이블의 레코드를 삭제.<~ DDL 이 아니라 DML 이다.

create table test1(
tid number(2)
);
insert into test1(tid) values(2);

insert into test1(tid) values(3);

select * from test1;


truncate table test1
;
drop table test1;

create table ex_10(
id number(4) primary key,
pw varchar2(20) not null
);
--ALTER TABLE 테이블이름 변경내용;
--이름 변경(rename): (1)테이블 이름 변경, (2) 컬럼 이름 변경, (3)제약조건 이름 변경

--(1) 테이블 이름 변경 : alter table 테이블이름 rename to 새로운 테이블 이름;

alter table ex_10 rename to ex_users;

--(2)컬럼 이름 변경:
--alter table 테이블 이름 rename column 변경전 이름 to 변경 후 이름;
--id~> user_id
alter table ex_users rename column id to user_id;
--pw~> user_pw
alter table ex_users rename column pw to user_pw;

--(3)제약조건 이름 변경
--alter table 테이블 이름 rename constraint 변경전 이름 to 변경후 이름;
alter table ex_users rename constraint 변경전 이름 to 변경후 이름 ;

--제약조건 이름과 타입을 알아보는 명령어
select constraint_name, constraint_type
from user_constraints
where table_name='EX_USERS';

--SYS_C007092 ~> pk_users
--SYS_C007091 ~> nn_user_pw

alter table ex_users rename constraint SYS_C007092 to pk_users;
alter table ex_users rename constraint SYS_C007091 to nn_user_pw;

-- 추가 (add): (1) 컬럼, (2) 새로운 제약조건
--(1) alter table 테이블이름 add 컬럼이름 데이터타입; (default 나 제약조건 생략가능)
--(2) alter table 테이블이름 add constraint 제약조건이름 제약조건 내용;
--ex_users 테이블에 user_email 컬럼 추가. 데이터 타입은 100byte 문자열.
alter table ex_users add USER_EMAIL varchar2(100);

--ex_users 테이블의 user_email 컬럼에 not null제약조건 추가
alter table ex_users add constraint nn_user_email check (user_email is not null);

desc ex_users;

--삭제(drop):  (1) 컬럼, (2) 제약조건

--(1) alter table 테이블이름 drop column 컬럼이름;
--(2) alter table 테이블이름 drop constraint 제약조건이름;
--nn_user_email 제약조건 삭제
alter table ex_users drop constraint NN_USER_EMAIL;
--user_email 컬럼 삭제
alter table ex_users drop column user_email;

--수정(modify):컬럼의 내용(데이터 타입, null가능컬럼~> not null로 변경)
-- ex> varchar2 용량을 늘릴때 자주사용
--alter table 테이블이름 modify 컬럼이름 변경내용;

--ex_users 테이블의 user_pw 컬럼의 데이터 타입을 100byte 문자열로 변경
alter table ex_users modify user_pw VARCHAR2(100 BYTE);

--modify constraint는 제공되지않음! 
--제약조건의 이름을 유지한채 내용만 변경하는 기능은없음
--제약조건 내용을 변경하고 싶으면 삭제하고 다시 만들어야함.
--drop constraint ~> add constraint


--1.emp테이블을 test_emp 테이블로 복사
--insert into 테이블이름1 select * from 테이블이름2;
create table test_emp1 as 
select * from emp;

--2. etc 컬럼 추가. 20byte 문자열
 alter table test_emp1 add etc varchar2(20);
--3. etc 컬럼을 remark 이름으로 변경.
alter table test_emp1 rename column etc to remark;
--4. remark 컬럼의 데이터타입을 100byte 문자열로 변경
alter table test_emp1 modify remark varchar2(100);
--5. empno 컬럼에 primary key 제약조건 추가.
alter table test_emp1 modify empno primary key;
--6.dept 테이블의 deptno에 고유키 제약조건을 추가한후
--6.deptno 컬럼이 dept 테이블의 deptno를 참조하도록 외래키 제약조건 추가
alter table dept modify deptno primary key;
alter table test_emp1 add constraint foreign key deptno references dept(deptno);
--7.ename 컬럼에 not null 제약조건 추가
alter table test_emp1 add constraint nn_ename check(ename is not null);

--8. 7에서 만든 제약조건 삭제
alter table test_emp1 drop constraint nn_ename;
--9. comm 컬럼 삭제
alter table test_emp1 drop column comm;
--10.test_emp 테이블 삭제