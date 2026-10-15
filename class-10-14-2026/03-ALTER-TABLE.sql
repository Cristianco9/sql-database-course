-- =============================================================================
-- Retail Sales and Inventory Management System
-- ALTER TABLE examples
-- Run after 01_schema.sql and the INSERT statements
-- =============================================================================

-- =============================================================================
-- Alter product table with a new column (release_date)
-- with the datatype date, cannot be null and by default is the current date.
-- (The table already has rows, so a NOT NULL column needs a DEFAULT value;
-- without it PostgreSQL cannot fill the existing rows and raises an error.)
-- =============================================================================
SELECT * FROM product;

ALTER TABLE product
ADD COLUMN IF NOT EXISTS release_date DATE NOT NULL DEFAULT CURRENT_DATE;

SELECT * FROM product;

-- =============================================================================
-- Alter store table with a new column (is_active)
-- with the datatype boolean by default should be true.
-- =============================================================================
SELECT * FROM store;

ALTER TABLE store
ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE;

SELECT * FROM store;

-- =============================================================================
-- Alter customer table with a new column (purchases_count)
-- with the datatype integer by default should be 0 and cannot be null.
-- (loyalty_points is already part of the customer table design)
-- =============================================================================
SELECT * FROM customer;

ALTER TABLE customer
ADD COLUMN IF NOT EXISTS purchases_count INT NOT NULL DEFAULT 0 CHECK (purchases_count >= 0);

SELECT * FROM customer;

-- =============================================================================
-- Alter user table with a new column (notes)
-- with the datatype text and can be null.
-- =============================================================================
SELECT * FROM "user";

ALTER TABLE "user"
ADD COLUMN IF NOT EXISTS notes TEXT;

SELECT * FROM "user";

-- =============================================================================
-- Reverse process, delete the new added columns
-- =============================================================================
ALTER TABLE product
DROP COLUMN IF EXISTS release_date;

SELECT * FROM product;

-- =============================================================================
ALTER TABLE store
DROP COLUMN IF EXISTS is_active;

SELECT * FROM store;

-- =============================================================================
ALTER TABLE customer
DROP COLUMN IF EXISTS purchases_count;

SELECT * FROM customer;

-- =============================================================================
ALTER TABLE "user"
DROP COLUMN IF EXISTS notes;

SELECT * FROM "user";