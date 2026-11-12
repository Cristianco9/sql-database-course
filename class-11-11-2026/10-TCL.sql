-- =============================================================================
-- Retail Sales and Inventory Management System
-- COMMIT, ROLLBACK, and SAVEPOINT practice examples
-- Run after 01_schema.sql
-- =============================================================================
-- BEGIN        -> start a transaction
-- COMMIT       -> save all change permanently
-- ROLLBACK     -> undoes all change in the transaction
-- SAVEPOINT    -> marks a point you can return to with ROLLBACK TO

-- WARNING: these examples change data. Use them on a development database 
-- =============================================================================

-- =============================================================================
-- ROLLBACK
-- =============================================================================

-- =============================================================================
-- Example 1 (ROLLBACK): Undo an UPDATE
-- =============================================================================
-- Change price, check it, then undo everything.

BEGIN;

    UPDATE product
    SET unit_price  = 999.99
    WHERE id = 1;

    SELECT id, sku, unit_price
    FROM product
    WHERE id = 1;

ROLLBACK;

SELECT id, sku, unit_price
FROM product
WHERE id = 1;

-- =============================================================================
-- Example 2 (ROLLBACK): Undo an INSERT
-- =============================================================================
-- Add a new row, then decide it is a mistake and undo it.

BEGIN;

    INSERT INTO category (name)
    VALUES ('Test Category');

    SELECT * FROM category
    WHERE name = 'Test Category';

ROLLBACK;

SELECT * FROM category
WHERE name = 'Test Category';

-- =============================================================================
-- COMMIT
-- =============================================================================

-- =============================================================================
-- Example 3 (COMMIT): Save a new customer
-- =============================================================================
-- Insert a user and its customer row in one transaction.
-- COMMIT save both rows permanently.

BEGIN;

    INSERT INTO "user" (
        document_number,
        document_type,
        user_type,
        first_name,
        middle_name,
        first_lastname,
        second_lastname,
        email,
        address,
        description
    )
    VALUES (
        '9999999999',
        1,
        1,
        'Clark',
        'Joseph',
        'Ken',
        'Jr',
        'superman@justice.league',
        'Antarctic - Castle Ice',
        'Hidden Superhero'
    );

    INSERT INTO customer (
        user_data, 
        loyalty_points
    )
    VALUES(
        (
            SELECT id FROM "user" 
            WHERE document_number = '9999999999'
        ),
        898
    );

COMMIT;

SELECT * FROM "user" 
WHERE document_number = '9999999999';

-- =============================================================================
-- Example 4 (COMMIT): Sale one product (multi-table change)
-- =============================================================================
-- Insert a sale, its detail, and a paid payment together.
-- All three rows are saved with one COMMIT.

BEGIN;

    INSERT INTO sale (
        customer,
        employee,
        store
    )
    VALUES (
        1,
        1,
        1
    );

    INSERT INTO sale_detail (
        sale_detail,
        product_id,
        quantity,
        discount
    )
    VALUES (
        (SELECT id FROM sale ORDER BY id DESC LIMIT 1),
        1,
        2,
        0.00
    );

    INSERT INTO payment (
        sale_id,
        status,
        method,
        discount,
        tax,
        subtotal,
        total
    )
    VALUES (
        (SELECT id FROM sale ORDER BY id DESC LIMIT 1),
        2,
        3,
        0.00,
        72.19,
        379.98,
        452.17
    );

COMMIT;

SELECT * FROM sale              WHERE id =  (SELECT id FROM sale ORDER BY id DESC LIMIT 1);
SELECT * FROM sale_detail       WHERE sale_detail =  (SELECT id FROM sale ORDER BY id DESC LIMIT 1);
SELECT * FROM payment           WHERE sale_id =  (SELECT id FROM sale ORDER BY id DESC LIMIT 1);

-- =============================================================================
-- SAVEPOINT
-- =============================================================================

-- =============================================================================
-- Example 5 (SAVEPOINT): Undo only part of a transaction
-- =============================================================================
-- Give a bonus to three customers, but undo the bonus of customer 3.

BEGIN;

    UPDATE customer
    SET loyalty_points = loyalty_points + 100
    WHERE id = 1;

    UPDATE customer
    SET loyalty_points = loyalty_points + 100
    WHERE id = 2;

    SAVEPOINT before_third_customer;

    UPDATE customer
    SET loyalty_points = loyalty_points + 100
    WHERE id = 3;

    ROLLBACK TO SAVEPOINT before_third_customer;

COMMIT;

SELECT id, loyalty_points
FROM customer 
WHERE id IN (1,2,3);

4 = 3399
5 = 5431
6 = 2186

-- =============================================================================
-- Example 6 (SAVEPOINT): Several save points, return to the first one
-- =============================================================================
-- Change a product's price twice, but keep only first change.
-- Second save point us discarded when we roll back to the first.

BEGIN;

    UPDATE product
    SET unit_price = 200.00
    WHERE id = 1;

    SAVEPOINT price_v1;

    UPDATE product
    SET unit_price = 300.00
    WHERE id = 1;

    SAVEPOINT price_v2;

    UPDATE product
    SET unit_price = 400.00
    WHERE id = 1;

    ROLLBACK TO SAVEPOINT price_v1;

COMMIT;

SELECT id, sku, unit_price
FROM product
WHERE id = 1;