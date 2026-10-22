-- =============================================================================
-- Retail Sales and Inventory Management System
-- DELETE practice examples
-- =============================================================================
-- DELETE removes rows from a table.
-- Use WHERE to choose which rows go. Without WHERE, ALL rows go.
-- Rows used by other tables cannot be deleted until the child rows are gone.
-- It can be rolled back in PostgreSQL.
--
-- WARNING: a wrong DELETE can lose data. Always check with SELECT first,
-- and use it on a development database.
-- =============================================================================

-- =============================================================================
-- Example 1: Basic DELETE (one row by primary key)
-- =============================================================================
-- product_category is a child table, so nothing depends on it.
SELECT * FROM product_category WHERE id = 1;
DELETE FROM product_category WHERE id = 1;
SELECT * FROM product_category WHERE id = 1;   -- no rows

-- =============================================================================
-- Example 2: DELETE with a comparison operator
-- =============================================================================
-- Remove the stock rows that have zero units available.
SELECT COUNT(*) FROM inventory_stock WHERE quantity_available = 0;   -- 26 rows
DELETE FROM inventory_stock WHERE quantity_available = 0;
SELECT COUNT(*) FROM inventory_stock WHERE quantity_available = 0;   -- 0 rows

-- =============================================================================
-- Example 3: DELETE with an IN list
-- =============================================================================
-- IN checks a column against a list of values.
DELETE FROM inventory_stock
WHERE inventory = 3
  AND product IN (1, 2, 3);
SELECT * FROM inventory_stock WHERE inventory = 3 AND product IN (1, 2, 3);  -- empty

-- =============================================================================
-- Example 4: DELETE with BETWEEN
-- =============================================================================
-- BETWEEN x AND y matches values from x to y (both included).
DELETE FROM inventory_stock
WHERE inventory = 4
  AND quantity_available BETWEEN 0 AND 5;

SELECT COUNT(*) FROM inventory_stock WHERE inventory = 4;   -- 68 rows are left

-- =============================================================================
-- Example 5: DELETE with LIKE (and a safety filter)
-- =============================================================================
-- LIKE searches text by pattern. % means "any text".
-- Users still linked to customer or employee cannot be deleted,
-- so we skip them with NOT IN.
DELETE FROM "user"
WHERE email LIKE '%@hotmail.com'
  AND id NOT IN (SELECT user_data FROM customer)
  AND id NOT IN (SELECT user_data FROM employee);
-- 0 rows deleted: every @hotmail.com user is still a customer.

-- =============================================================================
-- Example 6: Delete child rows first, then the parent
-- =============================================================================
-- phone is used by user_phone, so the link must go before the phone.
DELETE FROM user_phone WHERE phone_id = 257;
DELETE FROM phone WHERE id = 257;     -- now it works
SELECT * FROM phone WHERE id = 257;   -- no rows

-- =============================================================================
-- Example 7: DELETE with a subquery in WHERE
-- =============================================================================
-- The subquery returns the sale ids of one store, and we delete their payments.
DELETE FROM payment
WHERE sale_id IN (
    SELECT id FROM sale WHERE store = 22
);
SELECT COUNT(*) FROM payment;   -- the payments of store 22 are gone

-- =============================================================================
-- Example 8: DELETE with USING (join style)
-- =============================================================================
-- USING lets you read another table inside the DELETE.
DELETE FROM inventory_stock
USING product
WHERE inventory_stock.product = product.id
  AND product.supplier_id = 3
  AND inventory_stock.inventory = 1;

SELECT COUNT(*) FROM inventory_stock WHERE inventory = 1;   -- fewer rows

-- =============================================================================
-- Example 9: DELETE with RETURNING
-- =============================================================================
-- RETURNING shows the rows that were deleted.
DELETE FROM inventory_stock
WHERE inventory = 5
  AND quantity_available < 10
RETURNING product, quantity_available;

-- =============================================================================
-- Example 10: DELETE inside a transaction (safe practice)
-- =============================================================================
-- The delete can be undone with ROLLBACK.
BEGIN;
    DELETE FROM sale_detail WHERE sale_detail = 1;
    DELETE FROM payment WHERE sale_id = 1;
    DELETE FROM sale WHERE id = 1;

    SELECT COUNT(*) FROM sale WHERE id = 1;   -- 0 inside the transaction
ROLLBACK;

SELECT COUNT(*) FROM sale WHERE id = 1;       -- the row is back