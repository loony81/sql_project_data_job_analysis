/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from the first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
- helping job seekers understand which skills to develop that align with top salaries
*/

-- Let's create a CTE based on the first query and remove some unnecessary columns
WITH top_paying_jobs_cte AS (
    SELECT job_id, job_title, salary_year_avg, name as company_name
    FROM job_postings_fact p
    JOIN company_dim c ON p.company_id = c.company_id
    WHERE job_title_short = 'Data Analyst' AND job_location = 'Anywhere' 
    AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

-- Now let's join our cte with two other dimensional columns to get the necessary skills
SELECT sj.job_id, job_title, salary_year_avg, company_name, skills 
FROM top_paying_jobs_cte cte
JOIN skills_job_dim sj ON cte.job_id = sj.job_id
JOIN skills_dim s on sj.skill_id = s.skill_id

/*
Here's an analysis of the skills required for the top 10 data analyst roles based on the job postings:
Most Frequently Mentioned Skills:

SQL: 7 mentions
Tableau: 4 mentions
Hadoop, Python, Looker: 3 mentions each
Moderately Mentioned Skills:

Power BI, Java, Snowflake, Excel: 2 mentions each
Less Frequently Mentioned Skills:

Git, Confluence, Jira, Crystal, Databricks, Bitbucket, Atlassian, R, Flow, Scala, C++, Redshift, Oracle, Spark, Airflow, Azure: 1 mention each
*/
