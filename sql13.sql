--제약 조건(constraints)

--테이블 생성 (컬럼이름 +데이터타입+제약조건)

--테이블 이름: ex_02
-- (1) ex_id: 숫자 2자리, 고유키(제약 조건) PK: primary key
-- (2) ex_name: 문자열 10글자 까지, NN(not null)

create table ex_02(
ex_id number(2) PRIMARY KEY, -- PK >= NN+UNIQUE
ex_name varchar2(10CHAR) NOT NULL);
commit;
desc ex_02;

insert into ex_02 values (1,'가나다라'); --정상입력
insert into ex_02 values (1,'가나다라'); --실패,두번째 입력은 안됨. unique 를 무시했다.
insert into ex_02 (ex_name) values ('홍길동'); --ex_id 라는 컬럼에 null 을 넣을수 없어서
--오류 보고 내용- -
--ORA-01400: cannot insert NULL into ("SCOTT"."EX_02"."EX_ID")=(계정, 테이블,컬럼)

insert into ex_02 values (2,'홍길동'); --성공
select * from ex_02;
insert into ex_02 values (3,'홍길동'); --성공 

insert into ex_02(ex_id) values (4); --실패,이름이 null이면 안되기 때문에

--제약조건의 이름과 내용을 함께 명시
create table ex_03(
ex_id number(2) constraint pk_ex03_id PRIMARY KEY, -- PK >= NN+UNIQUE
ex_name varchar2(10CHAR) constraint nn_ex03_name not null
);

--컬럼 정의와 제약 조건 정의를 구분해서 테이블 생성
create table ex_04(
   --컬럼정의
    ex_id number(2),
    ex_name varchar(10 char),
    --제약조건 정의
    constraint pk_ek04_id primary key(ex_id),
    constraint nn_ex04_name check (ex_name is not null) --not null 조건을 달려면 check 를 사용해야함
    );
-- 테이블 이름 : ex_05
--컬럼:
--  (1) id: 숫자 2자리, pk
-- (2)name:문자열 10글자 ,NN
--  (3) code:문자열 3byte, 중복되지 않는값
--  (4) creat_date : 날짜 , 기본값 현재시간
-- (5) age: 숫자 3자리 , 0보다 크거나 같아야함
-- (6) gender: 문자열 1byte, 'M'또는 'F'만 가능
create table ex_05 (
id       number(2)
             constraint pk_ex05_id primary key,
    name     varchar2(10 char)
             constraint nn_ex05_name Not NuLL,
    code     varchar2(3 byte)
             constraint uq_ex05_code unique,
    creat_date date default sysdate,
    age     number(3)  
            constraint ck_ex05_age check( age >=0),
    gender   varchar2(1)
            constraint ck_ex05_gender check (gender in('m','f'))
);
-- (1) id: 숫자 2자리, pk
-- (2)name:문자열 10글자 ,NN
--  (3) code:문자열 3byte, 중복되지 않는값
--  (4) creat_date : 날짜 , 기본값 현재시간
-- (5) age: 숫자 3자리 , 0보다 크거나 같아야함
-- (6) gender: 문자열 1byte, 'M'또는 'F'만 가능
create table ex_06(
    id number(2) ,
    name varchar2 (10 char),
    code varchar2 (3 byte),
    creat_date date default sysdate,
    age number(3),
    gender varchar2(1byte),
    
    constraint ex_id_con2 primary key (id),
    constraint ex_name_co2n check (name is not null), --not null 은 체크로 바꿔서 작성
    constraint ex_id_cod2   unique (code),
    constraint ck_ex06_age check( age >=0),
    constraint ck_ex06_gender check (gender in('m','f'))
);


--primary key(고유키)와 foreign key(외래키) 
create table ex_dept(
    deptno      number(2) primary key,
    dname    varchar2(10)
);

create table ex_emp(
    empno number(4)  primary key, 
    ename varchar2(100),
    deptno number(2) references ex_dept(deptno) -- foreign 키 제약조건주는방법  
);

select * from ex_dept; --0개 row
select * from ex_emp;

insert into ex_emp (empno,ename,deptno) values(1111,'상진',10);
--실패 : 부서번호 10이 ex_dept 테이블에 존재하지 않기 때문에
--참조할수없다

insert into ex_dept values(10,'인사부');
insert into ex_dept values(20,'개발실');
insert into ex_emp (empno,ename,deptno) values(1111,'상진',10);
--다시 하면 성공

create table ex_emp2(
empno number(4),
ename varchar2(100),
deptno number(2),
constraint pk_ex_emp2_empo primary key (empno),
constraint fk_ex_emp2_deptno foreign key (deptno) references ex_dept(deptno)
);