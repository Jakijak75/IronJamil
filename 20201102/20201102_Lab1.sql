# Lab | SQL Join: https://github.com/ironhack-labs/lab-sql-join

#Instructions:

# 1/ List number of films per category.

SELECT c.category_id, c.name, count(f.film_id) as film_per_cat FROM sakila.category as c 
LEFT JOIN sakila.film_category as f
ON c.category_id = f.category_id
GROUP BY c.category_id
ORDER BY film_per_cat DESC;

# 2/ Display the first and last names, as well as the address, of each staff member.
SELECT s.staff_id, s.first_name, s.last_name, s.ddress_id, a.address, c.city, a.postal_code FROM sakila.staff as s
LEFT JOIN sakila.address as a
ON s.address_id = a.address_id
LEFT JOIN sakila.city as c
ON a.city_id = c.city_id;

# 3/ Display the total amount rung up by each staff member in August of 2005.
SELECT staff_id, COUNT(rental_id) as rental_count
FROM rental
WHERE DATE_FORMAT(rental_date, '%m%Y') = 082005
GROUP BY staff_id
ORDER BY rental_count DESC;

# 4/ List each film and the number of actors who are listed for that film.
SELECT fa.film_id, count(fa.actor_id) as actor_count, f.title FROM sakila.film_actor as fa
LEFT JOIN sakila.film as f
ON fa.film_id = f.film_id
GROUP BY fa.film_id
ORDER BY actor_count DESC;

# 5/ Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) as total_paid FROM sakila.customer as c
LEFT JOIN sakila.payment as p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name;

