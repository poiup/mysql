create database question default character set utf8;
use question;
DROP TABLE student;
DROP TABLE class;

/* 1차 정규화
CREATE TABLE student (
	sNum int(5) primary key,
    sName varchar(7) not null,
    gender varchar(1) not null,
    lecture varchar(20) not null
);

INSERT INTO student VALUES (1, '개발왕', '여', '자바');
INSERT INTO student VALUES (1, '개발왕','여', '파이썬');
INSERT INTO student VALUES (2, '헬린이','여', '자바');
INSERT INTO student VALUES (2, '헬린이','여', '자바스크립트');
INSERT INTO student VALUES (3, '고양이','남','파이썬');
INSERT INTO student VALUES (3, '고양이','남','c');
INSERT INTO student VALUES (4, '강아지','남','c');
INSERT INTO student VALUES (4, '강아지','남','CPP');
*/ 

SELECT * FROM question.student;
SELECT * FROM question.class;
CREATE TABLE student (
	sNum int(5) primary key,
    sName varchar(7) not null,
    gender varchar(1) not null
);

INSERT INTO student VALUES (1, '개발왕', '여');
INSERT INTO student VALUES (2, '헬린이','여');
INSERT INTO student VALUES (3, '고양이','남');
INSERT INTO student VALUES (4, '강아지','남');

CREATE TABLE class (
	sNum int(5),
    lecture varchar(20) not null
);

INSERT INTO student VALUES (1,'자바');
INSERT INTO student VALUES (1,'파이썬');
INSERT INTO student VALUES (2,'자바');
INSERT INTO student VALUES (2,'자바스크립트');
INSERT INTO student VALUES (3,'파이썬');
INSERT INTO student VALUES (3,'C');
INSERT INTO student VALUES (4,'C');
INSERT INTO student VALUES (4,'CPP');


