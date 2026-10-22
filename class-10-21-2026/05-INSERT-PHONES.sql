-- =============================================================================
-- Retail Sales and Inventory Management System
-- INSERT phone numbers and associate them with their owner
-- =============================================================================

-- =============================================================================
-- New User -> Customer -> 2 Phones -> associate with the user
-- =============================================================================

-- User
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
    '10987654321',
    2,
    2,
    'Diana',
    'Maria',
    'Prince',
    'Lopez',
    'diana.prince@example.com',
    'Calle 100 # 15-20',
    'New retail customer'
);

SELECT * FROM "user";   -- user id (3)

-- Customer (will get id 2, points to user 3)
INSERT INTO customer (
    user_data,
    loyalty_points
)
VALUES (
    3,
    250
);

SELECT * FROM customer;

-- Phones for the user (will get ids 9 and 10)
INSERT INTO phone (
    number
)
VALUES
    ('+57 300 111 2233'),
    ('+57 300 111 2234');
    
SELECT * FROM phone;

-- Associate phones 9 and 10 with user 3
INSERT INTO user_phone (
    user_id,
    phone_id
)
VALUES
    (3, 9),
    (3, 10);

SELECT * FROM user_phone;

-- =============================================================================
-- New Supplier -> 2 Phones -> associate with the supplier
-- =============================================================================

-- Supplier (will get id 2)
INSERT INTO supplier (
    name,
    nit,
    email,
    address,
    city
)
VALUES (
    'Nike Colombia S.A.S',
    '900.987.654-3',
    'contact@nike.com.co',
    'Carrera 45 # 26-15',
    1
);

SELECT * FROM supplier;

-- Phones for the supplier (will get ids 11 and 12)
INSERT INTO phone (
    number
)
VALUES
    ('+57 601 555 0101'),
    ('+57 601 555 0102');

SELECT * FROM phone;

-- Associate phones 11 and 12 with supplier 2
INSERT INTO supplier_phone (
    supplier_id,
    phone_id
)
VALUES
    (2, 11),
    (2, 12);

SELECT * FROM supplier_phone;

-- =============================================================================
-- New Store -> 2 Phones -> associate with the store
-- =============================================================================

-- Store (will get id 3)
INSERT INTO store (
    store_number,
    name,
    email,
    address,
    city
)
VALUES (
    'AD-099',
    'Adidas Store Barranquilla Norte',
    'barranquilla.norte.store@adidas.com.co',
    'Calle 84 # 45-12',
    1
);

SELECT * FROM store;

-- Phones for the store (will get ids 13 and 14)
INSERT INTO phone (
    number
)
VALUES
    ('+57 605 555 0201'),
    ('+57 605 555 0202');

SELECT * FROM phone;

-- Associate phones 13 and 14 with store 3
INSERT INTO store_phone (
    store_id,
    phone_id
)
VALUES
    (3, 13),
    (3, 14);

SELECT * FROM store_phone;