-- ict+practice를 쓰도록 해주세요.
use ict_practice;

-- 앞에 스키마명을 추가로 입력해 스키마명.테이블명으로 조회 가능
SELECT * FROM ict_practice.usertbl;

-- 유저를 두명만 더 추가해주세요.
-- 정보는 알아서 넣어주시되 키는 한명은 160대로 해주세요.
INSERT INTO usertbl VALUES ('KCS', '김책상',1998, '일산','0110011011', 160, '2022-01-03');
INSERT INTO usertbl VALUES ('LSH', '이상혁',1998, '서울','0110012321', 175, '2022-01-01');



SELECT * FROM usertbl;
-- 새로 추가한 2명의 구매내역을 추가해주세요.
-- 2명 구매내역 합산 3개를 추가해주세요.
INSERT INTO buytbl VALUES (null, 'KCS', '책상', '가구', 70000,1);
INSERT INTO buytbl VALUES (null, 'LSH', '게이밍마우스', '컴퓨터기기', 250000, 2);
INSERT INTO buytbl VALUES (null, 'KCS', '공책','학용품',3000, 1);

-- 여태까지 
-- 조회 시간이 굉장이 오래잡히는 케이스가 발생했습니다.
-- 따라서 조건에 맞도록 필터링을 할수 있고, 이를 위해서 사용하는 구문은 WHERE구문입니다.
-- SELECT 컬럼명1 ,컬럼명2 .. FROM테이블명 WHERE 컬럼명 = 조건식;

-- 아래는 이름이 손흥민인 사람만 조회하는 구문입니다.
SELECT * FROM usertbl WHERE user_name = '손흥민';

-- 서울에 사는 사람만 조회해보세요.
SELECT * FROM usertbl WHERE addr = '서울';

-- 관계연산자를 이용해서 대소비교를 하거나
-- and, or을 이용해 조건 여러개를 연결할수 있습니다.
-- 키 180이상인 사람만 조회해주세요.
SELECT * FROM usertbl WHERE height >= 180;

-- and를 이용해 91~99년생까지만 조회하는 구문을 만들어보세요.
SELECT * FROM usertbl WHERE (birth_year >= 1991) and (birth_year <= 1999);

-- BETWEEN ~ AND구문을 이용하면 birth_year를 한번만 적고도
-- 해당범위의 조회가 가능합니다.
-- 적은 두개의 숫자를 포함합니다.
SELECT * FROM usertbl WHERE birth_year BETWEEN 1991 AND 1999;

-- 위와 같이 숫자는 연속된 범위를 갖기떄문에 범위연산자로 처리가 가능하지만
-- addr같은 자료는 서울이 크다던가 영국이 작다던가 하는 연산적 처리가 불가능합니다.
-- 먼저 지역이 서울이거나 혹은 화성인 사람의 정보를 WHERE절로 조회해주세요.
SELECT * FROM usertbl WHERE (addr = '서울') OR (addr = '경기');

-- in키워드를 사용하면 컬럼명 in(데이터 1,2,3,4....);
-- 특정 컬럼에 괄호에 담긴 데이터가 포함되는경우 전부 출력합니다.
-- 경기, 화성, 영국에 있는 사람들만 in키워드로 조회해주세요.
SELECT * FROM usertbl WHERE addr in('서울', '경기', '일산');

-- like 연산자는 일종의 표현 양식을 만들어줍니다.
-- like 연산자를 이용하면 %라고 불리는 와일드 카드나 혹은 _라고 불리는
-- 와일드 카드 문자를 이용해 매칭되는 문자나 문자열을 찾습니다

-- 김씨를 찾는 케이스
-- 아래구문은 김로 시작하는 모든 요소를 다 가져옵니다. '김'도 포함
SELECT * FROM usertbl WHERE user_name like '김%';

-- 휴대폰 번호가 01로 시작하는 모든 사람을 찾아보세요.
SELECT * FROM usertbl WHERE phone_number like '01%';

-- 두글자만 찾는 케이스 (_는 하나에 한 글짜임)
SELECT * FROM usertbl WHERE user_name like '___';

-- user_id가 3글자이면서 H로 끝나는 사람만 조회해보세요.alter
SELECT * FROM usertbl WHERE user_id like '__H';

-- 서브커리(하위쿼리)란 1차적 결과를 얻어놓고,
-- 거기서 다시 조회구문을 중첩해서 날리는것을 의미합니다.
-- 안재영보다 키가 큰 사람을 조회하는 예시를 보겠습니다.

-- 원시적인 방법
-- 1. 안재영의 키를 WHERE절을 이용해 확인한다.
SELECT height FROM usertbl WHERE user_name = '안재영';
-- 2. 확인한 안재영의 키를 쿼리문에 넣는다.
-- 170보다 큰 사람의 키만 조회해보겠습니다.
SELECT user_name,height FROM usertbl WHERE height > 170;

-- 서브쿼리 활용 방법
-- 서브쿼리는 FROM절 다음에 ()를 이용해서
-- SELECT 구문을 한번더 활용합니다 
SELECT user_name, height FROM userTbl WHERE height > 
	(SELECT height FROM usertbl WHERE user_name = '안재영');

-- 서브쿼리를 활용해 '이상혁'보다 먼저 태어난 사람들만 골라내보세요.
SELECT user_name, birth_year FROM usertbl WHERE birth_year < 
	(SELECT birth_year FROM usertbl WHERE user_name = '이상혁');
   
-- 서브쿼리를 여러개넣엇더니 오류남 질문필요
-- SELECT user_name, addr FROM usertbl WHERE addr in (SELECT addr FROM usertbl WHERE user_name = '손흥민', SELECT addr FROM usertbl WHERE user_name ='안재영');

-- 최대값은 max()로 구합니다.
-- 최소값은 min()으로 구합니다.
-- 현재 user_tbl컬럼에서 가장 나이가 적은 사람의 생년 조회
SELECT max(birth_year) FROM usertbl;
-- 현재 user_tbl컬럼에서 제일 나이가 많은사람 생년조회
SELECT min(birth_year) FROM usertbl;


SELECT * FROM usertbl;
-- 2022 가입자 중 생년이 제일 빠른 사람보다 키가 큰 사람을 조회해주세요.
-- 날짜도 부등호로 조회 가능합니다.(작다:이전날짜, 크다: 이후날짜)
SELECT * FROM usertbl WHERE reg_date < '2021-01-01';

(SELECT height,birth_year,user_name,reg_date FROM usertbl WHERE reg_date < '2021-01-01');

SELECT height,birth_year,user_name FROM usertbl WHERE height = 
(SELECT max(height) FROM usertbl WHERE birth_year < 
(SELECT max(birth_year) FROM usertbl));

(SELECT max(height) FROM usertbl WHERE birth_year < (SELECT max(birth_year) FROM usertbl));

-- user_id에 M이 포함된 사람들중 키가 제일 작은 사람보다
-- 키가 더큰 사람을 구하시오.(min를 활용하세요)
SELECT user_id,user_name,height FROM usertbl WHERE height > 
(SELECT min(height) FROM usertbl WHERE user_id like '%M%');

-- 2020년 가입자중 가입일이 제일 빠른사람보다 키가 큰 사람을 조회해주세요.
-- 날짜도 부등호로 조회가 가능합니다.
SELECT height,user_name,reg_date FROM usertbl WHERE height >
(SELECT height FROM usertbl WHERE reg_date =
(SELECT min(reg_date) FROM usertbl WHERE reg_date >= '2020-01-01')) and reg_date < '2021-01-01';


-- 유저를 다섯명 더 추가하겠습니다.
INSERT INTO usertbl VALUES ('KJV', '김자바',1983, '서울','0118121011', 171, '2020-08-15');
INSERT INTO usertbl VALUES ('ADR', '압둘라',1995, '경기','0111723321', 183, '2021-04-01');
INSERT INTO usertbl VALUES ('YSO', '야스오',2001, '부산','0112361011', 165, '2021-10-08');
INSERT INTO usertbl VALUES ('ZYA', '장위안',1985, '부산','0104632321', 164, '2020-02-28');
INSERT INTO usertbl VALUES ('SPR', '스프링',1987, '강원','0103211011', 184, '2021-12-31');
INSERT INTO usertbl VALUES ('JSP', '자스피',1989, '전라','0101341011', 177, '2022-01-01');

-- ANY, ALL, SOME 구문은 서브쿼리와 조합해서 사용합니다.
-- 지역이 서울인 사람보다 키가 작은사람을 찾는 쿼리문
-- 1. 서울사람의 키 전체 리스트 가져오기
SELECT height FROM usertbl WHERE addr = '서울';

SELECT * FROM usertbl WHERE height < (SELECT height FROM usertbl WHERE addr = '서울');
-- 위 구문을 서브쿼리로 해서 서울사람보다 키가 작은 사람을 찾을경우 에러가 납니다.
-- 현재 데이터셋은 결과가 169 171 186 3개인데 어느 데이터를 기반으로
-- height 을 조건에 잡아줄지 모호하기 떄문에 에러가 납니다.


-- ANY 구믄을 사용하면 169, 171, 186 모든 데이터에 대해 OR로 처리가 됩니다.
-- 개별값 모두에 대해 OR처리가 붙고 그래서 아래와 같이
-- (height < 169) OR (height < 171) OR (height <186)
-- 3개 조건이 OR로 연결됩니다.
-- 186보다 작은데이터는 전부 잡혀나옵니다
SELECT * FROM usertbl WHERE height < 
ANY(SELECT height FROM usertbl WHERE addr = '서울');

-- ALL 구문을 사용하면 169, 171, 186 모든 데이터에 대해 AND로 처리됩니다.
-- 개별값 모두 대해 AND가 붙고 그래서 아래와 같이
-- (height < 169) AND (height < 171) AND (height <186)
-- 3개 조건이 AND로 연결됩니다.
-- 169보다 작은값만 잡혀나옵니다.
SELECT * FROM usertbl WHERE height < 
ALL(SELECT height FROM usertbl WHERE addr = '서울');

-- SOME은 ANY와 큰 차이가 없읍니다.








