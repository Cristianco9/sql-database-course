-- =============================================================================
-- Alter product table with a new column (release_date)
-- =============================================================================
SELECT * FROM product;

ALTER TABLE product
ADD COLUMN IF NOT EXISTS release_date DATE NOT NULL;

-- =============================================================================
-- Alter store table with a new column (is_active) 
-- with the datatype boolean by default should be true.
-- =============================================================================
SELECT * FROM store;

ALTER TABLE store
ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT TRUE;

-- =============================================================================
-- Alter customer table with a new column (loyalty_points) 
-- with the datatype integer by default should be 0 and cannot be null.
-- =============================================================================
SELECT * FROM customer;

ALTER TABLE customer
ADD COLUMN IF NOT EXISTS loyalty_points INT NOT NULL DEFAULT 0;

-- =============================================================================
-- Alter user table with a new column (notes) 
-- with the datatype text and can be null.
-- =============================================================================
SELECT * FROM "user";

ALTER TABLE "user"
ADD COLUMN IF NOT EXISTS notes TEXT;

-- =============================================================================
-- Reverse process, delete the new added columns
-- =============================================================================
SELECT * FROM product;

ALTER TABLE product
DROP COLUMN release_date; 

-- =============================================================================
SELECT * FROM store;

ALTER TABLE store
DROP COLUMN is_active; 

-- =============================================================================
SELECT * FROM customer;

ALTER TABLE customer
DROP COLUMN loyalty_points;

-- =============================================================================
SELECT * FROM "user";

ALTER TABLE "user"
DROP COLUMN notes;