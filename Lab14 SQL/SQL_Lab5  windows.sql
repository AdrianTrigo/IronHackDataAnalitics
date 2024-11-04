USE sakila;
-- CHALLENGE 1

-- 1.Rank films by their length and create an output table that includes the title, length, and rank columns only.
-- Filter out any rows with null or zero values in the length column.
SELECT title,length, RANK() OVER(ORDER BY length DESC)  FROM film;


SELECT * , RANK() OVER(PARTITION BY k_symbol ORDER BY amount DESC) AS "Ranks"
FROM bank.order
WHERE k_symbol <> " ";

-- 2.Rank films by length within the rating category and create an output table that includes the title, length, rating and rank columns only. 
-- Filter out any rows with null or zero values in the length column.

SELECT title,length,rating, RANK() OVER(PARTITION BY rating ORDER BY length DESC)  FROM film;

-- 3.Produce a list that shows for each film in the Sakila database,
--  the actor or actress who has acted in the greatest number of films, as well as the total number of films in which they have acted. 
-- Hint: Use temporary tables, CTEs, or Views when appropiate to simplify your queries.

SELECT *  FROM film;
SELECT * FROM film_actor;

SELECT actor_id, COUNT(actor_id) FROM film_actor
GROUP BY actor_id
ORDER BY COUNT(actor_id) DESC;

-- CHALLENGE 2

-- Step 1. Retrieve the number of monthly active customers, i.e., the number of unique customers who rented a movie in each month.
-- Step 2. Retrieve the number of active users in the previous month.
-- Step 3. Calculate the percentage change in the number of active customers between the current and previous month.
-- Step 4. Calculate the number of retained customers every month, i.e., customers who rented movies in the current and previous months.













