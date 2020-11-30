#20201103 Afternoon lab: sub queries: https://github.com/ironhack-labs/lab-sql-subqueries

# 1.How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT f.title as Title, COUNT(i.inventory_id) as Inventory_count
FROM film as f
JOIN inventory as i ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible";

SELECT f.title AS Title, COUNT(i.inventory_id) AS Number_copies
FROM film f
join inventory i using (film_id)
WHERE f.title = "Hunchback Impossible";

# 2.List all films whose length is longer than the average of all the films.

SELECT * FROM film 
WHERE length > (SELECT AVG(length) FROM film) 
ORDER BY length DESC;

# 3.Use subqueries to display all actors who appear in the film Alone Trip.

SELECT f.actor_id, a.first_name, a.last_name FROM film_actor as f
JOIN actor as a using (actor_id) 
WHERE film_id = (SELECT film_id FROM film 
WHERE title = "Alone Trip"
);

# 4.Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT film_id, title FROM film 
WHERE film_id IN (SELECT film_id FROM film_category
	WHERE category_id = (SELECT category_id FROM category
		WHERE name = "Family")); 		

		
SELECT film_id FROM film_category
	WHERE category_id = (SELECT category_id FROM category
		WHERE name = 'Family'); #works

#trying to join, works!!
SELECT f.film_id, f.title FROM film as f
RIGHT JOIN (SELECT film_id FROM film_category
	WHERE category_id = (SELECT category_id FROM category
		WHERE name = "Family")) as n
		USING (film_id);

# 5.Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

	#with subqueries
	SELECT first_name, last_name, email FROM customer 
	WHERE address_id IN (SELECT address_id FROM address
		WHERE city_id IN (SELECT city_id FROM city 
			WHERE country_id = (SELECT country_id FROM country WHERE country = "Canada")));


# 6.Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

SELECT film_id, title from film where film_id in 
(SELECT film_id FROM film_actor 
WHERE actor_id = (SELECT actor_id FROM (
SELECT actor_id, count(film_id) as film_count FROM film_actor
GROUP BY actor_id
ORDER BY film_count DESC
LIMIT 1) sub1) );

select concat(first_name, ' ', last_name) as actor_name, film.title, film.release_year
from sakila.actor
inner join sakila.film_actor
using (actor_id)
inner join film
using (film_id)
where actor_id = (
select actor_id
from sakila.actor
inner join sakila.film_actor
using (actor_id)
inner join sakila.film
using (film_id)
group by actor_id
order by count(film_id) desc
limit 1
)
order by release_year desc;


# 7.Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments 
# 8.Customers who spent more than the average payments.
