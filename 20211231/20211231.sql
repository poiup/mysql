create database employees default charset utf8;

use employees;

-- employees 내부의 employees 테이블을 조회해주세요.
-- SQL 구문은 멸령문자는 무조건 대문자, 테이블명이나 호칭 등은
-- 소문자로 작성하는것이 관례입니다.
-- 무조건 지키지 않아도 실행은 가능합니다.
SELECT * FROM employees;

-- 원래 테이블 조회할때는 스키마명.
SELECT * FROM employees.employees;

-- 스키마명.테이블명으로 조회시 use를 사용하지 않고 바로 조회가능
SELECT * FROM ict_practice.users;

-- 컬럼을 전체가 아닌 임의로 가져올때는 컬럼명을 ,로 구분합니다
-- 의 경우 모든 컬럼이 아닌 일부 컬럼만 조회할 수도 있으며
-- 심지어 한개의 컬럼만 조회하는등 개수조절도 가능합니다.
SELECT gender, first_name, last_name FROM employees;

-- CMD환경에서는 좌측 스키마처럼 스키마 목록을 보여주는 창이 없으므로 
-- 아래 명열어를 이용해 SCHEMA 목록을 확인할수 있습니닫.
SHOW databases;

-- 현재 DB정보를 조회하기 위해서는 
SHOW TABLE STATUS;

-- 특정 테이블의 컬럼 정보를 조회하고 싶다면 아래명령어를 씁니다
-- DESCRIBE 테이블명; 혹은 DESC 테이블명;
DESCRIBE employees;
DESC employees;