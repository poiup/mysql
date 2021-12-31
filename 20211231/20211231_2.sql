-- ict_practice 를 디폴트 스키마로 잡아주세요
use ict_practice;

/*
userTbl 테이블
user_id 문자열(8) PRIMARY KEY
user_name 문자열(10) NOT NULL
birth_year 정수(4) NOT NULL
addr 문자열(4) NOT NULL
phone_number 문자열(11)
height 정수(3)
reg_date DATE

buyTbl 테이블
order_number INT AUTO_INCREMENT PRIMARY KEY
user_id 문자열(8) NOT NULL
prod_name 문자열(6) NOT NULL,
group_name 문자열(4)
price 정수(7) NOT NULL -- int는 크기를 넣는 자리를 비워두면 자리수 제한이 사라짐
amount 정수(3) NOT NULL
FOREIGN KEY(user_id) REFERENCES userTbl(user_id)
*/

-- PRIMARY KEY(주요 키)
-- 각 테이블을 대표할수 있는 대표 데이터를 저장하는 컬럼에 붙이는 제약조건입니다.
-- 모든 테이블은 무조건 하나의 PRIMARY KEY를 갖는다
-- PRIMAEY KEY는 자동으로 중복을 방지하고, NULL도 들어올수 없으므로 NOT NULL도 겸한다
CREATE TABLE userTbl (
	user_id varchar(8) PRIMARY KEY,
    user_name varchar(10) NOT NULL,
    birth_year int(4) NOT NULL,
    addr varchar(4) NOT NULL,
    phone_number varchar(11),
    height int(3),
    reg_date DATE
);

-- AUTO_INCREMENT(자동 증가)
-- INT(정수) 자료형이 붙은 컬럼에만 붙일수 있고, 이게 붙은 컬럼은 자동으로 1씩 증가합니다.
-- 시작은 1입니다
-- INSERT INTO 구문이 실행될떄마다 해당 컬럼에 들어갈숫지를 자동으로 배정해줍니다.
-- 한번 쓰인 숫자는 다시는 사용되지 않습니다.

-- FOREIGN KEY(외래키)
-- 쇼핑몰의 구매자는 반드시 회원이어야 합니다.
-- 특정 테이블에 존재하는 값만 해당 컬럼에 들어올수 있도록 거는 제약조건
-- FOREIGN KEY를 거는 컬럼의 자료형과 크기는 참조하는 쪽과 원본 모두 같아야합니다.
-- 참조 컬럼의 있는 값만 (userTbl의 user_id에 존재하는 값만) buyTbl의 user_id 에 올수 있습니다.
-- 외부 키로 user_id를 사용하기 위해 userTbl에 있는 user_id를 참조한다
CREATE TABLE buyTbl (
	order_number INT AUTO_INCREMENT PRIMARY KEY,
    user_id varchar(8) NOT NULL,
    prod_name varchar(10) NOT NULL,
    group_name varchar(10),
    price int(7) NOT NULL,
    amount int(3) NOT NULL,
    FOREIGN KEY(user_id) REFERENCES userTbl(user_id) 
);

DROP table buyTbl;

INSERT INTO userTbl VALUES ('AJY','안재영', 1998, '경기','0111111111',170,'2020-3-5');
INSERT INTO userTbl VALUES ('SHM','손흥민', 1990, '서울','0113517121',182,'2020-6-5');
INSERT INTO userTbl VALUES ('EM','일론머스크', 1953, '경기','0111235121',172,'2020-6-18');
SELECT * FROM userTbl;

-- 가입한 회원이 물건을 산 이력이 남도록 하겠습니다.
INSERT INTO buyTbl VALUES(null,'AJY','기계식키보드','컴퓨터기기',200000,1);
-- order_number는 값을 null로주면 AUTO_INCREMENT에 의해 자동으로 1씩 증가된 숫자를 배정받음
INSERT INTO buyTbl VALUES(null,'AJY','듀얼모니터','컴퓨터기기',20000,1);
-- 없는 회원 아이디로 INSERT를 시도해보겠습니다.
INSERT INTO buyTbl VALUES(null,'AAY','기계식키보드','컴퓨터기기',200000,1);

-- SHM, EM으로 INSERT를 할수 있도록 조치를 취해주신 다음
-- 실행시켜 주세요
INSERT INTO buyTbl VALUES(null,'SHM','유니폼','의류',300000,1);
INSERT INTO buyTbl VALUES(null,'EM','도지코인','가상화폐',5000,100000);
SELECT * FROM buyTbl;
