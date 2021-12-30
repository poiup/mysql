/* 1. 데이터 베이스 생성 명령
DB생성시 한글을 쓸수 있도록 -> default character set utf8; */
create database ict_practice default character set utf8;

/* 우측 하단의 schemas 클릭 후, 새로고침 한 다음 ict_practice 우클릭
	-> set as default schema를 클릭하세요. 이러면 현재 명령을 받을 DB로 지정됩니다. */
    
/* default schema 지정은 명령어로도 할수 있습니다.
use 스키마명; 을 사용하면 좌측 schemas에서 우클릭후 default스키마 지정한 효과를
낼 수도 있습니다.*/
use sys;
use ict_practice;
  
/* 테이블 생성 명령
primary key - 컬럼의 주요키를 뜻하며, 중복데이터를 방지합니다.
테이블 내의 하나의 컬럼은 반드시 primary key 속성을 가져야 합니다.
not null -> 데이터에 null 값이 들어오는것을 막습니다. */
  
/* 테이블은 클래스랑 구조가 비슷합니다. 클래스 내부의 맴버변수를 지정하듯이
테이블 요소를 지정해줄수 있습니다 */
/*varchar 는 자바의 String과 호환됩니다.*/
    
CREATE TABLE users(
	id varchar(20) primary key,
    pw varchar(20) not null,
    user_name varchar(30) not null,
    email varchar(80)
);

/* 데이터 적재하기
INSERT INTO 테이블명 (컬럼1, 컬럼2...) VALUES (컬럼1, 컬럼2,....);
만약 모든 컬럼을 대상으로 지정시 컬럼은 생략하고 VALUES 이후 값만 지정할수 있다.
INSERT INTO 테이블명 VALUES(컬럼 1값, 컬럼2값, ....); 
*/

INSERT INTO users (id, pw, user_name, email) VALUE ( 'abc1234', 'asdf', '김자바', 'asd@asd.com');
INSERT INTO users VALUES ('qwer123', 'qwer', '쿼리문', 'qwer@qwe.com');


-- 한줄 주석은 자바와 달리 -- 내용을 적어 작성할수 있습니다
-- 여러분들이 계정 3개를 더 넣어주시되, 1개 계정은 이메일을 생략하고 넣어주세요.
-- 이메일 없이 넣는 경우는 컬럼명을 반드시 표기해줘야합니다
INSERT INTO users VALUES ('asdf09', 'fdw', '마이', 'asd@qwe.com');
INSERT INTO users VALUES ('qsqd123', 'qsd', '에스', 'qsqd123@qwe.com');
INSERT INTO users VALUES ('zsdq544', 'zsd', '큐엘', null);
/* 데이터 조회하기
SELECT 컬럼1, 컬럼2, ... FROM 테이블명;
을 적으면 테이블에 적재된 데이터 조회 가능
SELECT * FROM 테이블명; 으로 조회시 해당 테이블의 전체 칼럼 조회가능;
*/

-- 조회 구문에 조건을 걸기 위해서 WHERE이라는 구문을 사용합니다.
-- SELECT 조회컬럼 FROM 테이블명 WHERE 컬럼명 =  조건에 맞는 값
-- 이름이 김자바인 사람만 출력하기
SELECT * FROM users;
SELECT * FROM users WHERE user_name = '김자바';
-- 여러분들의 기준으로 필터링 해 보세요.
-- 아이디가 XXX인 사람만 출력해보세요

SELECT * FROM users WHERE id = 'javajava';

-- 조건 여러개를 걸 경우 AND, OR 키워드를 쓰면 됩니다.
-- 아이디가 mysqlsql이거나 혹은 유저이름이 김자바인 것들을 얻어오기
SELECT * FROM users WHERE id = 'mysqlsql' OR user_name = '김자바';

/* 데이터 수정하기
UPDATE 테이블명 SET 컬럼명1='값1', 컬럼명2='값2' ...;
주의할점은 WHERE구문 없이 사용하면 일괄적으로 컬럼 내의 모든값이 다 바뀝니다.
*/

SET SQL_SAFE_UPDATES = 1; -- 0이면 비활성화 1로주면 다시 safety모드 활성화
UPDATE users SET pw = 'pppp';
SELECT * FROM users;

-- WHERE구문을 이용해서 pw컬럼의 값을 모두 다르게 바꿔주세요
 UPDATE users SET pw = '123' WHERE id = 'abc1234'; 
 UPDATE users SET pw = 'asd' WHERE id = 'asdf09';
 UPDATE users SET pw = 'aqsd' WHERE id = 'aqsd123'; 
 UPDATE users SET pw = 'qwer' WHERE id = 'qwer123'; 
 -- 여러분들이 원하는 로우(row)하나에 대해서 이름과 비밀번호를 함께 바꿔주세요.
 UPDATE users SET pw = 'hello', user_name = '안녕' WHERE id = 'zsdq544';  
 
 -- 데이터 삭제
 /*DELETE FROM 테이블명; 을 할경우 테이블 전체 데이터가 싹 다 날라갑니다
 DELETE구문 역시 WHERE과 조합해서 사용해야됩니다.
-- 테이블 삭제
 drop table 테이블명 을 하면 테이블 자체를 날릴수 있습니다.
 */
 DELETE FROM users WHERE id ='abc1234';

CREATE TABLE library(
	book_name varchar(30) primary key,
    book_price int(7) not null,
    book_pub varchar(20) not null,
    book_writer varchar(10) not null,
    book_page int(7) not null
);

INSERT INTO library values ('브레이킹 루틴 원하는 인생은 늘 안전지대 밖에 있다', 14400,'중앙북스', '천인우', 154);
INSERT INTO library VALUES ('부자의 운', 12600, '다산북스', '사이토 히토리', 98);
INSERT INTO library VALUES ('The Secret 시크릿',10920, '살림Biz', '론다 번', 247);
INSERT INTO library VALUES ('어린 왕자',10200,'달리','생텍쥐페리',232);
INSERT INTO library VALUES ('기적의 유아영어 영단어', 10800,'길벗스쿨', '조희주', 123);
INSERT INTO library VALUES ('아몬드', 10800, '창비', '손원평', 239);

SELECT * FROM library;