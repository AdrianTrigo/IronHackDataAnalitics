USE sakila;

-- Challenge 1
-- 1 You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
SELECT 
    MAX(length) AS max_duration,
    MIN(length) AS min_duration,
    AVG(length) AS avg_duration
FROM
    film;

-- 1.2 Express the average movie duration in hours and minutes. Don't use decimals.

SELECT FLOOR(AVG(length) / 60) AS avg_hours, 
FLOOR(MOD(AVG(length), 60)) AS avg_minutes 
FROM film;

-- 2 You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) 
AS datediff 
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT * , DATE_FORMAT(CONVERT(rental_date,DATE),'%M') AS month,
CASE WEEKDAY(rental_date) WHEN 0 THEN 'Monday'
						WHEN 1 THEN 'Tuesday'
						WHEN 2 THEN 'Wednesday'
						WHEN 3 THEN 'Thursday'
						WHEN 4 THEN 'Friday'
						WHEN 5 THEN 'Saturday'
						WHEN 6 THEN 'Sunday' END AS day
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.

SELECT  *,
	CASE 
		WHEN WEEKDAY(rental_date) BETWEEN 0 AND 4 THEN 'workday'
		ELSE 'weekend' 
		END AS DAY_TYPE						
FROM rental;

-- You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT title,
	IFNULL(rental_duration,'Not Available')
    AS rental_duration
FROM film;

-- 4 Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.

SELECT CONCAT(first_name,' ',last_name) AS name ,
SUBSTRING( email, 1, 3 ) AS email, last_name
FROM customer
ORDER BY last_name ASC;

-- Challenge 2
-- 1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.

SELECT COUNT(*) FROM film;

-- 1.2 The number of films for each rating.

SELECT rating,COUNT(*) FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT rating,COUNT(*) AS n_films FROM film
GROUP BY rating
ORDER BY n_films DESC;

-- 2.Using the film table, determine: 
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, ROUND(AVG(length),2) AS average_rating FROM film
GROUP BY rating
ORDER BY average_rating DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, ROUND(AVG(length),2) AS average_rating FROM film
GROUP BY rating
HAVING average_rating > 120 
ORDER BY average_rating DESC;

-- 3.Bonus: determine which last names are not repeated in the table actor

SELECT last_name FROM actor
WHERE last_name IN 
	(SELECT last_name FROM actor 
    GROUP BY last_name 
    having count(last_name)=1);







