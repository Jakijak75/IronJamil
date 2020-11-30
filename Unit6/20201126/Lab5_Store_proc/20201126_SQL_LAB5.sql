
#In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. Convert the query into a simple stored procedure. Use the following query:

  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  
#here we go
  
  drop procedure if exists action_movie_clients;

delimiter //
create procedure action_movie_clients()
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
end;
//
delimiter ;

call action_movie_clients();

#Now keep working on the previous stored procedure to make it more dynamic. Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre. For eg., it could be action, animation, children, classics, etc.
  drop procedure if exists action_movie_clients;

delimiter //
create procedure action_movie_clients (IN param1 VARCHAR(50))
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = param1
  group by first_name, last_name, email;
end;
//
delimiter ;

call action_movie_clients("horror");

#YYYEEEESSSS

#Write a query to check the number of movies released in each movie category. Convert the query in to a stored procedure to filter only those categories that have movies released greater than a certain number. Pass that number as an argument in the stored procedure.
SELECT c.name, COUNT(f.film_id) as no_films FROM film_category f
join category c using (category_id)
GROUP BY c.name;

#creating Proc

drop procedure if exists proc_movie_min;

delimiter //
create procedure proc_movie_min (IN param1 INT)
begin
	SELECT c.name, COUNT(f.film_id) as no_films FROM film_category f
	join category c using (category_id)
	GROUP BY c.name
	HAVING no_films > param1;
end;
//
delimiter ;

call proc_movie_min(63);


#YES

