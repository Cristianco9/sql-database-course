-- =============================================================================
-- Retail Sales and Inventory Management System
-- TRUNCATE practice examples
-- =============================================================================
-- TRUNCATE removes ALL rows from a table very fast.
-- It cannot use WHERE. It can be rolled back in PostgreSQL.
-- Common options:
--   RESTART IDENTITY  -> reset the id counter to 1
--   CASCADE           -> also truncate tables that depend on it
--
-- WARNING: TRUNCATE is DESTRUCTIVE. Run these examples in a development
-- database, never in production, unless you know exactly what you are doing.
-- =============================================================================

-- =============================================================================
-- Example 1: Basic TRUNCATE
-- =============================================================================
-- Empty a table that no other table depends on.
SELECT * FROM payment_status;   -- 5 rows
TRUNCATE TABLE payment_status;
SELECT * FROM payment_status;   -- 0 rows

-- =============================================================================
-- Example 2: TRUNCATE + RESTART IDENTITY
-- =============================================================================
-- Use this to reset the id counter back to 1.
-- Good when you want to reload fresh data.

TRUNCATE TABLE payment_status RESTART IDENTITY;

INSERT INTO payment_status (name) VALUES ('Paid');
SELECT * FROM payment_status;   -- the new row has id = 1

-- =============================================================================
-- Example 3: TRUNCATE + CASCADE
-- =============================================================================
-- "sale" is used by "sale_detail" and "payment".
-- A plain TRUNCATE fails, so we need CASCADE.

TRUNCATE TABLE sale;            -- ERROR: foreign key constraint

TRUNCATE TABLE sale CASCADE;       -- also empties sale_detail and payment

SELECT COUNT(*) FROM sale;         -- 0
SELECT COUNT(*) FROM sale_detail;  -- 0
SELECT COUNT(*) FROM payment;      -- 0

-- =============================================================================
-- Example 4: TRUNCATE several tables at once
-- =============================================================================
-- Separate tables with commas. Everything happens in one step.

TRUNCATE TABLE
    payment,
    sale_detail,
    sale
RESTART IDENTITY CASCADE;

SELECT COUNT(*) FROM payment;       -- 0
SELECT COUNT(*) FROM sale_detail;   -- 0
SELECT COUNT(*) FROM sale;          -- 0

-- =============================================================================
-- Example 5: TRUNCATE inside a transaction
-- =============================================================================
-- TRUNCATE can be rolled back. Great for practicing safely.

BEGIN;
    TRUNCATE TABLE 
        inventory_transfer_detail, 
        inventory_transfer;
    SELECT COUNT(*) FROM inventory_transfer;    -- 0 inside the transaction
ROLLBACK;

SELECT COUNT(*) FROM inventory_transfer_detail;     -- 0 inside the transaction_detail
SELECT COUNT(*) FROM inventory_transfer;            -- data is back

-- =============================================================================
-- Example 6: Reset the whole database (development only)
-- =============================================================================
-- Empties every table and resets every id to 1.
-- Use it before re-running 06-INSERT-DATASET.sql.

TRUNCATE TABLE
    payment,
    sale_detail, sale,
    inventory_transfer_detail, inventory_transfer, inventory_stock, inventory,
    product_category, product,
    store_phone, supplier_phone, user_phone,
    employee, customer, "user",
    store, supplier,
    phone, category, type_inventory_transfer, payment_status, payment_method,
    document_type, role, user_type,
    city, department, country
RESTART IDENTITY CASCADE;

-- The database is now empty and ready for a fresh load.

-- =============================================================================
-- Example 7: TRUNCATE child tables first (no CASCADE needed)
-- =============================================================================
-- If you empty the child tables first, the parent can be truncated
-- without CASCADE. Useful when you want to control the order yourself.

TRUNCATE TABLE payment;
TRUNCATE TABLE sale_detail;
TRUNCATE TABLE sale;                -- no CASCADE, children are already empty

SELECT COUNT(*) FROM payment;       -- 0
SELECT COUNT(*) FROM sale_detail;   -- 0
SELECT COUNT(*) FROM sale;          -- 0

-- =============================================================================
-- Example 8: TRUNCATE an empty table (safe)
-- =============================================================================
-- Truncating an already-empty table does not fail, it just does nothing.

TRUNCATE TABLE payment_status;
SELECT COUNT(*) FROM payment_status;  -- 0

TRUNCATE TABLE payment_status;        -- runs again, still OK
SELECT COUNT(*) FROM payment_status;  -- 0

-- =============================================================================
-- Example 9: TRUNCATE with SAVEPOINT inside a transaction
-- =============================================================================
-- A SAVEPOINT lets you undo only part of the transaction.
-- Here we keep the first truncate and undo the second one.

BEGIN;
    TRUNCATE TABLE payment;
    SAVEPOINT after_payment;
    TRUNCATE TABLE sale_detail;
    ROLLBACK TO SAVEPOINT after_payment;   -- undo only sale_detail
    -- payment is still empty, sale_detail is back
COMMIT;

SELECT COUNT(*) FROM payment;         -- 0
SELECT COUNT(*) FROM sale_detail;     -- data is back

-- =============================================================================
-- Example 10: TRUNCATE several independent catalog tables
-- =============================================================================
-- These catalog tables do not depend on each other,
-- so one TRUNCATE statement is enough. No CASCADE needed.

TRUNCATE TABLE
    payment_method,
    document_type,
    role,
    user_type
RESTART IDENTITY;

SELECT COUNT(*) FROM payment_method;   -- 0
SELECT COUNT(*) FROM document_type;    -- 0
SELECT COUNT(*) FROM role;             -- 0
SELECT COUNT(*) FROM user_type;        -- 0