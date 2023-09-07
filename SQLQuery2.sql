SELECT * FROM JOB_DATA

use TRANITY

/*Write an SQL query to calculate the number of jobs reviewed per hour for each day in November 2020*/
SELECT 
    ds,
    COUNT(job_id) AS jobs_per_day,
    SUM(time_spent) / 3600.0 AS hours_spent 
FROM 
    job_data  
WHERE 
    ds >= '2020-11-01' AND ds <= '2020-11-30'  
GROUP BY 
    ds;


/* Write an SQL query to calculate the 7-day rolling average of throughput*/

SELECT
    ds,
    AVG(jobs_per_day) OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_avg_throughput
FROM (
    SELECT
        ds,
        COUNT(job_id) AS jobs_per_day
    FROM
        job_data
    WHERE
        ds >= '2020-11-01' AND ds <= '2020-11-30'
    GROUP BY
        ds
) daily_metrics
ORDER BY
    ds;


/*Write an SQL query to calculate the percentage share of each language over the last 30 days*/

SELECT
    language,
    COUNT(*) AS job_count,
    (COUNT(*) * 100.0) / SUM(COUNT(*)) OVER () AS percentage_share
FROM
    job_data
WHERE
    ds >= DATEADD(DAY, -30, '2020-11-30') AND ds <= '2020-11-30'
GROUP BY
    language
ORDER BY
    percentage_share DESC;

/*Write an SQL query to display duplicate rows from the job_data table*/

WITH DuplicateRows AS (
    SELECT
        ds,
        job_id,
        actor_id,
        event,
        language,
        time_spent,
        org,
        ROW_NUMBER() OVER (PARTITION BY ds, job_id, actor_id, event, language, time_spent, org ORDER BY ds) AS row_num
    FROM job_data
)
SELECT
    ds,
    job_id,
    actor_id,
    event,
    language,
    time_spent,
    org
FROM DuplicateRows
WHERE row_num > 1;


SELECT 
    ds,
    COUNT(job_id) AS jobs_per_day,
    SUM(time_spent) / 3600.0 AS hours_spent 
FROM 
    job_data  
WHERE 
    ds >= '2020-11-01' AND ds <= '2020-11-30'  
GROUP BY 
    ds;


	SELECT
    ds,
    AVG(jobs_per_day) OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_avg_throughput
FROM (
    SELECT
        ds,
        COUNT(job_id) AS jobs_per_day
    FROM
        job_data
    WHERE
        ds >= '2020-11-01' AND ds <= '2020-11-30'
    GROUP BY
        ds
) daily_metrics
ORDER BY
    ds;

	WITH DuplicateRows AS (
    SELECT
        ds,
        job_id,
        actor_id,
        event,
        language,
        time_spent,
        org,
        ROW_NUMBER() OVER (PARTITION BY ds, job_id, actor_id, event, language, time_spent, org ORDER BY ds) AS row_num
    FROM job_data
)
SELECT
    ds,
    job_id,
    actor_id,
    event,
    language,
    time_spent,
    org
FROM DuplicateRows
WHERE row_num > 1;