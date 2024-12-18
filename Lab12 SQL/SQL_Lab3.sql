USE sakila;


-- 1. List the number of films per category.


SELECT fc.category_id, COUNT(f.film_id)AS number_of_films FROM sakila.film AS f
LEFT JOIN sakila.film_category AS fc
ON f.film_id = fc.film_id
GROUP BY fc.category_id;

-- 2.Retrieve the store ID, city, and country for each store.
SELECT s.store_id , ct.city, cy.country  FROM sakila.store AS s
LEFT JOIN sakila.address AS a
ON s.address_id = a.address_id
JOIN sakila.city AS ct
ON a.city_id = ct.city_id
JOIN sakila.country AS cy
ON ct.country_id = cy.country_id;

-- 3.Calculate the total revenue generated by each store in dollars.

SELECT st.store_id,  SUM(p.amount) FROM payment AS p
JOIN sakila.staff AS s
ON p.staff_id = s.staff_id
JOIN sakila.store AS st
ON s.store_id = st.store_id
GROUP BY st.store_id;


-- 4.Determine the average running time of films for each category.

SELECT fc.category_id, ROUND(AVG(f.length),1) AS average FROM film AS f
JOIN sakila.film_category AS fc
ON f.film_id = fc.film_id
GROUP BY fc.category_id;


-- 5.Identify the film categories with the longest average running time.

SELECT fc.category_id, ROUND(AVG(f.length),1) AS average FROM film AS f
JOIN sakila.film_category AS fc
ON f.film_id = fc.film_id
GROUP BY fc.category_id
ORDER BY average DESC;

-- 6.Display the top 10 most frequently rented movies in descending order.

SELECT * FROM rental;


-- 7.Determine if "Academy Dinosaur" can be rented from Store 1.alter

SELECT * FROM inventory AS i
JOIN film AS f
ON i.film_id = f.film_id
WHERE i.store_id = 1 AND f.title = 'Academy Dinosaur' ;


