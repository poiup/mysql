-- 지금 testtbl1 같은 경우 id를 수동으로 입력해주고있습니다.
-- 이 경우 매번 id값을 사용자가 계산해서 inser해야하기 떄문에
-- 굉장히 불편한데 auto_increment 석성을 컬럼에 걸어주면
-- 데이터를 입력받지 못한다면 컴퓨터가 순차적으로 컬럼에 중복되지않고
-- 증가하는 숫자를 자동으로 입력해줍니다.
create table testtbl2 (
	id int AUTO_INCREMENT PRIMARY KEY,
    user_name varchar(3),
    age int
);
INSERT INTO testtbl2 VALUES (null, '알파카',4);
INSERT INTO testtbl2 VALUES (null, '에뮤',2);
INSERT INTO testtbl2 VALUES (null, '토끼',1);

-- 현재 3개의 데이터가 들어갔으므로 auto_increment의 값은 3이다.
SELECT * FROM testtbl2;

-- auto_increment의 기준값은 1부터 1씩 자동으로 증가하지만
-- 만약에 사용자가 임의로 값을 바꾸고싶다면 ALTER TABLE을 이용해
-- AUTO_INCRmet의 값을 수정할수 있습니다.
-- AUTO_INCREMENT의 현재값을 100으로 수정하는 구문
ALTER TABLE testtbl2 auto_increment = 1000;
INSERT INTO testtbl2 VALUES (null, '반달곰',10);
INSERT INTO testtbl2 VALUES (null, '산양',3);

-- cmd에서 testtbl2컬럼에 데이터를 3개더 생성해주세요.
-- 커드라인에서 초회까지 마쳐주세요

-- auto_increment 는 기본적으로 1씩 증가하는데
-- 이 증가분을 수정하고 싶다면 서버측 변수인
-- @@auto_increment_increment 를 바꿔야합니다.
-- testtbl2 와 이름만 다른 testtbl3를 만들어주세요
Create Table testtbl3 (
	id int AUTO_INCREMENT PRIMARY KEY,
    user_name varchar(3),
    age int
);

drop table testtbl3;
-- testtbl3의 초기 auto_increment값을 1500으로 고쳐보세요
alter table testtbl3 auto_increment = 1500;
-- 증가분을 1이 아닌 3으로 세팅하는법 
-- 프로그램 전체의 auto_increment가 3으로 설정됩니다.
SET @@auto_increment_increment = 3;
-- 동물 3마리를 testtbl3에 추가해보세요
INSERT INTO testtbl3 VALUES (null, '알파카',4);
INSERT INTO testtbl3 VALUES (null, '에뮤',2);
INSERT INTO testtbl3 VALUES (null, '토끼',1);
SELECT * FROM testtbl3;

INSERT INTO testtbl2 VALUES (null, '라마',3);
INSERT INTO testtbl2 VALUES (null, '연어',2);
SELECT * FROM testtbl2;
-- auto_increment 증가량 1로 수정
SET @@auto_increment_increment = 1;
-- testtbl2에 2개의 데이터를 더 추가하고 증가량이 돌아왔는지 체크해주세요ㅕ
-- CMD에서 해주세요
INSERT INTO testtbl2 VALUES (null, '낙타',4);
INSERT INTO testtbl2 VALUES (null, '뱀',1);

-- 하나의 INSERT INTO 구문으로 여러 row를 추가할때는
-- VALUES뒤쪽에 연달아 작성합니다.
INSERT INTO testtbl2 VALUES (null, '말', 4), (null, '오리',1), (null , '닭',2);

-- UPDATE 구문은 기존에 입력되어 있는 값을 변경할떄 사용합니다.
-- where 조건문을 걸지 않는다면 컬럼 하나의 값을 전부 바꿉니다.
-- 따라서 일반적으로는 무조건 조건절과 조합해서 사용합니다.
-- UPDEATE테이블명 SET 컬럼1 = 바꿀값1, 컬럼2 = 바꿀값2........;

-- testtlb2의 user_name을 전부 소로 바꾸는 구문;
UPDATE testtbl2 SET user_name = '소';

-- 워크밴치에서 WHERE문 없이 수정하고싶다면 safe_update모드를 헤제해야합니다.

SET SQL_SAFE_UPDATES = 0;

-- testtbl을 전부 말로 고쳐주세요
UPDATE testtbl2 SET user_name = '말';

-- 특정 나이대의 user_name을 여러분이 좋아하는 동물로 고쳐주세요.
-- WHERE을 이용해 age를 필터링해주세요.
-- 하나의 나이대만 우선 고쳐주세요.

UPDATE testtbl2 SET user_name = '소' WHERE age = 3;
UPDATE testtbl2 SET age = age * 2;
UPDATE testtbl2 SET age = age  / 2;

-- DELETE FROM 구문은 데이터를 삭제하는 구문입니다.
-- SELECT는 특정한 컬럼들만 조회하거나, 전체를 모두 조회하는 등의
-- 경우의 수가 있엇기때문에 select와 from 사이에 쿠체적인 컬럼명이나
-- 혹은 * 을 붙여서 전체컬럼을 조회했습니다.
-- DELETE 특정컬럼만 삭제하는 경우가 없고 삭제할꺼면 전체 row를 삭제하거나
-- 삭제를 안 해 버리거나 이기 떄문에
-- delecte와 from사이에 아무것도 적지 않습니다.
-- delete역시 일반적으로는 where절과 함께 사용합니다.
-- where없이 사용시 해당 테이블의 전체 데이터를 다 삭제합니다.
-- id 11에 해당되는 데이터만 삭제해보세요
delete from testtbl2 where id = 1;

-- limit을 사용하면 상위 n개만 삭제할수도 있습니다.
-- 검색결과물중 상위 2개만 삭제
delete from testtbl2 limit 2;
select * from testtbl2;

-- where절 없이 삭제하면 테이블 내의 전체데이터 삭제;
delete from testtbl2;

-- delete from은 삭제할때 시간이 조금더 오래 걸리는 편인데 이유는 
-- 트랜잭션 로그라는것을 한 로우마다ㅏ 작성하기 떄문입니다.
-- 따라서 속도를 끌어올리고 싶다면 TRUNCATE를 DELETE FROM대신 쓰는경우도 있습니다.
TRUNCATE TABLE testtbl2;

-- TRUNCATE와 DELETE FROM의 속도차이를 체험해보기 위해서
-- employees 테이블의 자료를 복사해보겠습니다.
CREATE TABLE testtbl4 (
	id int,
    first_name varchar(50),
    last_name varchar(50)
);

INSERT INTO testtbl4 (sELECT emp_no, first_name, last_name FROM employees.employees);
SELECT * FROM testtbl4;
-- Query OK, 300024 rows affected (1.61 sec)
-- Query OK, 0 rows affected (0.04 sec)
-- 속도적인 측면에서는 압도적으로 빠르지만
-- 삭제한 데이터의 기록이 남지않기때문에 보통은 속도가 느려도 delete를 더 많이 사용합니다.



-- 조건부로 데이터 입력하기
-- 예를 들어 100개의 데이터를 입력하려고 하는데 첫번쨰 자료만 
-- 기존 데이터의 id와 중복되는값이 있고, 이후 99건은 pk가 중복되지 않는다고 해도
-- SQl시스템상 전체 데이터가 입력되지않는 문제가 발생합니다.
-- 따라서 이때 중복되는 데이터 1건은 중복된다면 무시하고
-- 이후 나머지 99개 데이터는 중단없이 정상적으로 입력하도록 만들수 있습니다.
CREATE TABLE membertbl(
	user_id varchar(6) PRIMARY KEY,
    user_name VARCHAR(3) NOT NULL,
    addr VARCHAR(3) NOT NULL
);
drop table membertbl;
-- MYSQL은 구문을 통째로 묶어서 실행할경우 모두 실행하거나 모두 실행하지 않습니다.
INSERT INTO membertbl VALUES('LSH', '이상혁', '서울' );
INSERT INTO membertbl VALUES('HS', '허수', ' 울산' );
INSERT INTO membertbl VALUES('JJH', '정지훈', '인천' );

-- 추가 데이터를 입력하되 한건은 중복, 두건은 중복 없도록 세팅'
INSERT INTO membertbl VALUES('LSH', '이상혁', '서울' );
INSERT INTO membertbl VALUES('KHK', '김혁규', '경기' );
INSERT INTO membertbl VALUES('PDH', '박도현', '충정' );

SELECT * FROM membertbl;

-- 만약 PRIMARY KEY 가 겹치면 무시하고 그렇지 않으면 입력해주는 코드로 변환
-- INSET와 INTO 사이에 IGNORE
INSERT IGNORE INTO membertbl VALUES('LSH', '이상혁', '서울' );
INSERT IGNORE INTO membertbl VALUES('KHK', '김혁규', '경기' );
INSERT IGNORE INTO membertbl VALUES('PDH', '박도현', '충정' );

-- IGNORE는 기존 데이터를 유지하고 신규데이터를 막는 구문이였는데
-- 이미 존재하는 데이터가 있어도 신규데이터로 갱신해서 넣고싶은경우
INSERT INTO membertbl VALUES('LSH', '이성혁', '제주' );

-- ON DUPLICATE KEY UPDATE 구문을 쓰면 됩니다.
-- 기존 추가구문 뒤쪽에 ON DUPLICATE KEY UPDATE 컬럼명1 = '변경내역', 컬럼명2 = '변경내역'.... ;
-- 으로 적습니다.
INSERT INTO membertbl VALUES('LSH', '이성혁', '제주' )
	ON DUPLICATE KEY UPDATE user_name = '이성혁', addr = '제주';
    
    
-- ON DUPLICATE KEY UPDATE는 자료가 없으면 INSERT INTO 에 적힌 대로 데이터를 넣고
-- 자료가 곂치는 상황인 경우에 ON DUPLICATE KEY UPDATE를 실행하는 구문이기 떄문에
-- 만약 데이터가 겹치지 않아도 잘 작동합니다.
-- 기존 테이블 요소와 겹치지 않는것을 넣어서 잘 들어가는지 CMD를 이용해 실행한 후 확인해주세요.


-- [사용자 관리하기]
-- 현재 root계정은 모든 권한(수정, 삭제, 조회, 변경, 계정생성 등)
-- 을 가지고있는 계정입니다.
-- 그렇지만 모든 사람이 모든 권한을 가지는 일은 그만큼 DB접근이 용이해져서 위험을 내포하고 있으며
-- 작년 초에도 유명 게임사에서 DB를 날려먹은 사건이 발생한만큼
-- 이제 root가 아닌 사용자를 만들고. 그 사용자에 대해서
-- 권한부여를 하는 방법과 권한 개념에 대해 알아보겠습니다.

-- workbench에서 계정 생성 및 권한 부여하기.
-- 1. 좌측의 navigator에서 Administration탭을 클릭합니다.
-- 2. users and Privileges를 클릭한다음
-- 3. 열리는 화면에서 좌하단 add Account를 클릭한다음
-- 	Login name, password 등을 입력합시다.
-- 4. 우하단 apply를 누르면 계정생성이 완료됩니다.
-- 5. Account Limit는 시간당 기능 사용 가능 횟수를 설정합니다.
-- 6. Administrative Roles는 어떤 구문 실행까지 허용할지 입니다.alter



-- cmd 환경에서 생성하는 경우는
-- CREATE USER 계정명@'%' IDENTIFIED BY '비밀번호';
-- GRANT ALL on *.* TO 계정명@'%' WITH GRANT OPTION;
-- 위 두줄을 이용해서 생성할수도 있습니다.


-- 계정 접속 방법
-- 커맨드라인 접속시 mysql -u 계정명 -p 로 연결가능
-- 접속 후 show databases; 를 이용해 DB목록 확인가능
-- use mysql;
-- SELECT user, host FROM user; 를 할 경우 생성된 계정 목록 조회가능
show databases; -- DB목록 조회


-- icttest 계정을 만들어주세요. 권한은 따로 주지마세요.
CREATE USER icttest@'%' IDENTIFIED BY 'ictICT03';

-- 계정 권한 주기

-- workbench에서 주기
-- Navigator하단 Administration 에서 user선택후  Administration Roles에서 주고싶은권한을 체크해주시면 됩니다.
-- DBA선택시 모든권한 획득


-- 커맨드로 권한 주기
-- GRANT 권한1, 권한2... ON DB명.테이블명 TO 아이디@'%';
-- ict_practice 데이터베이스의 texttbl3 테이블에 대한 select, delete권한을 
-- icttest계정에 권한을 부여한다면
-- GRANT SELECT, DELETE ON ict_practice.testtbl3 To icttest@'%';
-- GRANT <권한1, 권한2....> ON 디비명.테이블명 To 계정명@'%';


