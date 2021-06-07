  
-- 테이블 생성, 제약조건 정의 연습

/*
테이블 이름: customers(고객)
컬럼:
  1) cust_id: 고객 아이디. 8 ~ 20 byte의 문자열. primary key.
  2) cust_pw: 고객 비밀번호. 8 ~ 20 byte의 문자열. not null.
  3) cust_email: 고객 이메일. 100 byte 문자열.
  4) cust_gender: 고객 성별. 1자리 정수. 기본값 0. (0, 1, 2) 중 1개 값만 가능.
  5) cust_age: 고객 나이. 3자리 정수. 기본값 0. 0 이상 200 이하의 정수만 가능.
*/

create table customers (
cust_id varchar2(20)constraint cust_id_id primary key
 constraint cust_id_id2 check(lengthb(cust_id)>=8),
cust_pw varchar2(20) constraint cust_pw_pw not null
        constraint cust_pw_pw2 check(lengthb(cust_pw)>=8),
cust_email varchar2(100),
cust_gender number(1) default 0
constraint  cust_gender_01 check(cust_gender in(0,1,2)),
cust_age number(3) default 0
constraint cust_age_01 check(cust_age >=0 and cust_age <=200)
);

create table customers2(
    cust_id varchar2(20)
            constraint pk_customers primary key
            constraint ck_cust_id check(lengthb(cust_id)>=8), 
    cust_pw varchar2(20)
            constraint nn_cust_pw not null 
            constraint ck_cust_pw check(lengthb(cust_pw)>=8),
    cust_email varchar2(100),
    cust_gender number(1) default 0
            constraint ck_cust_gender check(cust_gender in (0,1,2)),
    cust_age number(3) default 0
            constraint ck_cust_age check (cust_age between 0 and 200)
);

create table customers3(
    cust_id varchar2(20),
    cust_pw varchar2(20),
    cust_email varchar2(100),
    cust_gender number(1) default 0,
    cust_age number(3) default 0,
    
    constraint pk_cust2 primary key (cust_id),
    constraint ck_id2 check(lengthb(cust_id)>= 8),
    constraint ck_pw2 check(lengthb(cust_pw)>=8),
    constraint nn_pw2 check(cust_pw is not null),
     constraint ck_gender2 check (cust_gender in (0,1,2)),
     constraint ck_age2 check (cust_age between 0 and 200)
);

--oracle이 테이블들을 관리하기 위해 가지고 있는 테이블
desc user_tables;
--oracle이 제약조건들을 관리하기 위해 가지고 있는 테이블
desc user_constraints;

select constraint_name, table_name from user_constraints;





/*
테이블 이름: orders(주문)
컬럼:
  1) order_id: 주문번호. 4자리 정수. primary key.
  2) order_date: 주문 날짜. 기본값은 현재 시간.
  3) order_method: 주문 방법. 8 byte 문자열. ('online', 'offline') 중 1개 값만 가능.
  4) cust_id: 주문 고객 아이디. 20 byte 문자열. not null. customers(cust_id)를 참조.
*/
create table orders (
    order_id number(4)
            constraint pk_orders primary key,
    order_date date default sysdate,
    order_method varchar2(8)
            constraint ck_orders check(order_method in ('online','offline')),
    cust_id varchar2(20)
         constraint nn_orders_id  not null
          constraint fk_orders references customers(cust_id)
);
