SELECT *
	FROM data_analyst_jobs;

-- The dataset for this exercise has been derived from the Indeed Data Scientist/Analyst/Engineer dataset on kaggle.com
-- Provide the SQL queries and answers for the following questions/tasks using the data_analyst_jobs table you have created in PostgreSQL:

--     How many rows are in the data_analyst_jobs table?

SELECT COUNT(*)
	FROM data_analyst_jobs;

--There are 1793 Rows.

--     Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT *
	FROM data_analyst_jobs
	LIMIT 10;

		-- The company associated with the job posting on the 10th row is Exxon Mobile

--     How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT COUNT(location)
	FROM data_analyst_jobs
	WHERE location = 'TN';
	
		-- There are 21 jobs in Tennessee.

SELECT COUNT(location)
	FROM data_analyst_jobs
	WHERE location = 'TN'
	OR location = 'KY';

		-- There are 27 jobs in Tennessee or Kentucky
		
--     How many postings in Tennessee have a star rating above 4?

SELECT COUNT(*)
	FROM data_analyst_jobs
	WHERE location = 'TN'
	AND star_rating > 4;

		-- There are 3 postings in Tennessee that have a star rating above 4

--     How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT(*)
	FROM data_analyst_jobs
	WHERE review_count BETWEEN 500 AND 1000;
	
	-- There are 151 postings that have a review count between 500 and 1000

--     Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?

SELECT location AS state,
	ROUND(AVG(star_rating), 2) AS avg_rating
	FROM data_analyst_jobs
	WHERE location IS NOT NULL
	AND star_rating IS NOT NULL
	GROUP BY state
	ORDER BY avg_rating DESC;

		-- The state with the highest average rating is Nebraska.
		

--     Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT COUNT(DISTINCT title)
	FROM data_analyst_jobs;

		-- There are 881 unique jobs.

--     How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT title)
	FROM data_analyst_jobs
	WHERE location = 'CA';
	
	-- There are 230 unique job titles in California companies

--     Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT COUNT(DISTINCT company) AS companies,
	AVG(star_rating),
	SUM(review_count),
	COUNT(location)
FROM data_analyst_jobs
	WHERE review_count > 5000

SELECT company,
	AVG(star_rating),
	SUM(review_count),
	COUNT(location)
FROM data_analyst_jobs
	WHERE review_count > 5000
	AND company is NOT NULL
	GROUP BY company;

	-- There are 40 companies with review counts over 5000 across all locations

--     Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT company,
	AVG(star_rating) AS avg_rating,
	SUM(review_count) AS review_count,
	COUNT(DISTINCT location) AS locations
FROM data_analyst_jobs
	WHERE review_count > 5000
	AND company IS NOT NULL
	GROUP BY company
	ORDER BY avg_rating DESC;

SELECT *
	FROM data_analyst_jobs
	WHERE company LIKE '%Kaiser Permanente%'

--     Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?

SELECT COUNT(DISTINCT title)
	FROM data_analyst_jobs
	WHERE title LIKE '%Analyst';

	-- There are 320 different job titles out there with the word Analyst in the title.

--     How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT title, COUNT(DISTINCT title)
	FROM data_analyst_jobs
	WHERE title NOT iLIKE '%ANALYST%'
	AND title NOT iLIKE '%Analytics%'
	GROUP BY title;

	-- They concentrate on visualization with tools like Tableau and Power BI - 4!!!

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.

--     Disregard any postings where the domain is NULL.
--     Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
--     Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

SELECT
	domain,
	COUNT(days_since_posting) AS jobs_unfilled
	FROM data_analyst_jobs
WHERE skill LIKE '%SQL%'
AND domain IS NOT NULL
AND days_since_posting > 21
GROUP BY domain
ORDER BY jobs_unfilled DESC;
