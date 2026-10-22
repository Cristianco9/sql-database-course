-- =============================================================================
-- Retail Sales and Inventory Management System
-- UPDATE practice examples
-- =============================================================================
-- UPDATE changes existing rows (it never adds or removes rows).
-- Use WHERE to choose which rows change.
-- Without WHERE, EVERY row in the table is updated.
-- It can be rolled back in PostgreSQL.
--
-- WARNING: a wrong UPDATE can corrupt data. Use it on a development
-- database and always check the result with SELECT.
-- =============================================================================

-- =============================================================================
-- Example 1: Basic UPDATE (one row)
-- =============================================================================
-- Change one row using its primary key.
SELECT * FROM store WHERE id = 1;
UPDATE store SET name = 'Adidas Sport Bogotá Centro' WHERE id = 1;
SELECT * FROM store WHERE id = 1;

-- =============================================================================
-- Example 2: UPDATE several columns at once
-- =============================================================================
-- Separate the columns with commas.
UPDATE "user"
SET email   = 'felipe.diaz@domain.com.co',
    address = 'Calle 100 # 15-20'
WHERE id = 1;

SELECT email, address FROM "user" WHERE id = 1;

-- =============================================================================
-- Example 3: UPDATE many rows (10% price increase)
-- =============================================================================
-- The same change is applied to every row that matches WHERE.
UPDATE product
SET unit_price = unit_price * 1.10
WHERE supplier_id = 1;

SELECT sku, unit_price FROM product WHERE supplier_id = 1;

-- =============================================================================
-- Example 4: UPDATE using arithmetic on the current value
-- =============================================================================
-- Add points to the value already stored in the row.
UPDATE customer
SET loyalty_points = loyalty_points + 100
WHERE id = 1;

SELECT id, loyalty_points FROM customer WHERE id = 1;

-- =============================================================================
-- Example 5: UPDATE with CASE
-- =============================================================================
-- CASE lets you set different values in the same statement.
UPDATE inventory_stock
SET minimum_stock = CASE
    WHEN quantity_available < 100 THEN 10
    ELSE 20
END
WHERE inventory = 1;

SELECT product, quantity_available, minimum_stock
FROM inventory_stock
WHERE inventory = 1
LIMIT 5;

-- =============================================================================
-- Example 6: UPDATE with NULL and COALESCE
-- =============================================================================
-- COALESCE(a, b) returns a if it is not NULL, otherwise b.
-- Useful to fill empty columns.
UPDATE "user" SET middle_name = NULL WHERE id = 3;

UPDATE "user"
SET second_lastname = COALESCE(second_lastname, 'N/A')
WHERE id = 10;

SELECT first_name, middle_name, second_lastname FROM "user" WHERE id IN (3, 10);

-- =============================================================================
-- Example 7: UPDATE using another table (UPDATE ... FROM)
-- =============================================================================
-- The store on each sale must match the store of its employee.
-- FROM lets us read the employee table inside the UPDATE.
-- (0 rows change if the data is already consistent.)
UPDATE sale
SET store = employee.store
FROM employee
WHERE sale.employee = employee.id
  AND sale.store <> employee.store;

SELECT COUNT(*) FROM sale;

-- =============================================================================
-- Example 8: UPDATE with a subquery in WHERE
-- =============================================================================
-- Give extra points to every customer who bought in store 1.
UPDATE customer
SET loyalty_points = loyalty_points + 200
WHERE id IN (
    SELECT customer FROM sale WHERE store = 1
);

SELECT COUNT(*) FROM customer WHERE loyalty_points >= 200;

-- =============================================================================
-- Example 9: UPDATE with RETURNING
-- =============================================================================
-- RETURNING shows the changed rows, so you can check the result immediately.
UPDATE product
SET unit_price = unit_price * 0.90
WHERE supplier_id = 3
RETURNING id, sku, unit_price;

-- =============================================================================
-- Example 10: UPDATE inside a transaction (safe practice)
-- =============================================================================
-- The update can be undone with ROLLBACK.
BEGIN;
    UPDATE inventory_stock
    SET quantity_available = 0
    WHERE inventory = 1;

    SELECT COUNT(*) FROM inventory_stock
    WHERE inventory = 1 AND quantity_available = 0;   -- 200 inside the transaction
ROLLBACK;

SELECT * FROM inventory_stock
WHERE inventory = 1 AND product = 1;                  -- original value is back