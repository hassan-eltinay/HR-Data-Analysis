-- Analysis Questions

-- 1. What is th gender breakdown of employees in the compnay?

SELECT gender, 
COUNT(*) AS count
FROM HR
WHERE age >=18 AND termdate IS NULL
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees?
SELECT race,
COUNT(*) AS count
FROM HR
WHERE age >=18 AND termdate IS NULL
GROUP BY race
ORDER BY count DESC;
        
        
 -- 3. What is the age distribution of employees?
SELECT
	CASE
		WHEN age between 18 AND 25 THEN '18-25'
		WHEN age between 26 AND 35 THEN '26-35'
        WHEN age between 36 AND 45 THEN '36-45'
		WHEN age between 46 AND 55 THEN '46-55'
		ELSE '55+'
	END AS age_group,
    gender,
	COUNT(*) AS count
 FROM HR
 WHERE age >=18 AND termdate IS NULL
 GROUP BY age_group, gender
 ORDER BY count DESC;
 
 -- 4. How many employees work at office vs at home?
 
SELECT 
	location, 
	COUNT(location) AS count
FROM HR
WHERE age >=18 AND termdate IS NULL
GROUP BY location
ORDER BY count DESC;


 -- 5. What is the average length of employment for employees who have been terminated?
 
SELECT 
	ROUND(AVG((DATEDIFF(termdate, hire_date) / 365)), 0) AS average_employment_length
FROM HR
WHERE age>=18 AND termdate IS NOT NULL AND termdate < curdate();


-- 6. How does gender distribution vary across departments?

SELECT 
	department,
    gender,
    COUNT(*) AS count 
FROM HR
WHERE age >=18 AND termdate IS NULL
GROUP BY department, gender
ORDER BY department;


-- 7. What is the distribution of job titles across the company?

SELECT 
	jobtitle,
    COUNT(*) AS count 
FROM HR
WHERE age >=18 AND termdate IS NULL
GROUP BY jobtitle
ORDER BY jobtitle desc;


-- 8. What is the department with highest turn over?

SELECT 
	department,
    total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
FROM (
		SELECT department,
			COUNT(*) AS total_count,
			SUM(CASE WHEN termdate is NOT NULL AND termdate <= curdate() THEN 1 ELSE 0 END) terminated_count
		FROM HR
        WHERE age >=18
        GROUP BY department
        ) AS subquery
 ORDER BY termination_rate DESC;       
 
 
 -- 9. What is the distribution of employees across locations by city and state?
 SELECT 
	location_city,
    location_state,
    COUNT(*) AS count
FROM HR
WHERE age >=18 AND termdate IS NULL
GROUP BY location_city, location_state
ORDER BY count DESC;


-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT 
	year,
    hires,
    terminations,
    hires - terminations AS net_change,
    round((hires-terminations)/hires*100, 2) AS net_change_percent
 FROM (
	SELECT 
    YEAR(hire_date) AS year,
    COUNT(*) AS hires,
	SUM(CASE WHEN termdate IS NOT NULL AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
	FROM HR
    WHERE age >= 18
    GROUP BY YEAR(hire_date)
	) AS subquery
ORDER BY year ASC;

-- 11. What is the tenure distribution for each department?
SELECT department,
round(avg((datediff(termdate, hire_date)/365)), 0) AS avg_tenure
FROM HR
WHERE age >=18 AND termdate IS NOT NULL AND termdate <= curdate()
GROUP BY department;


