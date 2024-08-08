/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focus on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and helps
  identify the most financially rewarding skills to acquire or improve
*/

SELECT skills, ROUND(AVG(salary_year_avg),0) AS avg_salary_per_skill
FROM job_postings_fact p
JOIN skills_job_dim sj ON p.job_id = sj.job_id
JOIN skills_dim s on sj.skill_id = s.skill_id
WHERE job_title_short = 'Data Analyst'
AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_salary_per_skill DESC
LIMIT 25