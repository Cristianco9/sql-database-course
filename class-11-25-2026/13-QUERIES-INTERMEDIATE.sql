-- =============================================================================
-- Retail Sales and Inventory Management System
-- Answers to the 30 practice queries
-- =============================================================================

-- =============================================================================
-- Level 2: Intermediate
-- =============================================================================

-- 2.1 Show every city together with the name of its department.
SELECT c.name, d.name
FROM city AS c
INNER JOIN department AS d ON c.department = d.id
ORDER BY d.name ASC

-- 2.2 List every store with its city and department.
SELECT 
	s.name	AS store, 
	address	AS store_address, 
	c.name	AS city, 
	d.name	AS department
FROM store AS s
INNER JOIN city AS c ON c.id = s.city
INNER JOIN department AS d ON d.id = c.department
ORDER BY d.name, c.name ASC;

-- 2.3 List every store with its city and department
SELECT
	sp.name 					AS supplier,
	COUNT(*)					AS products,
	ROUND(AVG(p.unit_price), 3) AS average_price
FROM product AS p
INNER JOIN supplier AS sp ON p.supplier_id = sp.id
GROUP BY sp.name
ORDER BY products DESC;

-- 2.4 How many payments do we have in each status, and how much money does each status represent?
SELECT
	ps.name					AS payment_status,
	COUNT(*) 				AS payments,
	ROUND(SUM(p.total), 3)	AS total_USD
FROM payment AS p
INNER JOIN payment_status AS ps ON ps.id = p.status
GROUP BY ps.name
ORDER BY payments DESC;

-- 2.5 Which categories contain more than 10 products?
SELECT
	c.name		AS category_name,
	COUNT(*)	AS products
FROM product_category AS pc
INNER JOIN category AS c ON c.id = pc.category_id
GROUP BY c.name
HAVING COUNT(*) > 10
ORDER BY products DESC, category_name;

-- 2.6 Which customers have never bought anything?
SELECT 
	cu.id AS customer_id,
    u.first_name,
    u.first_lastname,
    u.email
FROM customer AS cu
JOIN "user" AS u ON u.id = cu.user_data
LEFT JOIN sale AS s ON s.customer = cu.id
WHERE s.id IS NULL
ORDER BY cu.id;

-- 2.7 How many sales did we make in each month?
SELECT 
	TO_CHAR(DATE_TRUNC('month', date), 'YYYY-MM') AS month,
    COUNT(*) AS sales
FROM sale
GROUP BY month
ORDER BY month;

-- 2.8 In which countries are our products manufactured?
SELECT 
	details->>'country_of_origin' AS origin,
    COUNT(*)                      AS products
FROM product
GROUP BY details->>'country_of_origin'
ORDER BY products DESC, origin;

-- 2.9 How many products are Budget (< 30 USD), Standard (30 to 99.99 USD) and Premium (100 USD or more)?
SELECT 
	CASE
		WHEN unit_price < 30  THEN 'Budget'
    	WHEN unit_price < 100 THEN 'Standard'
    	ELSE 'Premium'
    END      AS price_tier,
	COUNT(*) AS products
FROM product
GROUP BY price_tier
ORDER BY MIN(unit_price);

-- 2.10 Which are the 10 most expensive products that cost more than the average product?
SELECT name, unit_price
FROM product
WHERE unit_price > (SELECT AVG(unit_price) FROM product)
ORDER BY unit_price DESC, name
LIMIT 10;
