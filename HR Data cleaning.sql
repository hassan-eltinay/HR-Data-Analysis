USE MyProjects;

SELECT * FROM HR;

ALTER TABLE HR
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE HR;

-- date and time columns formatting and type changes
UPDATE HR
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
    END;

UPDATE HR
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
    END;
	
ALTER TABLE HR
MODIFY COLUMN birtdate date;  
    
ALTER TABLE HR
MODIFY COLUMN hire_date date;    


UPDATE HR
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

UPDATE HR
SET termdate = null
WHERE termdate = "0000-00-00";

ALTER TABLE HR
MODIFY COLUMN termdate date; 


-- addition of new age column

ALTER TABLE HR
ADD COLUMN age INT;

UPDATE HR
SET age = timestampdiff(YEAR, birthdate, CURDATE());

-- Note that there are some ages that are less than zero, so we'll exclude them in our analysis 
-- or we can just delete them using the statement below 

-- DELETE FROM HR
-- WHERE age < 18






