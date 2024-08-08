/*
Question: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrate on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
  offering strategic insights for career development in data analysis
*/

-- We can use solutions from queries 3 and 4 as CTEs, but without ordering and limiting the results,
-- and since we're gonna connect these two results on skill_id column, we also need to group the results
-- on that column

with skills_in_demand AS (
    SELECT s.skill_id, s.skills, COUNT(sj.job_id) AS demand_count
    FROM job_postings_fact p
    JOIN skills_job_dim sj ON p.job_id = sj.job_id
    JOIN skills_dim s on sj.skill_id = s.skill_id
    WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home
    GROUP BY s.skill_id
), average_salary AS (
    SELECT s.skill_id, ROUND(AVG(salary_year_avg),0) AS avg_salary_per_skill
    FROM job_postings_fact p
    JOIN skills_job_dim sj ON p.job_id = sj.job_id
    JOIN skills_dim s on sj.skill_id = s.skill_id
    WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    GROUP BY s.skill_id
)

SELECT skills_in_demand.skill_id, skills_in_demand.skills, demand_count, avg_salary_per_skill
FROM skills_in_demand 
INNER JOIN 
average_salary ON skills_in_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY avg_salary_per_skill DESC, demand_count DESC
LIMIT 25