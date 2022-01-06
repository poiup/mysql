

-- [조인(join)]
-- 테이블 2개를 합쳐주는 기능
-- 연관된 데이터 여러 테이블에 나눠담았을때
-- 그것을 다시 재조립해줍니다.
-- 조인 문법
-- SELECT 테이블1.컬럼, 테이블1.컬럼2, 테이블2.컬림1, 테이블2,컬럼2....
-- 		FROM 테이블1 조인구문 테이블2
-- 		ON 테이블1.공통컬럼 = 테이블2. 공통컬럼;
--		WHERE구문은 ON으로 합쳐진 결과컬럼에 대한 필터링을 해줍니다.

use ict_practice;
SELECT * FROM buytbl INNER JOIN usertbl ON buytbl.user_id = usertbl.user_id;
SELECT * FROM usertbl;
SELECT * FROM buytbl;

-- 지금 현재 구매자 정보를 조회하려고 하는데, 필요한 정보는
-- buytbl의 구매 물품정보 전체에, 구매자 정보는 택배를 받기 위해서
-- 이름, 주소, 휴대폰번호만 있으면 되는 상황입니다.
-- 조인 구문을 활용해 필요한 컬럼만 출력되게 수정해주세요
SELECT buytbl.*, usertbl.user_name, usertbl.addr, usertbl.phone_number
	 FROM buytbl INNER JOIN usertbl ON buytbl.user_id = usertbl.user_id;
     
--  FROM 구문에서 테이블명만 적는게 아니라, 테이블명 별명 형식으로 적을경우는
-- 테이블명을 풀로 적지 않고 별명으로 대체해서 호출할수 있어 좀 더 편리합니다.
-- 현재 *로 처리된 부분을
-- buytbl의 구매 물품 정보 전체에, 구매자 정보는 택배를 받기 위해서
-- 이름,주소, 휴대번호만 있으면 되는상황입니다.
-- 위에적힌 컬럼조회하는 부분으로 고쳐주세요.

SELECT b.order_number, b.user_id, b.prod_name, b.group_name, b.price, b.amount, u.user_name, u.addr, u.phone_number FROM buytbl b INNER JOIN usertbl u ON b.user_id = u.user_id;
     
SELECT * FROM buytbl b INNER JOIN usertbl u on b.user_id = u.user_id;

-- where절은 먼저 join구문의 결과가 나온상태에서, 추가 필터링만을 담당합니다.
-- 구매 물품의 가격이 50000원 이상인것만 남기는 구만
SELECT b.order_number, b.user_id, b.prod_name, b.group_name, b.price, b.amount, u.user_name, u.addr, u.phone_number 
FROM buytbl b INNER JOIN usertbl u ON b.user_id = u.user_id WHERE price >= 50000;
  
-- 위쪽 JOIN구문을 활용하시되, 가격이 200000원 이하인 품목만 남겨주시고
-- 그 남은 자료들을 가격순으로 내림차순 출력해주세요.
SELECT b.order_number, b.user_id, b.prod_name, b.group_name, b.price, b.amount, u.user_name, u.addr, u.phone_number 
FROM buytbl b INNER JOIN usertbl u ON b.user_id = u.user_id WHERE price <= 200000 ORDER BY price DESC;
  

-- inner join은 양쪽 테이블 모두에 존재하는 데이터만 출력
-- left join은 왼쪽테이블의 데이터는 전부넣는다 오른쪽 데이터는 왼쪽과 매칭되는것은 남기고 나머지는 null처리를 한다.
-- right join은 오른쪽 테이블의 데이터를 전부 넣은뒤 왼쪽 데이터는 오른쪽에 매칭되는것만 채워준다
-- full outer join은 왼쪽과 오른쪽 모든데이터를 다 살립니다.

-- LEFT JOIN, RIGHT JOIN은 공통데이터가 아닌 데이터도 방향에 따라
-- 출력이 되기 때문에 공통데이터(INNER)가 아닌 데이터(OUTER)까지
-- 출력되는 점을 이용해 OUTER JOIN이라고 부릅니다.
-- LEFT OUTER JOIN은 JOIN구문의 왼쪽 테이블의 자료는 모두 출력하고 
-- 오른쪽 테이블 데이터는 왼쪽 기준 컬럼과 일치할때만 출력합니다.
-- 반대로 right outer join은 join구문의 오른쪽 테이블의 자료는 전부 출력하고
-- 왼쪽 테이블 데이터는 오른쪽 테이블의 기준컬럼과 일치할때만 출력합니다
SELECT * FROM usertbl; -- 11명
SELECT * FROM buytbl;  -- 5명

-- LEFT JOIN인데, usertbl를 left에, buytbl을 right에 두고 작성해주세요.
-- inner join을 넣은자리에 대신 left outer join으로 고쳐주시기만 하면 작동합니다.
-- 테이블의 컬럼은 전체 출력합니다.
SELECT * from usertbl left outer join buytbl on usertbl.user_id = buytbl.user_id;

-- right JOIN인데, usertbl를 right에, buytbl을 left에 두고 작성해주세요.
-- inner join을 넣은자리에 대신 right outer join으로 고쳐주시기만 하면 작동합니다.
-- 테이블의 컬럼은 전체 출력합니다.
SELECT * from buytbl right outer join usertbl on usertbl.user_id = buytbl.user_id;

-- FULL OUTER JOIN은 누락데이터 없이 양쪽 테이블의 모든 자료를 보여줍니다.
-- ORACLE SQL에는 FULL OUTER JOIN을 구문으로 지원하지만 MYSQL에서는 
-- FULL OUTER JOIN을 UNION명령어를 이용해
-- LEFT OUTER JOIN과 RIGHT OUTER JOIN의 결과물을 합쳐서 구현합니다.
-- 이 떄 접점이 없는 데이터는 반대쪽 데이터를 NULL로 가집니다.
-- UNION은 위쪽 결과물과 아래쪽 결과물을 합쳐줍니다.
SELECT * FROM buytbl b LEFT OUTER JOIN usertbl u ON b.user_id = u.user_id
	UNION -- UNION구문은 위 아래 결과 화면을 합쳐줍니다.
SELECT * FROM buytbl b RIGHT OUTER JOIN usertbl u ON b.user_id = u.user_id;

-- FULL OUTER JOIN 이해를 돕기위한 추가 데이터 설정
CREATE TABLE student(
	user_name varchar(3) primary key,
    user_addr char(2) not null
);

CREATE TABLE membership(
	user_name varchar(3) primary key,
    user_point int not null
);

INSERT INTO student VALUES ('강건마','서울');
INSERT INTO student VALUES ('노영웅','수원');
INSERT INTO student VALUES ('이상용','인천');
SELECT * FROM student;

INSERT INTO membership VALUES ('강건마', 15000);
INSERT INTO membership VALUES ('노영웅', 37000);
INSERT INTO membership VALUES ('김철수', 500);
SELECT * FROM membership;

-- 위 데이터셋(학생 student, 회원 포인트 membership) 에 대해 left조인을 해주세요.
-- 아래 구문을 FULL OUTER JOIN으로 바꿔주시고 결과를 보내주세요
SELECT s.user_name,s.user_addr,m.user_point FROM student s LEFT OUTER JOIN membership m ON s.user_name = m.user_name 
 UNION 
SELECT s.user_name,s.user_addr,m.user_point FROM student s RIGHT OUTER JOIN membership m ON s.user_name = m.user_name;

