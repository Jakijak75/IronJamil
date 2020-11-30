# 20201102_Lab2: https://github.com/ironhack-labs/lab-sql-join-multiple-tables

# 1/Write a query to display for each store its store ID, city, and country.

SELECT s.store_id, c.city, k.country FROM store as s 
LEFT JOIN address as a 
ON s.address_id = a.address_id 
LEFT JOIN city as c
ON a.city_id = c.city_id
LEFT JOIN country as k 
ON c.country_id = k.country_id;

# 2/ Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, sum(p.amount) FROM sakila.staff as s
LEFT JOIN sakila.payment as p
ON s.staff_id = p.staff_id
GROUP BY s.store_id;

# 3/ What is the average running time of films by category?
SELECT fc.category_id, AVG(f.length) as av_length FROM sakila.film_category as fc
LEFT JOIN sakila.film as f
ON fc.film_id = f.film_id
GROUP BY fc.category_id
ORDER BY av_length;

SELECT c.category_id, c.name, AVG(f.length) as av_length FROM sakila.category as c
LEFT JOIN film_category as fc 
ON c.category_id = fc.category_id
LEFT JOIN sakila.film as f
ON fc.film_id = f.film_id
GROUP BY category_id
ORDER BY av_length;

# 4/ Which film categories are longest?
SELECT c.category_id, c.name, AVG(f.length) as av_length FROM sakila.category as c
LEFT JOIN film_category as fc 
ON c.category_id = fc.category_id
LEFT JOIN sakila.film as f
ON fc.film_id = f.film_id
GROUP BY category_id
ORDER BY av_length DESC
LIMIT 3;

# 5/ Display the most frequently rented movies in descending order.
SELECT i.film_id, f.title, COUNT(r.rental_id) as rental_count FROM sakila.rental as r
LEFT JOIN sakila.inventory as i
ON r.inventory_id = i.inventory_id
LEFT JOIN sakila.film as f
ON i.film_id = f.film_id
GROUP BY film_id
ORDER BY rental_count DESC;

# 6/ List the top five genres in gross revenue in descending order.
SELECT c.category_id, c.name, SUM(p.amount) as gross_rev FROM sakila.payment as p
LEFT JOIN sakila.rental as r
ON p.rental_id = r.rental_id
LEFT JOIN sakila.inventory as i
ON r.inventory_id = i.inventory_id
LEFT JOIN sakila.film_category as fc
ON i.film_id = fc.film_id
LEFT JOIN sakila.category as c
ON fc.category_id = c.category_id
GROUP BY c.category_id 
ORDER BY gross_rev DESC;

## WHY DO I HAVE NULLS????

# 7/ Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.film_id, f.title, i.store_id as available_in_store FROM sakila.film as f
LEFT JOIN sakila.inventory as i
ON f.film_id = i.film_id  
WHERE f.title = "Academy Dinosaur";

SELECT f.film_id, f.title, i.store_id as available_in_store FROM sakila.film as f
LEFT JOIN sakila.inventory as i
ON f.film_id = i.film_id  
GROUP BY available_in_store, film_id, title;
