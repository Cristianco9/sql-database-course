-- =============================================================================
-- Retail Sales and Inventory Management System
-- Answers to the 30 practice queries
-- =============================================================================

-- =============================================================================
-- Level 1: Beginner
-- =============================================================================

-- 1.1 Which departments (states) of Colombia exist in our database?
SELECT id, name 
FROM department
WHERE country = (
	SELECT id 
	from country
	WHERE name = 'Colombia'
);

-- 1.2 What are the 5 most expensive products?
-- With duplicate records
SELECT *
FROM product
ORDER BY unit_price DESC
LIMIT 5;

-- With unique products
SELECT * 
FROM (
	SELECT DISTINCT ON (description) *
	FROM product
	ORDER BY description, unit_price DESC
)
ORDER BY unit_price DESC
LIMIT 5;

-- 1.3 Which products cost less than 25 USD?
SELECT *
FROM product
WHERE unit_price <= 25
ORDER BY unit_price DESC;

-- 1.4 Which products (supplier 2) cost between 100 and 130 USD?
SELECT *
FROM product
WHERE supplier_id = 2 
	AND unit_price BETWEEN 100 AND 130
ORDER BY unit_price DESC;

-- 1.5 Which products are slides (sandals)?
SELECT *
FROM product
WHERE name LIKE '%Slides%'
ORDER BY sku;

-- 1.6 Show the cities Bogotá, Medellín, Cali and Barranquilla.
SELECT *
FROM city
WHERE name IN ('Bogotá', 'Medellín', 'Cali', 'Barranquilla')
ORDER BY id;

-- 1.7 Which users do not have a second lastname?
SELECT * 
FROM "user"
WHERE second_lastname IS NULL
ORDER BY id ASC;

-- 1.8 Which document types are actually used by our users?
SELECT DISTINCT document_type
FROM "user"
ORDER BY document_type ASC;

-- How many sales have we made, and how many different customers bought?
SELECT 	
	COUNT(*) 					AS total_sales,
	COUNT(DISTINCT customer) 	AS customers_who_bought
FROM sale;

-- What is the smallest, the largest, the average and the total value of the paid payments?
SELECT 
	MIN(total)			AS smallest_payment,
	MAX(total)			AS largest_payment,
	ROUND(AVG(total),3)	AS average_payment,
	SUM(total)			AS total_collected
FROM payment
WHERE status = (
	SELECT id
	FROM payment_status
	WHERE name = 'Paid'
);