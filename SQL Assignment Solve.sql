use assignment;
-- 1. Create a table called employees with the following structure?
-- : emp_id (integer, should not be NULL and should be a primary key)Q
-- : emp_name (text, should not be NULL)Q
-- : age (integer, should have a check constraint to ensure the age is at least 18)Q
-- : email (text, should be unique for each employee)Q
-- : salary (decimal, with a default value of 30,000)
-- Write the SQL query to create the above table with all constraints.

CREATE TABLE employees (
    emp_id INTEGER NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INTEGER CHECK (age >= 18),
    email TEXT UNIQUE,
    salary DECIMAL DEFAULT 30000
);

/*2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
examples of common types of constraints.*/

/* Constraints in a database are rules we set on tables or columns to make sure the data is correct and 

reliable. They help keep data accurate, consistent, and free of errors.
 Purpose of Constraints
Accuracy: Constraints prevent wrong data from being entered.
Consistency: They keep data consistent throughout the database.
Integrity: They ensure data follows rules, like avoiding duplicates or missing information.
Common Types of Constraints
PRIMARY KEY: Makes sure each row is unique. Example: emp_id INTEGER PRIMARY KEY ensures every employee 
has a unique ID.

FOREIGN KEY: Links two tables to ensure valid relationships. Example: department_id in employees can 
link to a departments table.

UNIQUE: Prevents duplicate values. Example: email VARCHAR(255) UNIQUE ensures each employee's email is unique.

NOT NULL: Requires a value in the column, not allowing empty (NULL) entries. Example: emp_name TEXT NOT NULL ensures every employee has a name.

CHECK: Sets a condition on values. Example: age INTEGER CHECK (age >= 18) ensures only employees 18 or older are entered.

DEFAULT: Sets a default value if none is provided. Example: salary DECIMAL DEFAULT 30000 assigns a default salary of 30,000.

*/

/*3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
your answer.*/

/*The NOT NULL constraint is applied to a column to ensure that it always contains a value, and never has a NULL. This is useful when data is required for that column in every row. For example, if we have a emp_name column in an employees table, applying NOT NULL ensures that each employee has a name.

Reasons to Use NOT NULL:
Data Completeness: Ensures that important information (like names, IDs) is never missing.
Data Integrity: Helps maintain the quality of data by enforcing required fields.
Logical Consistency: In many cases, it doesn’t make sense for certain columns to be empty (e.g., every employee should have an ID and name).
Can a Primary Key Contain NULL Values?
No, a primary key cannot contain NULL values. A primary key uniquely identifies each row in a table, 
which means it must have a unique, non-null value for every record. Allowing NULL in a primary key would 
violate this purpose because NULL represents "unknown" or "missing" data, which is neither unique nor 
useful for uniquely identifying rows.

Thus, both uniqueness and the NOT NULL condition are necessary for a primary key to maintain the integrity of 
the table structure.
*/

/*4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
example for both adding and removing a constraint.*/

/* To add or remove constraints on an existing table, we typically use the ALTER TABLE command. Here’s how each operation works:

Steps and SQL Commands
Adding a Constraint:

Use ALTER TABLE with ADD CONSTRAINT.
Specify the type of constraint (e.g., NOT NULL, UNIQUE, CHECK, FOREIGN KEY).
Example: Adding a CHECK constraint to ensure that the age column has values of at least 18.


ALTER TABLE employees
ADD CONSTRAINT chk_age CHECK (age >= 18);
Removing a Constraint:

Use ALTER TABLE with DROP CONSTRAINT.
Note that some databases (like MySQL) use the constraint name for deletion. If you didn’t specify a name
when creating the constraint, the system may have assigned one automatically.
Example: Dropping the chk_age constraint on the age column.


ALTER TABLE employees
DROP CONSTRAINT chk_age;
In MySQL, for dropping a NOT NULL constraint, you can directly use MODIFY or CHANGE:

ALTER TABLE employees
MODIFY age INTEGER;
Important Notes
If you are dropping a PRIMARY KEY, use ALTER TABLE employees DROP PRIMARY KEY;.
Constraints should be used carefully as they enforce data rules and deleting them can impact data 
integrity.
*/

/*5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.*/

/*Consequences of Violating Constraints
Insert Failure: If data doesn’t meet the constraints, the insert will fail. For example, trying to insert a row without a value in a NOT NULL column will result in an error.
Update Failure: Attempting to update data to a value that violates a constraint will also fail. For instance, setting an age column to a value below 18 (if there's a CHECK (age >= 18)) will trigger an error.
Delete Failure: If deleting data would break a FOREIGN KEY relationship, the delete action is blocked.
Example of an Error Message
Suppose you try to insert a NULL value into a NOT NULL column like emp_name. The error message might
 look like this:


ERROR: Column 'emp_name' cannot be NULL
This message indicates that the database rejected the action because it violated the NOT NULL constraint 
on emp_name. Constraints protect data accuracy by preventing invalid operations.*/

/*6. You created a products table without constraints as follows:

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));  
Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00*/

-- Step 1: Primary Key constraint add karna
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

-- Step 2: Default value set karna for price
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;


/*7. You have two tables:

 
Write a query to fetch the student_name and class_name for each student using an INNER JOIN.*/

SELECT students.student_name, classes.class_name
FROM students
INNER JOIN classes ON students.class_id = classes.class_id;

/*8. Consider the following three tables:
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order 

Hint: (use INNER JOIN and LEFT JOIN).*/
SELECT orders.order_id, customers.customer_name, products.product_name
FROM products
LEFT JOIN orders ON products.order_id = orders.order_id
INNER JOIN customers ON orders.customer_id = customers.customer_id;


/*
9. Given the following tables:

Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.*/
SELECT products.product_name, SUM(sales.amount) AS total_sales
FROM products
INNER JOIN sales ON products.product_id = sales.product_id
GROUP BY products.product_name;

/*10. You are given three tables:
Write a query to display the order_id, customer_name, and the quantity of products ordered by each
customer using an INNER JOIN between all three tables.
*/

SELECT orders.order_id, customers.customer_name, SUM(order_details.quantity) AS total_quantity
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
GROUP BY orders.order_id, customers.customer_name;

/*SQL Commands

1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences*/

use mavenmovies
SELECT 
    TABLE_NAME,
    COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    CONSTRAINT_NAME = 'PRIMARY'
    AND TABLE_SCHEMA = 'mavenmovies';  -- Replace with your actual database name

SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = 'mavenmovies'  -- Replace with your actual database name
    AND REFERENCED_TABLE_NAME IS NOT NULL;

/*Primary Keys: The first query will list all tables and columns where a primary key constraint exists.
Foreign Keys: The second query will list columns that serve as foreign keys, linking them to their
referenced tables and columns*/


/*2- List all details of actors*/
use mavenmovies
SELECT * 
FROM actor;

-- 3 -List all customer information from DB.
SELECT * 
FROM customer;

-- 4 -List different countries.
SELECT * 
FROM country;

-- 5 -Display all active customers.
select * from customer;

-- 6 -List of all rental IDs for customer with ID 1.
SELECT rental_id
FROM rental
WHERE customer_id = 1;

-- 7 - Display all the films whose rental duration is greater than 5 .
select * from film
where rental_duration > 5;

-- 8 - List the total number of films whose replacement cost is greater than $15 and less than $20.
SELECT COUNT(*) AS total_films from film
where replacement_cost >15 and replacement_cost < 20;

-- 9 - Display the count of unique first names of actors.
select count(distinct first_name) as Unique_names
from actor;

-- 10- Display the first 10 records from the customer table .
select *  from customer
limit 10;

-- 11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
select * from customer 
where first_name LIKE 'B%'
limit 3;

-- 12 -Display the names of the first 5 movies which are rated as ‘G’.
select * from film
where rating = 'G'
limit 5;

-- 13-Find all customers whose first name starts with "a".
select * from customer
where first_name like 'a%';

-- 14- Find all customers whose first name ends with "a".
select * from customer
where first_name like '%a';

-- 15- Display the list of first 4 cities which start and end with ‘a’ .
select * from city 
where city like 'a%' and city like '%a'
limit 4;

-- 16- Find all customers whose first name have "NI" in any position.
select * from customer
where first_name like '%NI%';

-- 17- Find all customers whose first name have "r" in the second position .
select * from customer 
where first_name like '_r%';

-- 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
select * from customer 
where first_name like 'a%' and length(first_name) >= 5;

-- 19- Find all customers whose first name starts with "a" and ends with "o".
select * from customer
where first_name like 'a%' and first_name like '%o';

-- 20 - Get the films with pg and pg-13 rating using IN operator.
select * from film 
where rating IN ('PG', 'PG-13');

-- 21 - Get the films with length between 50 to 100 using between operator.
select * from film
where length between 50 and 100; 

-- 22 - Get the top 50 actors using limit operator.
select * from actor
limit 50;

-- 23 - Get the distinct film ids from inventory table.
select distinct film_id from inventory;

-- Functions
-- Basic Aggregate Functions:

/*Question 1:
Retrieve the total number of rentals made in the Sakila database.
Hint: Use the COUNT() function.*/
 
use sakila;
SELECT COUNT(rental_id) AS total_rentals
FROM rental;

-- Q2.  Find the average rental duration (in days) of movies rented from the Sakila database.
 -- Hint: Utilize the AVG() function.
 SELECT AVG(DATEDIFF(return_date, rental_date)) AS average_rental_duration
FROM rental;

-- Q3. Display the first name and last name of customers in uppercase.
 -- Hint: Use the UPPER () function
SELECT UPPER(first_name) AS first_name_upper, UPPER(last_name) AS last_name_upper
FROM customer;

-- Q4.  Extract the month from the rental date and display it alongside the rental ID.
-- Hint: Employ the MONTH() function
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;

-- Q5. Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
 -- Hint: Use COUNT () in conjunction with GROUP BY.
SELECT customer_id, COUNT(rental_id) AS rental_count
FROM rental
GROUP BY customer_id;

-- Q6.Find the total revenue generated by each store.
 -- Hint: Combine SUM() and GROUP BY
 SELECT payment_id, SUM(amount) AS total_revenue
FROM payment
GROUP BY store_id;

-- Q7. Determine the total number of rentals for each category of movies.
 -- Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
SELECT c.name AS category, COUNT(r.rental_id) AS total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name;

-- Q8.  Find the average rental rate of movies in each language.
-- Hint: JOIN film and language tables, then use AVG () and GROUP BY.
SELECT 
    l.name AS language,
    AVG(f.rental_rate) AS average_rental_rate
FROM
    film f
        JOIN
    language l ON f.language_id = l.language_id
GROUP BY l.name;

-- Joins
-- Q9. Display the title of the movie, customer s first name, and last name who rented it.
 -- Hint: Use JOIN between the film, inventory, rental, and customer tables.
 SELECT f.title AS movie_title, c.first_name, c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;

-- Q10.  Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
 -- Hint: Use JOIN between the film actor, film, and actor tables
 SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

-- Q11.  Retrieve the customer names along with the total amount they've spent on rentals.
 -- Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY
 SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Q12.  List the titles of movies rented by each customer in a particular city (e.g., 'London').
 -- Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
SELECT c.first_name, c.last_name, f.title AS movie_title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY c.customer_id, f.title;

-- Advanced Joins and GROUP BY:
-- Q13. Display the top 5 rented movies along with the number of times they've been rented.
 -- Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
 SELECT f.title AS movie_title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;

-- Q14. Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
 -- Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY
 SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;


-- Windows Function:

-- 1. Rank the customers based on the total amount they have spent on rentals

SELECT 
    customer_id,
    SUM(payment.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(payment.amount) DESC) AS rank1
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer_id;

-- 2. Calculate the cumulative revenue generated by each film over time.

SELECT 
    film.film_id,
    film.title,
    SUM(payment.amount) AS total_revenue,
    SUM(payment.amount) OVER (PARTITION BY film.film_id ORDER BY rental.rental_date) AS cumulative_revenue
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY film.film_id, rental.rental_date;

-- 3. Determine the average rental duration for each film, considering films with similar lengths.

SELECT 
    film.title,
    film.length,
    AVG(rental_duration) OVER (PARTITION BY film.length) AS avg_rental_duration
FROM film;

-- 4.Identify the top 3 films in each category based on their rental counts.

SELECT 
    film_category.category_id,
    film.title,
    COUNT(rental.rental_id) AS rental_count,
    RANK() OVER (PARTITION BY film_category.category_id ORDER BY COUNT(rental.rental_id) DESC) AS rank1
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN rental ON film.film_id = rental.film_id
GROUP BY film_category.category_id, film.title;

-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.

WITH customer_rentals AS (
    SELECT customer_id, COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY customer_id
)
SELECT 
    customer_id,
    total_rentals,
    total_rentals - AVG(total_rentals) OVER () AS rental_difference
FROM customer_rentals;

-- 6. Find the monthly revenue trend for the entire rental store over time.

SELECT 
    EXTRACT(MONTH FROM payment.payment_date) AS month,
    EXTRACT(YEAR FROM payment.payment_date) AS year,
    SUM(payment.amount) AS monthly_revenue
FROM payment
GROUP BY EXTRACT(MONTH FROM payment.payment_date), EXTRACT(YEAR FROM payment.payment_date)
ORDER BY year, month;

-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

WITH total_spent AS (
    SELECT 
        customer_id, 
        SUM(payment.amount) AS total_spent
    FROM payment
    GROUP BY customer_id
)
SELECT 
    customer_id, 
    total_spent
FROM total_spent
WHERE total_spent >= PERCENTILE_CONT(0.8) within GROUP (ORDER BY total_spent) OVER ();

-- 8. Calculate the running total of rentals per category, ordered by rental count.

SELECT 
    film_category.category_id,
    COUNT(rental.rental_id) AS rental_count,
    SUM(COUNT(rental.rental_id)) OVER (PARTITION BY film_category.category_id ORDER BY COUNT(rental.rental_id)) AS running_total
FROM film_category
JOIN film ON film_category.film_id = film.film_id
JOIN rental ON film.film_id = rental.film_id
GROUP BY film_category.category_id;

-- 9. Find the films that have been rented less than the average rental count for their respective categories.

WITH rental_counts AS (
    SELECT 
        film_category.category_id,
        film.film_id,
        COUNT(rental.rental_id) AS rental_count
    FROM film_category
    JOIN film ON film_category.film_id = film.film_id
    JOIN rental ON film.film_id = rental.film_id
    GROUP BY film_category.category_id, film.film_id
)
SELECT 
    rental_counts.film_id,
    rental_counts.rental_count
FROM rental_counts
JOIN (
    SELECT category_id, AVG(rental_count) AS avg_rental_count
    FROM rental_counts
    GROUP BY category_id
) AS category_avg ON rental_counts.category_id = category_avg.category_id
WHERE rental_counts.rental_count < category_avg.avg_rental_count;

-- 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

SELECT 
    EXTRACT(MONTH FROM payment.payment_date) AS month,
    EXTRACT(YEAR FROM payment.payment_date) AS year,
    SUM(payment.amount) AS monthly_revenue
FROM payment
GROUP BY EXTRACT(MONTH FROM payment.payment_date), EXTRACT(YEAR FROM payment.payment_date)
ORDER BY monthly_revenue DESC
LIMIT 5;



-- Normalization & CTE:


/*  1. First Normal Form (1NF)
a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.
In First Normal Form (1NF), the table must meet these criteria:

All columns must contain atomic values (i.e., no repeating groups or arrays).
Each row must be uniquely identifiable.
A common violation of 1NF might occur in a table like customer if a column contains multiple values for a single customer, such as a list of rented movies stored in a single column.

Example of 1NF Violation: Imagine a customer table where a customer can have multiple rental IDs in one field, such as:

CTE Queries */


-- 2. Second Normal Form (2NF):
/* a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
If it violates 2NF, explain the steps to normalize it.*/

/*Second Normal Form (2NF)
a. Choosing a table in Sakila and determining if its in 2NF:
A common table in the Sakila database that we can use for this explanation is the
 "actor" table. Let’s assume the structure of the actor table looks something like this:*/

actor_id	first_name	last_name	film_id	title
1	John	Doe	101	Matrix
2	Jane	Smith	102	Inception
1	John	Doe	102	Inception
To determine if this table is in 2NF, follow these steps:

Step 1: Check if the table is in 1NF.

1NF (First Normal Form) requires that each column contains atomic values (no repeating groups or arrays). In this case, the table is already in 1NF, as there are no repeating groups or multi-valued columns.
Step 2: Check if the table is in 2NF.

2NF (Second Normal Form) requires that:
The table is in 1NF.
Every non-prime attribute (a column not part of the primary key) is fully functionally dependent on the entire primary key (i.e., there are no partial dependencies).
For this table:

The primary key could be a composite key of (actor_id, film_id) because an actor can act in multiple films.
Non-prime attributes are first_name, last_name, and title.
Now, lets check for partial dependencies:

The first_name and last_name are dependent only on actor_id (not on the entire primary key of (actor_id, film_id)).
The title is dependent only on film_id.
Since these non-prime attributes are not dependent on the entire primary key, the table violates 2NF due to partial dependency.

Steps to normalize the table to 2NF:
Remove partial dependencies:
Create separate tables for actors and films.
The actors table should store actor details (actor_id, first_name, last_name).
The films table should store film details (film_id, title).
Create a third table (a many-to-many relationship table) to link actors and films, which will store actor_id and film_id.
After normalization:

actors table:

actor_id	first_name	last_name
1	John	Doe
2	Jane	Smith
films table:

film_id	title
101	Matrix
102	Inception
actor_films table (junction table):

actor_id	film_id
1	101
1	102
2	102
This ensures that the table is now in 2NF.



3. Third Normal Form (3NF)
a. Identifying a table in Sakila that violates 3NF:
Let’s look at the "staff" table in the Sakila database. This table might have the following structure:

staff_id	first_name	last_name	email	store_id	store_address
1	John	Doe	john.doe@mail.com	1	1234 Elm St, NY
2	Jane	Smith	jane.smith@mail.com	2	5678 Oak St, NY
Step 1: Check for transitive dependencies.

Transitive dependency occurs when a non-prime attribute depends on another non-prime attribute through a third attribute. In this case:
store_address depends on store_id (not directly on staff_id).
email depends directly on staff_id, and store_id is associated with the staff, but store_address is not directly related to the staff.
This creates a transitive dependency where:

store_address is indirectly dependent on staff_id through store_id.
Steps to normalize to 3NF:
Remove the transitive dependency:
Create a new table for stores, which will contain store_id and store_address.
In the staff table, store only the store_id (instead of store_address).
After normalization:

staff table:

staff_id	first_name	last_name	email	store_id
1	John	Doe	john.doe@mail.com	1
2	Jane	Smith	jane.smith@mail.com	2
stores table:

store_id	store_address
1	1234 Elm St, NY
2	5678 Oak St, NY
Now, the staff table is in 3NF because there are no transitive dependencies.

4. Normalization Process
a. Normalizing a specific table from unnormalized form up to at least 2NF (using the "employees" table):
Lets assume you start with an unnormalized version of the employees table like this:

emp_id	emp_name	emp_address	emp_phone	manager_name	manager_phone
1	John	123 Main St	555-1234	Susan	555-5678
2	Jane	456 Oak St	555-2345	Susan	555-5678
3	Bob	789 Pine St	555-3456	Charlie	555-6789
This table is not in 1NF because:

Multiple pieces of information about the manager (manager_name, manager_phone) are stored in the same table.
Step 1: Convert to 1NF.

Split repeating groups into atomic values. You can start by creating a new table for managers (storing manager details).
Normalized to 1NF:

emp_id	emp_name	emp_address	emp_phone	manager_id
1	John	123 Main St	555-1234	1
2	Jane	456 Oak St	555-2345	1
3	Bob	789 Pine St	555-3456	2
And the managers table:

manager_id	manager_name	manager_phone
1	Susan	555-5678
2	Charlie	555-6789
Step 2: Convert to 2NF.

/* Check for partial dependencies. The non-prime attributes manager_name and manager_phone depend on manager_id, not on emp_id. Since the table is already in 1NF, this is not a violation of 2NF.
This table is now in 2NF because all non-prime attributes depend on the entire primary key (emp_id, manager_id).

These are the basic steps for analyzing and normalizing a table to 2NF and 3NF using examples from the Sakila database. The process generally involves identifying keys, functional dependencies, and removing redundancies by decomposing the tables into smaller, more efficient structures.
*/


-- 5. CTE Basics:
-- a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor and film_actor tables.
WITH ActorFilms AS (
    SELECT actor_id, COUNT(film_id) AS num_films
    FROM film_actor
    GROUP BY actor_id
)
SELECT a.actor_name, af.num_films
FROM actor a
JOIN ActorFilms af ON a.actor_id = af.actor_id;

-- 6. CTE with Joins:

-- a. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate.

WITH FilmLanguage AS (
    SELECT f.film_id, f.title AS film_title, l.name AS language_name, f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM FilmLanguage;

-- 7. CTE for Aggregation:

-- a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables.

WITH CustomerPayments AS (
    SELECT c.customer_id, SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
)
SELECT c.first_name, c.last_name, cp.total_revenue
FROM customer c
JOIN CustomerPayments cp ON c.customer_id = cp.customer_id;


-- 8.CTE with Window Functions:
-- a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.

/* Rank films based on their rental duration from the film table.
Assuming that the rental duration is stored in the film table (in a column like rental_duration),
 we can rank the films using a window function.*/

WITH FilmRank AS (
    SELECT 
        film_id, 
        title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rental_rank
    FROM film
)
SELECT * FROM FilmRank;
/*Explanation:
This query ranks films based on their rental_duration in descending order. The RANK() window function
assigns a unique rank to each row, with ties in rental_duration receiving the same rank.*/

-- 9. CTE and Filtering:
 /* a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with 
 the customer table to retrieve additional customer details We can create a CTE to find customers with 
 more than two rentals, and then join this result with the customer table to retrieve additional 
 customer details.*/


WITH CustomerRentals AS (
    SELECT customer_id, COUNT(rental_id) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(rental_id) > 2
)
SELECT c.customer_id, c.first_name, c.last_name, c.email
FROM customer c
JOIN CustomerRentals cr ON c.customer_id = cr.customer_id;
-- Explanation:

/* The CustomerRentals CTE finds customers who have made more than two rentals by counting rental transactions
 grouped by customer_id.We then join the result with the customer table to get customer details like 
 first_name, last_name, and email.*/


/*10. CTE for Date Calculations:
 a. Write a query using a CTE to find the total number of rentals made each month, considering the
rental_date from the rental table.Find the total number of rentals made each month, based on the 
rental_date from the rental table.*/

-- We'll use a CTE to aggregate the rentals by month and year.
WITH MonthlyRentals AS (
    SELECT 
        EXTRACT(YEAR FROM rental_date) AS rental_year,
        EXTRACT(MONTH FROM rental_date) AS rental_month,
        COUNT(rental_id) AS total_rentals
    FROM rental
    GROUP BY rental_year, rental_month
    ORDER BY rental_year, rental_month
)
SELECT * FROM MonthlyRentals;
/*Explanation:

The EXTRACT(YEAR FROM rental_date) and EXTRACT(MONTH FROM rental_date) functions are used to group rentals by year and month.
The COUNT(rental_id) counts the number of rentals per month.*/



/*11. CTE and Self-Join:
a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
together, using the film_actor table.*/

/*Generate a report showing pairs of actors who have appeared in the same film together, using the 
film_actor table.*/

-- We'll use a self-join on the film_actor table to find pairs of actors who appear in the same film.
WITH ActorPairs AS (
    SELECT 
        fa1.actor_id AS actor1_id,
        fa2.actor_id AS actor2_id,
        fa1.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE fa1.actor_id < fa2.actor_id  -- To avoid repeating pairs
)
SELECT 
    a1.actor_id AS actor1_id,
    a2.actor_id AS actor2_id,
    f.title
FROM ActorPairs ap
JOIN actor a1 ON ap.actor1_id = a1.actor_id
JOIN actor a2 ON ap.actor2_id = a2.actor_id
JOIN film f ON ap.film_id = f.film_id;
-- Explanation:

/* The CTE ActorPairs creates pairs of actors who are in the same movie by joining the film_actor
 table with itself (fa1 and fa2).
We filter out reversed pairs using fa1.actor_id < fa2.actor_id.
After that, we join with the actor and film tables to get the actor names and film titles.
*/

/* 12. CTE for Recursive Search:
 a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager,
 considering the reports_to column.Find all employees in the staff table who report to a specific 
 manager,considering the reports_to column.

A recursive CTE can be used to find all employees who report to a particular manager, even in nested
hierarchies.*/
WITH RECURSIVE EmployeeHierarchy AS (
    -- Base case: start with the manager (replace 'manager_id' with actual ID)
    SELECT staff_id, first_name, last_name, reports_to
    FROM staff
    WHERE staff_id = 1  -- Example manager ID

    UNION ALL

    -- Recursive case: find employees who report to someone already in the hierarchy
    SELECT s.staff_id, s.first_name, s.last_name, s.reports_to
    FROM staff s
    JOIN EmployeeHierarchy eh ON s.reports_to = eh.staff_id
)
SELECT * FROM EmployeeHierarchy;
-- Explanation:
/*
The EmployeeHierarchy CTE starts with a specific manager (in this case, staff member with staff_id = 1).
The recursive part of the CTE joins the staff table on reports_to to find employees who report to the already selected staff members.
*/






