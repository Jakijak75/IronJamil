
# Select the first name, last name, and email address of all the customers who have rented a movie.

SELECT C.first_name, C.last_name, C.email FROM
customer as C join rental as R
USING (customer_id)
GROUP BY customer_id;

# What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT C.customer_id, CONCAT(C.first_name," ", C.last_name) as full_name, AVG(P.amount) as average_payment
FROM customer as C join payment as P
USING (customer_id)
GROUP BY customer_id
ORDER BY average_payment;

# Select the name and email address of all the customers who have rented the "Action" movies.

#Write the query using multiple join statements
SELECT CONCAT(C.first_name, " ", C.last_name), C.email
FROM customer as C join rental as R USING (customer_id)
join inventory as I using (inventory_id)
join film_category as FC using (film_id)
join category as CAT using (category_id)
WHERE CAT.name = "Action"
GROUP BY customer_id;

#Write the query using sub queries with multiple WHERE clause and IN condition
SELECT CONCAT(first_name, " ", last_name), email FROM customer 
	WHERE customer_id IN (SELECT customer_id FROM rental 
		WHERE inventory_id IN (SELECT inventory_id FROM inventory
			WHERE film_id IN (SELECT film_id FROM film_category
				WHERE category_id IN (SELECT category_id FROM category WHERE name = "Action")) ))
GROUP BY customer_id; 



#Verify if the above two queries produce the same results or not
#Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.