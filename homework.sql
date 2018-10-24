use sakila;


-- * 1a. Display the first and last names of all actors from the table `actor`.
select first_name, last_name 
from actor;

-- * 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
select actor_id, first_name, last_name
from actor
where first_name="Joe";

-- * 2b. Find all actors whose last name contain the letters `GEN`:
select actor_id, first_name, last_name
from actor
where last_name like "%GEN%";

-- * 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:
select last_name, first_name
from actor
where last_name like "%LI%";

-- * 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: 
-- Afghanistan, Bangladesh, and China:
select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

-- * 3a. You want to keep a description of each actor. You don't think you will be performing queries on a 
-- description, so create a column in the table `actor` named `description` and use the data type `BLOB` 
-- (Make sure to research the type `BLOB`, as the difference between it and `VARCHAR` are significant).
ALTER TABLE actor
ADD description BLOB;
select * from actor;

-- * 3b. Very quickly you realize that entering descriptions for each actor is too much effort. 
-- Delete the `description` column.
ALTER TABLE actor 
DROP description;
select * from actor;

-- * 4a. List the last names of actors, as well as how many actors have that last name.
select last_name, COUNT(*) as "nb of actors"
from actor
group by last_name;

-- * 4b. List last names of actors and the number of actors who have that last name, 
-- but only for names that are shared by at least two actors
select last_name, COUNT(*) as "nb of actors"
from actor
group by last_name
having COUNT(*)>1;

-- * 4c. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. 
-- Write a query to fix the record.
UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" and last_name = "WILLIAMS";
select * from actor;

-- * 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. 
-- It turns out that `GROUCHO` was the correct name after all! 
-- In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.
UPDATE actor
SET first_name = "GROUCHO"
WHERE actor_id = (SELECT actor_id FROM (
					select * from actor
					WHERE first_name = "HARPO") as x);
-- To avoid having to set the safe update to 0, I had to filter the UPDATE statement on a PRIMARY KEY
-- the primary_key is the actor_id but to select the right actor ID with the first name condition
-- I had to create another "fake" table in the query: https://www.xaprb.com/blog/2006/06/23/how-to-select-from-an-update-target-in-mysql/

-- * 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?
--   * Hint: [https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html](https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html)
SHOW CREATE TABLE address;

-- * 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. 
-- Use the tables `staff` and `address`:
select s.first_name, s.last_name, a.address
from staff as s
inner join address as a ON s.address_id=a.address_id;

-- * 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. 
-- Use tables `staff` and `payment`.
SELECT s.first_name, s.last_name, pg.total_amount as "Total august sale"
from staff as s
join (SELECT staff_id, sum(amount) as "total_amount"
	  from payment
	  WHERE (payment_date >= '2005-08-01 00:00:00') and (payment_date <='2005-08-31 00:00:00')
	  group by staff_id) as pg ON s.staff_id=pg.staff_id;

-- * 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.







-- * 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
-- 
-- * 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:
-- 
--   ![Total amount paid](Images/total_payment.png)
-- 
-- * 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.
-- 
-- * 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
-- 
-- * 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
-- 
-- * 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.
-- 
-- * 7e. Display the most frequently rented movies in descending order.
-- 
-- * 7f. Write a query to display how much business, in dollars, each store brought in.
-- 
-- * 7g. Write a query to display for each store its store ID, city, and country.
-- 
-- * 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
-- 
-- * 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
-- 
-- * 8b. How would you display the view that you created in 8a?
-- 
-- * 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.
