CREATE DATABASE hrdb;
use hrdb;
 select* from hr;
  
alter table hr 
change column ï»¿id emp_id varchar(30) null;

describe hr;

set sql_safe_updates=0;

update hr 
set birthdate = case
when birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
when birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
else null
end; 

alter table hr
modify column birthdate date;

 select birthdate from hr;
 
 update hr 
set hire_date = case
when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
when hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
else null
end;

alter table hr
modify column hire_date date;



SET sql_mode = '';

SET sql_mode = 'NO_ZERO_DATE';

SET sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO';

UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate = null ;

SET sql_mode = '';

UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate IS NULL;

alter table hr add column Age int;

update hr
set age = timestampdiff(Year,birthdate,curdate());

select birthdate,age from hr;

select
min(age) as youngest,
max(age) as oldest 
from hr;

select count(*) from hr where age < 18;

select count(*) from hr where age > curdate();