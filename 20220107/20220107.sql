-- 위 데이터셋(학생 student, 회원 포인트 membership) 에 대해 left조인을 해주세요.
-- 아래 구문을 FULL OUTER JOIN으로 바꿔주시고 결과를 보내주세요
SELECT * FROM student s LEFT OUTER JOIN membership m ON s.user_name = m.user_name 
 UNION 
SELECT * FROM student s RIGHT OUTER JOIN membership m ON s.user_name = m.user_name;

-- 위의 UNION으로 처리되는 구문은 user_name이 두번 출력되는 문제가 있스비낟.
-- 한번만 출력되게 바꿔주세요

-- left join에서는 왼쪽 값을 전부 살리기위해 student의 유저네임을 받아오고
SELECT s.user_name,s.user_addr,m.user_point FROM student s LEFT OUTER JOIN membership m ON s.user_name = m.user_name 
 UNION 
 -- right join에서는 오른쪽 값을 다 살리기위해 membership의 유저네임을 받아온다.
SELECT m.user_name,s.user_addr,m.user_point FROM student s RIGHT OUTER JOIN membership m ON s.user_name = m.user_name;
-- 그러면 4개의 유저네임과 값을 전부 살릴수 있다.

/*  MYSQL에서도 프로그래밍이 가능하고
변수나 함수를 지정할수 있습니다.
물론 java와 Python, CPP등의 프로그래밍과는 달리
제한되는 점이 많지만, 이를 활용하는 경우가 빈번하기 때문에
먼저 변수 지점및 출력부터 진행하겠습니다.  */

-- <MySQL에서 변수 사용하기>

-- MySQSL에서 변수를 지정할떄는 SET @변수명 = 값;의 문법을 씁니다.
SET @myVar1 = 5;
SET @myVar2 = 3;
SET @myVar3 = 4.25;
SET @myVar4 = '가수의 이름 =>';

-- 변수에 지정된 값을 출력할때는 SELECT @변수명; 을 사용합니다.
-- @myVar1을 출력해보세요.

SELECT @myVar1;

-- 만약 계산식등이 있다면 SELECT 구문 실행 이전에
-- 계산을 모두 마치고 그 결과를 화면에 보여줍니다.
SELECT @myVar1 + @myVar3;

-- SELECT구문이 그렇듯 , 를 이용해서
-- 출력데이터를 여럿 나열할수도 있습니다.
SELECT @myvar4, user_name FROM usertbl;

-- 일반 구문에서는 LIMIT에는 변수를 입력해서 쓸수 없습니다.
SELECT * FROM usertbl limit 3;
-- SELECT * FROM usertbl limit @myVar2; (불가능)

-- prepare 구문
-- PREPARE 구문은 가변적으로 들어갈 문장요소 자리를
-- ?로 구멍을 뚫어놓고, 그 자리를 채우는 방식으로 만듭니다.
-- 사용법은
-- PREPARE 구문이름
--       FROM '실제 쿼리문'
-- 방식으로 선언해두고
-- 호출은 EXEUTE 구문이름 USING 전달변수;
-- 로 호출합니다.

-- myVar5 변수에 3을 저장해보세요.
SET @myVar5 = 3;

PREPARE myQuery
	FROM 'SELECT user_name, height FROM usertbl LIMIT ?';

-- myQuery 실행하기
EXECUTE myQuery USING @myVar5;

-- <MySQL의 데이터형식과 형 변환>
-- 데이터 변환시는 CAST(), CONVERT()등의 함수를 이용해서 처리하면 됩니다.
-- 두 함수의 차이는 거의 없습니다.

-- 문법
-- CAST(실행문 as 바꿀자료형);
-- CONVERT(실행문, 바꿀자료형);
SELECT avg(amount) FROM buytbl; -- 실수 (double)로 나오는 평균구매수

SELECT CAST(avg(amount) as SIGNED INTEGER) FROM buytbl;

-- CONVERT를 써서 자료형을 바꿔 출력해보세요.
SELECT CONVERT(avg(amount), SIGNED INTEGER) FROM buytbl;

-- CAST를 이용하면 날짜 양식을 통일시킬수 있습니다.
SELECT CAST('2022$01$07' as DATE);
SELECT CAST('2022/01/07' as DATE);
SELECT CAST('2022%01%07' as DATE);
SELECT CAST('2022@01@07' as DATE);
SELECT CAST('2022.01.07' as DATE);

-- Oracle SQL에서는 sysdate,  MySql에서는 now()를 이용해
-- 현재 시각을 확인할수 있습니다.
SELECT now();

-- <암시적 형 변환(자동 형 변환)>
SELECT '100' + 200; -- 문자와 숫자연산시 숫자로 변환;
SELECT '100' + '200'; -- 문자와 문자연산시 숫자로 변환;
SELECT '가나다' + 200; -- 연산할수 없는 문자 와 숫자연산시 숫자만 남음;

-- 만약 문자를 붙여서 출력하고 싶다면 concat()을 황용한다.
SELECT concat(100,200); -- 정수와 정수붙이기 100200출력
SELECT concat('100',200); -- 문자와 정수붙이기 100200출력
SELECT concat('100','200'); -- 문자와 문자붙이기 100200출력

-- 문자는 첫머리에 숫자가 포함된 경우 :  첫 글자를 숫자로 변환
-- 문자만 있는 경우 : 0 으로 변환
-- 문자끼리의 비교 abc순이 뒤로갈수록 높은수;
-- 논리식의 경우 0은 false, 1은 true;
SELECT 3 > '2mega';
SELECT 1 > 'amega';
SELECT 'b' > 'a';


-- <MySQL 내장함수>
-- CONcat, CAST, CONVERT 등과 같이
-- 내부에 이미 선언되어있어서 바로 호출해서 쓸수 있는
-- 함수들을 보겠습니다.

-- if(수식, 참일때 리턴, 거짓일때 리턴);
-- 삼항연산자와 비슷하게 판단합니다.
SELECT IF(300>200, '참입니다', '거짓입니다');

-- IFNULL(수식1, 수식2)
-- 수식1이 NULL이 아니면 수식1이 반환, 수식1이 null이면 수식2가 반환;
SELECT IFNULL(null, '널입니다'), IFNULL(100,'널입니다');

-- NULLIF(수식1,수식2)
-- 수식1이 수식2와 같으면 NULL 반환 , 다르면 수식1 반환
SELECT NULLIF(100,100), NULLIF(100,200);

-- CASE~WHEM~ELSE~END
-- SWITCH ~ CASE문과 비슷하게
-- 들어온자료와 일치하는 구간이 있으면 출력
-- 없을때는 ELSE쪽 자료를 출력
-- 단 SQL {}로 코드 시작, 끝나는 범위를 표현하지 않기때문에
-- 구문이 끝나는 시점에 END를 써워야 합니다.
SELECT CASE @myVar2
	WHEN 1 THEN '일'
    WHEN 2 THEN '이'
    WHEN 3 THEN '3'
    WHEN 10 THEN '십'
    ELSE '모름'
END as '결과';

-- <문자열 함수>
-- 문자열을 조작하는데 쓰고 활용도가 높은 편입니다.
-- ASCII(문자), CHAR(숫자)fmf sjgdjaus
-- 문자는 숫자로, 숫자는 문자로 바뀝니다.
-- CHAR()는 workbench상에 버그로 인해 모든문자가 BLOB로 표현되고있습니다.
-- 원래 값을 보려면 BLOB -> 우클릭 -> Open value in viewer -> text탭 선택
SELECT ASCII('s'), char(115);

-- 문자열의 길이를 그때그때 확인하기 위해서는
-- CHAR_LENGTH(문자열)을 사용합니다.
-- 이떄 결과로 나오는 숫자는 문자열의 길이입니다.
SELECT CHAR_LENGTH('가나다라마바사');
SELECT CHAR_LENGTH('asdasdfsagasdf');
SELECT CHAR_LENGTH(CONCAT('가', '나', '다', '라'));

-- CONCAT_WS('구분자', 문자열1, 문자열2 ........);
-- 문자열과 문자열 사이를 구분자를 이용해서 붙여줍니다.
SELECT CONCAT_WS('--', 1,2,3,4,5,10,22);

-- FORMAT(숫자, 소수점자리)
-- 소수점 몇번째자리 까지 표현할지 정합니다.
-- 원하는 자리 아래는 반올림하여 표현합니다.
SELECT FORMAT(1.1236, 3);

-- BIN(숫자), HEX(숫자), OCT(숫자)
-- 2진수    .16진수,   , 8진수
-- 정수로 10진수 숫자를 변환해서 표현해줌
SELECT BIN(10), HEX(10), OCT(10);

-- INSERT(기준문자열, 위치, 길이, 삽입할 문자열);
-- 기준문자열의 위치~길이 사이를 지워주고, 그 사이에
-- 삽입할 문자열을 새로 넣어줍니다.
SELECT INSERT('abcdefghi', 3,4, '@@@@@');
-- 3번째(c) 부터 4개를 지운뒤 (f까지) @@@@@을 넣는다

-- LEFT(문자열, 길이), RIGHT(문자열, 길이)
-- 왼쪽 또는 오른쪽부터 길이만큼의 문자만 남김
SELECT LEfT('abcdefghi', 3), RIGHT('abcdefghi', 3);


-- UCASE(영문자열), LCASE(영문자열)
-- UACSE() : 소문자를 대문자로
-- LCASE() : 대문자를 소문자로
SELECT UCASE('asd'), LCASE('asd');

-- UPPER, LOWER로 사용하기도 합니다
SELECT UPPER('asd'), LOWER('asd');

-- LPAD(문자열, 길이, 채울문자열), RPAD(문자열, 길이, 채울문자열)
-- 문자열을 길이만큼 늘려놓고, 빈 칸에 채울 문자열을 채워줍니다.
-- 채울 문자열이 길이보다 짧으면 채울떄까지 반복하게됩니다.
SELECT LPAD('이것이', 5, '#~'), RPAD('저것이', 6, '#~');

-- LRTIM(문자열), RTRIM(문자열)
-- 문자열의 왼쪽/오른쪽 부분의 공백을 모두 없애줍니다.
-- 단 가운데 부분 공백은 사라지지않습니다.
SELECT LTRIM('            이것이'), RTRIM('저것이       ');
SELECT '               이것이','저것이          ';
SELECT LTRIM(RTRIM('                   이것저것이                  '));

-- TRIM(문자열), TRIM(방향 ' 자를문자' FROM '대상문자')
-- TRIM은 기본적으로 LTRIM + RTRIM 형식으로 양쪽의 모든공백을 다 삭제해줍니다.
-- 공백이 아닌 특정문자를 삭제하도록 구문을 지정할수도 있습니다.
SELECT TRIM('                 a               ');

-- 방향은 BOTH(양쪽), LEADING(왼쪽), TRAILING(오른쪽)
-- 중 하나를 고르면됩니다.
SELECT TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅇㅋㅋㅋㅋㅋㅋㅋㅋㅋ'),
TRIM(LEADING 'ㅋ' FROM 'ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅇㅋㅋㅋㅋㅋㅋㅋㅋㅋ'),
TRIM(TRAILING 'ㅋ' FROM 'ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅇㅋㅋㅋㅋㅋㅋㅋㅋㅋ');

-- REPEAT(문자열, 횟수);
-- 횟수만큼 문자열을 반복합니다.
SELECT REPEAT('ㅋ',10);

-- REPLACE(문자열, 원래문자열, 바꿀문자열)
-- 문자열에서 원래 문자열을 찾아 바꿀문자열로 교체합니다.
SELECT REPLACE('JAVA로 작성되었습니다. JAVA', 'JAVA', 'MySQL');

-- REVERSE(문자열)
-- 문자열을 인덱스 역순으로 재배치해줍니다.
SELECT REVERSE('MYSQL');

-- SPACE(길이)
-- 길이만큼 공백을 사이에 넣어줍니다.
SELECT CONCAT('이것이', SPACE(50), '저깃이');

-- SUBSTRING(문자열, 시작위치, 길이);
-- SUBSTRIGN(문자열 FROM 시작위치 FOR 길이);
-- 시작위치부터 길이만큼의 문자를 반환합니다.
-- 길이를 생략하고 파라미터를 2개만 주면
-- 시작지점 부터 끝까지 모든 문자를 반환합니다.
SELECT SUBSTRING('자바스프링마이에스엘',6,4);
SELECT SUBSTRING('자바스프링마이에스엘' FROM 6 FOR 4);

-- <SQL 프로그래밍과 프로시저>
-- SQL에서도 변수선언이 되는걸 봤엇지만
-- 심지어 프로그래밍을 진행할수도 있습니다.
-- 문법
-- DELIMITER $$ -- 시작지점
-- CREATE PROCEDURE 선언할 프로시저이름()
-- BEGIN -- 실제 실행코드는 BEGIN 아래에 작성합니다.
-- 		실행코드...
-- END $$
-- DELIMITER ;

-- 선언해둔 프로시저는
-- CALL  프로시저명(); 으로 호출 가능합니다.

-- IF~ELSE 문을 프로시저로 작성

DELIMITER $$ 
CREATE PROCEDURE ifProc()
BEGIN
	DECLARE var1 INT;
    SET var1 = 1000;
    IF var1 = 100 THEN
		SELECT '100이 맞습니다.';
	ELSE
		SELECT '100이 아닙니다.';
	END IF;
END $$
DELIMITER ;
CALL ifProc();

DROP procedure ifProc;
-- 프로시저 삭제는 DROP PROCEDURE 프로시저명;()는 빼고적습니다.

-- 데이터 호출 구문을 프로시저로 만들어 보겠습니다.
-- getUser()를 만들어주세요. usertbl을 조회해줍니다.
-- 만들고나서 호출까지 해주세요

DELIMITER $$
CREATE PROCEDURE getUser()
BEGIN	# 프로세서 내부에서 주석쓰는법
	SELECT * FROM usertbl;
END $$
DELIMITER ;

CALL getUser();
	
-- 프로시저를 활용해 employees 테이블의 10001번 직원의
-- 입사일이 5년이 넘었는지 여부를 확인해보겠습니다.
-- hire_date 컬럼의 DATE자료를 이용해 판단합니다.
use employees;
use ict_practice;
DELIMITER $$
CREATE PROCEDURE checkFiveYear()
	BEGIN
		DECLARE hireDATE DATE; # 입사일 얻어오기
        DECLARE todayDATE DATE; # 오늘 날짜 얻어오기
        DECLARE days INT; # 오늘날짜 - 입사일 해서 경과일수 얻어오기
        
        SELECT hire_date INTO hireDATE
			FROM employees WHERE emp_no = 10001;
		# hire_date INTO hireDATE는
        # 위 쿼리문의 결과로 나온 10001번 직원의 hire_date의 값을 hireDATE에 저장해줍니다.
        
        SET todayDATE = CURRENT_DATE(); # 오늘날짜를 구해오는 기본기능
        SET days = DATEDIFF(todayDATE, hireDATE); # todayDATE - hireDATE를 수행
        
        #경과일수를 구하는 조건문
        IF (days/365) >= 5 THEN # 입사경과일을 365로 나눠서 5년 이상인지 체크
			SELECT CONCAT('입사한지', days, '일이 경과했습니다.');
		ELSE
			SELECT CONCAT('5년미만이고, ', days, '일쨰 근무중.');
		END IF;
	END $$
DELIMITER ;

DROP procedure checkFiveYear;
CALL checkFiveYear();


-- 10001이라는 값을 직접 내부에 선언하지 않고 그때그때 프로시저를 호출할때마다
-- 값을 바꿔넣을수 있도록 파라미터 처리를 하겠습니다.
DELIMITER $$
CREATE PROCEDURE checkFiveYear2(
	emp_number INTEGER
)
BEGIN
	DECLARE hireDATE DATE; # 입사일 얻어오기
    DECLARE todayDATE DATE; # 오늘 날짜 얻어오기
    DECLARE days INT; # 오늘날짜 - 입사일 해서 경과일수 얻어오기

	SELECT hire_date INTO hireDATE
			FROM employees WHERE emp_no = emp_number;
	# hire_date INTO hireDATE는
    # 위 쿼리문의 결과로 나온 10001번 직원의 hire_date의 값을 hireDATE에 저장해줍니다.
    
    SET todayDATE = CURRENT_DATE(); # 오늘날짜 구해오는 기본기능
    SET days = DATEDIFF(todayDATE, hireDATE); # todayDATE - hireDATE를 수행
    
    # 경과일수 구하는 조건문
    IF (days/365) >= 5 THEN # 입사후 5년인지 체크
		SELECT CONCAT ('입사한지', days,'일이 경과했습니다');
	ELSE
		SELECT CONCAT ('5년 미만이고', days,'일째 근무중');
	END IF;
END $$
DELIMITER ;

CALL checkFiveYear2(10002);
