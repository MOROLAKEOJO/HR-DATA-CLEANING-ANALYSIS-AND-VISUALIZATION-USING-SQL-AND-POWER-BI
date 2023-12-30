-- QUERIES

-- 1. Employee's gender breakdown 
select gender, count(*) as count from human
where age >= 18 and termdate is null
group by gender;

-- 2. employee's race and ethnicity breakdown
select race, count(*) as count
from human
where age >= 18 and termdate is null
group by race
order by count(*) desc;

-- 3. age distribution of employees
select 
min(age) as youngest,
max(age) as oldest
from human
where age >= 18 and termdate is null;

select 
case
	when age >= 18 and age <= 24 then "18-24"
    when age >= 25 and age <= 34 then "25-34"
	when age >= 35 and age <= 44 then "35-44"
	when age >= 45 and age <= 54 then "45-54"
    when age >= 55 and age <= 64 then "55-64"
else '65+'
end as age_group,
count(*) as count
from human
where age >= 18 and termdate is null
group by age_group
order by age_group;

select 
case
	when age >= 18 and age <= 24 then "18-24"
    when age >= 25 and age <= 34 then "25-34"
	when age >= 35 and age <= 44 then "35-44"
	when age >= 45 and age <= 54 then "45-54"
    when age >= 55 and age <= 64 then "55-64"
else '65+'
end as age_group, gender,
 count(*) as count
from human
where age >= 18 and termdate is null
group by age_group, gender
order by age_group, gender;

-- 4. how many employees works at headquarter vs remotely
select location, count(*) as count
from human
group by location;

-- 5. whats the average length of employent of terminated employees
select round(avg(datediff(termdate, hire_date)/365),0) as avg_lenght_employement
from human
where termdate <= curdate() and termdate is not null and age >= 18;

-- 6. how does gender distribution vary across departments and job title
select department, gender, count(*) as count 
from human 
where age >= 18 and termdate is null
group by department, gender
order by department;

-- 7. distribution of job title across the company
select jobtitle, count(*) as count
from human
where age >= 18 and termdate is null
group by jobtitle
order by jobtitle desc;

-- 8. which department has the highest turn over rate 
select department,
 total_count, 
 terminated_count, 
 terminated_count/total_count as termination_rate
from (select department, count(*) as total_count, sum(case 
when termdate is not null and termdate <= curdate() then 1 else 0 end) as terminated_count
from human 
where age >= 18
 group by department) as subquery
 order by termination_rate desc;
 
-- 9. what's the distribution of employees across location by city and state
select location_state, count(*) as count
from human
where age >= 18 and termdate is null
group by location_state
order by count desc;

-- 10. how has the company's employee count changed over time based on hire and term date
select year,
	hires,
    terminations,
	hires - terminations AS net_change,
    round((hires - terminations)/hires * 100, 2) as net_charge_percent
from ( select year(hire_date) as year,
count(*) as hires,
sum( case when termdate is not null and termdate<= curdate() then 1 else 0 end) as terminations 
from human
where age >= 18
group by year(hire_date) ) as subquery
order by year asc;


-- 11. what is the tebure distribution for each depatment
select department, round(avg(datediff(termdate, hire_date)/365),0) as avg_tenure
from human
where termdate <= curdate() and termdate is not null and age >= 18
group by department;

