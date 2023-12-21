create database project;
use project;
describe human;
select * from human;

select date_format( Str_to_date(birthdate, "%m/%d/%y"), "%d/%m/%y") from human;


-- CHANGE COLUMN NAME ï»¿id TO ID
alter table human
change ï»¿id id varchar(15) not null;


-- CHNAGING THE BIRTHDATE INCONSISTENCY AND FORMAT
select case
			when birthdate like "%/%/%" THEN date_format(Str_to_date(birthdate, "%m/%d/%Y"), "%Y-%m-%d")
            ELSE 
		  date_format(Str_to_date(birthdate, "%m-%d-%Y"), "%Y-%m-%d")
            end j from human;

update human
set birthdate = 
case
			when birthdate like "%/%/%" THEN date_format(Str_to_date(birthdate, "%m/%d/%Y"), "%Y-%m-%d")
            ELSE 
		  date_format(Str_to_date(birthdate, "%m-%d-%Y"), "%Y-%m-%d")
            end;
            
alter table human
change birthdate birthdate date not null;
            
-- FOR HIRE DATE 
select case
			when hire_date like "%/%/%" THEN date_format(Str_to_date(hire_date , "%m/%d/%Y"), "%Y-%m-%d")
            ELSE 
		  date_format(Str_to_date(hire_date, "%m-%d-%Y"), "%Y-%m-%d")
            end h from human;

update human
set hire_date = 
case
			when hire_date  like "%/%/%" THEN date_format(Str_to_date(hire_date, "%m/%d/%Y"), "%Y-%m-%d")
            ELSE 
		  date_format(Str_to_date(hire_date, "%m-%d-%Y"), "%Y-%m-%d")
            end;
            
alter table human
change hire_date  hire_date  date not null;


-- CHANGING TERMDATE STRUCTURE 
update HUMAN
set termdate= case
when termdate  then  date(str_to_date(termdate, "%Y-%m-%d %H:%i:%s UTC"))
else  null
end;

alter table HUMAN
modify termdate date;



-- QUESTIONS
/*
Ratio of male to female employees
number of employees in each department
employees races 
how many employees are working remotely
how many employees has been terminated and their department
employees by their states
age range of employees
total number of employees
employees based on hire year





*/
