-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
select gender,count(gender)as count from hr
where age > 18 and termdate= '0000-00-00'
group by gender ;

-- 2. What is the race/ethnicity breakdown of employees in the company?
select race,count(race)as race_count from hr
where age > 18 and termdate= '0000-00-00'
group by race 
order by race_count desc;

-- 3. What is the age distribution of employees in the company?
SELECT
  MIN(age) AS youngest,
  MAX(age) AS oldest
FROM hr
WHERE age > 18 AND termdate = '0000-00-00';

SELECT
  CASE
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+'
  END AS age_group,gender,
  COUNT(*) AS count
FROM hr
WHERE age > 18 AND termdate = '0000-00-00'
GROUP BY age_group,gender
ORDER BY age_group,gender;

-- 4. How many employees work at headquarters versus remote locations?
 select location,count(location)as count from hr
 WHERE age > 18 AND termdate = '0000-00-00'
 group by location;
 
-- 5. What is the average length of employment for employees who have been terminated?
select 
 round(avg(datediff(termdate,hire_date))/365,0) as avg_employement_length
 from hr 
 where termdate<=curdate() and termdate <> '0000-00-00' and age >18;
 
-- 6. How does the gender distribution vary across departments and job titles?
select gender,count(gender)as count_gender,jobtitle
 from hr
 where age > 18 AND termdate = '0000-00-00'
 group by gender,jobtitle
 order by jobtitle;

-- 7. What is the distribution of job titles across the company?
select jobtitle,count(jobtitle)as count from hr
where age > 18 AND termdate = '0000-00-00'
group by jobtitle
order by jobtitle desc;

-- 8. Which department has the highest turnover rate?
select department,
  total_count,
  terminated_count,
  terminated_count/total_count as termination_rate
from (
select department,
count(*) as total_count,
sum(case when termdate <>'0000-00-00' and termdate<= curdate()then 1 else 0 end) as terminated_count
from hr
where age>=18 
group by department
) as ratee
order by termination_rate desc;


-- 9. What is the distribution of employees across locations by city and state?
select location_state,count(*) as count 
from hr 
where age > 18 AND termdate = '0000-00-00'
group by location_state
order by count desc ;

-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT
  year,
  hires,
  terminations,
  hires - terminations AS net_change,
  ROUND((hires - terminations) / hires * 100, 2) AS net_change_percent
FROM (
  SELECT
    YEAR(hire_date) AS year,
    COUNT(*) AS hires,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
  FROM
    hr
  WHERE
    age >= 18
  GROUP BY
    YEAR(hire_date)
) a
ORDER BY year ASC;

  
-- 11. What is the tenure distribution for each department?
SELECT department,round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
from hr
where termdate<=curdate() and termdate<> '0000-00-00' and age >=18
group  by department
order by department





