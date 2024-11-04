-- LEVEL 1

-- Question 1: Number of users with sessions

SELECT COUNT(DISTINCT user_id) FROM sessions;


-- Question 2: Number of chargers used by user with id 1

SELECT COUNT(DISTINCT charger_id) FROM sessions
WHERE user_id=1;


-- LEVEL 2

-- Question 3: Number of sessions per charger type (AC/DC):

SELECT c.type,COUNT(s.id) FROM sessions AS s
JOIN chargers AS c ON c.id= s.charger_id
GROUP BY c.type;


-- Question 4: Chargers being used by more than one user (assumned not simu)

SELECT charger_id,COUNT(DISTINCT user_id) AS n_users
FROM sessions
GROUP BY charger_id
HAVING n_users > 1;

-- Question 5: Average session time per charger


SELECT c.id AS charger_id , ROUND(AVG((julianday(s.end_time)-julianday(s.start_time))*24*60 ),2) AS avg_time FROM chargers AS c
JOIN sessions AS s ON s.charger_id=c.id
GROUP BY c.id;



-- LEVEL 3

-- Question 6: Full username of users that have used more than one charger in one day (NOTE: for date only consider start_time)

SELECT DISTINCT users_moreoneuse.user_id, users.name, users.surname FROM
    (SELECT sessions.user_id, DATE(sessions.start_time) as session_date , COUNT(sessions.charger_id)
    FROM sessions
    GROUP BY sessions.user_id, session_date
    HAVING COUNT(DISTINCT sessions.charger_id) > 1) AS users_moreoneuse
JOIN users ON users_moreoneuse.user_id = users.id;


-- Question 7: Top 3 chargers with longer sessions

SELECT c.id AS charger_id, MAX((julianday(s.end_time) - julianday(s.start_time))*24*60*60) AS session_time 
FROM chargers AS c
LEFT JOIN sessions AS s ON s.charger_id=c.id
GROUP BY c.id
ORDER BY session_time DESC
LIMIT 3;


-- Question 8: Average number of users per charger (per charger in general, not per charger_id specifically)


SELECT c.type, s.user_id, COUNT(DISTINCT user_id), DATE(s.start_time) AS day FROM chargers AS c
LEFT JOIN sessions AS s ON s.charger_id=c.id
GROUP BY c.type, day;



SELECT prueba.type ,AVG(prueba.user_id)  FROM 
    (SELECT c.type, s.user_id, COUNT(DISTINCT user_id), DATE(s.start_time) AS day FROM chargers AS c
    LEFT JOIN sessions AS s ON s.charger_id=c.id
    GROUP BY c.type, day) AS prueba  
GROUP BY prueba.type;  
  

-- Question 9: Top 3 users with more chargers being used


SELECT u.name, u.surname, COUNT((c.id)) AS chargers_used FROM users AS u
JOIN sessions AS s ON u.id = s.user_id
JOIN chargers AS c ON c.id= s.charger_id
GROUP BY u.id
ORDER BY chargers_used DESC
LIMIT 3;


-- LEVEL 4

-- Question 10: Number of users that have used only AC chargers, DC chargers or both
SELECT 
    SUM(CASE WHEN ac_dc_count.user_ac_charger_count > 0 AND ac_dc_count.user_dc_charger_count = 0 THEN 1 ELSE 0 END) AS only_ac_users,
    SUM(CASE WHEN ac_dc_count.user_dc_charger_count > 0 AND ac_dc_count.user_ac_charger_count = 0 THEN 1 ELSE 0 END) AS only_dc_users,
    SUM(CASE WHEN ac_dc_count.user_ac_charger_count > 0 AND ac_dc_count.user_dc_charger_count > 0 THEN 1 ELSE 0 END) AS both_ac_dc_users
FROM
    (SELECT     *, 
            MAX(CASE WHEN c.type = 'AC' THEN 1 ELSE 0 END) AS user_ac_charger_count,  
            MAX(CASE WHEN c.type = 'DC' THEN 1 ELSE 0 END) AS user_dc_charger_count
    FROM users AS u
    JOIN sessions AS s ON u.id = s.user_id
    JOIN chargers AS c ON c.id= s.charger_id
    GROUP BY u.id)AS ac_dc_count;


    

-- Question 11: Monthly average number of users per charger

SELECT 
    charger_id,
    AVG(users_per_month) AS average_users_per_month
    FROM
    (SELECT  charger_id,
            strftime('%Y-%m', start_time)  AS year_month,
            COUNT(DISTINCT user_id) AS users_per_month
    FROM sessions
    GROUP BY charger_id,year_month)
GROUP BY charger_id;


-- Question 12: Top 3 users per charger (for each charger, number of sessions)

WITH uses_user_charger AS (
    SELECT charger_id, user_id, COUNT(user_id) AS n_uses 
    FROM sessions
    GROUP BY charger_id, user_id),
    
    ranked_charger_users AS (SELECT charger_id, user_id,n_uses, RANK() OVER(PARTITION BY charger_id ORDER BY n_uses DESC) AS user_rank
    FROM uses_user_charger)
SELECT u.*,ranked_charger_users.* FROM ranked_charger_users
JOIN users as u ON u.id = ranked_charger_users.user_id
WHERE user_rank < 4;




-- LEVEL 5

-- Question 13: Top 3 users with longest sessions per month (consider the month of start_time)

WITH users_month_duration AS (
    SELECT user_id, 
           STRFTIME('%Y-%m', start_time) as month, 
           (UNIXEPOCH(sessions.end_time) - UNIXEPOCH(sessions.start_time)) AS seconds
    FROM users JOIN sessions ON users.id = user_id
), month_users_max_duration AS (
    SELECT month, user_id, MAX(seconds) max_duration
    FROM users_month_duration
    GROUP BY month, user_id
), ranked_duration AS (
    SELECT month, user_id, max_duration,
            RANK() OVER(ORDER BY max_duration DESC) AS ranked
    FROM month_users_max_duration
)
SELECT month, name, surname, max_duration, ranked
FROM ranked_duration JOIN users ON user_id = users.id
WHERE ranked <= 3;

    
-- Question 14. Average time between sessions for each charger for each month (consider the month of start_time)

WITH charger_month_duration AS (
    SELECT charger_id,
        STRFTIME('%Y-%m', start_time) as month, 
        (UNIXEPOCH(sessions.end_time) - UNIXEPOCH(sessions.start_time)) AS seconds
    FROM chargers JOIN sessions ON chargers.id = charger_id
), month_charger_avg AS (
    SELECT month, charger_id, AVG(seconds) avg_duration
    FROM charger_month_duration
    GROUP BY month, charger_id
)
SELECT month, label, avg_duration
FROM month_charger_avg JOIN chargers ON charger_id = chargers.id;
