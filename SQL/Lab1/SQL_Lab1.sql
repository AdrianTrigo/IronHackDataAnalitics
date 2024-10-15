USE sakila;
SHOW FULL TABLES;

-- 2 
SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM customer;
-- 3
-- 3.1
SELECT title FROM film;

-- 3.2
SELECT name AS language FROM language;

-- 3.3
SELECT first_name FROM staff;

-- 4
SELECT distinct release_year FROM film;

-- 5
-- 5.1
SELECT COUNT(store_id) FROM store;
-- 5.2
SELECT COUNT(staff_id) FROM staff;

-- 5.3

-- 5.3
SELECT COUNT(*) FROM rental
WHERE return_date = null;

SELECT COUNT(*) FROM rental;

-- 5.4
SELECT distinct first_name FROM actor;

-- 6
SELECT * FROM film
ORDER BY length DESC 
LIMIT 10;

-- 7
-- 7.1
SELECT * FROM actor
WHERE  first_name LIKE 'SCARLETT%';

-- 7.2
SELECT * FROM film
WHERE  title LIKE '%ARMAGEDDON%' AND length > 100;

-- 7.3
SELECT COUNT(special_features)  FROM film
WHERE special_features LIKE '%Behind the Scenes%';








