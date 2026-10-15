-- =============================================================================
-- Retails Sales and Inventory Management System
-- INSERT statements
-- =============================================================================

-- =============================================================================
-- Geography
-- =============================================================================

-- Country
INSERT INTO country (
    name, 
    iso2_code
)
VALUES (
    'Colombia', 
    'CO'
);

SELECT * FROM country;

-- Department
INSERT INTO department (
    name,
    country
)
VALUES 
    ('Amazonas', 1),
    ('Antioquia', 1),
    ('Arauca', 1),
    ('Atlántico', 1),
    ('Bolívar', 1);

SELECT * FROM department;

-- City
INSERT INTO city (
    name,
    department
)
VALUES
    ('Barranquilla', 4),
    ('Cartagena', 4);

SELECT * FROM city;

-- =============================================================================
-- Catalog
-- =============================================================================

-- User type
INSERT INTO user_type (
    type,
    description
)
VALUES 
    (
        'Employee',
        'Store employees'
    ),
    (
        'Customer',
        'Store customer'
    );

SELECT * FROM user_type;

-- User role
INSERT INTO role (
    name,
    description
)
VALUES (
    'Salesperson',
    'Store employees who support customers '
);

SELECT * FROM role;

-- Document type
INSERT INTO document_type (
    name
)
VALUES
    ('Passport'),
    ('Citizenship ID');

SELECT * FROM document_type;

-- Payment method
INSERT INTO payment_method (
    name
)
VALUES
    ('Credit Card'),
    ('Debit Card'),
    ('Cash');


SELECT * FROM payment_method;

-- Payment status
INSERT INTO payment_status (
    name
)
VALUES
    ('Declined'),
    ('Cancelled'),
    ('Pending'),
    ('Paid');

SELECT * FROM payment_status;


-- Inventory transfer type
INSERT INTO type_inventory_transfer (
    name
)
VALUES 
    ('Inbound'),
    ('Outbound');

SELECT * FROM type_inventory_transfer;

-- Category
INSERT INTO category (
    name
)
VALUES 
    ('Footwear'),
    ('Life style');

SELECT * FROM category;

-- Phone
INSERT INTO phone (
    number
)

VALUES 
    ('319-907-4521'),
    ('+57 321 546 4321'),
    ('3145435687'),
    ('6024567843'),
    ('602 231 4322');

SELECT * FROM phone;

-- =============================================================================
-- Suppliers and Stores
-- =============================================================================

-- Supplier
INSERT INTO supplier (
    name,
    nit,
    email,
    address,
    city
)
VALUES (
    'Adidas Colombia S.A.S',
    '900.123.456-7',
    'contact@adidas.com.co',
    'Street 34 # 34 - 125',
    2
);

SELECT * FROM supplier;

-- Store
INSERT INTO store (
    store_number,
    name,
    email,
    address,
    city
)
VALUES 
    (
        'AD-032',
        'Adidas Store Cartagena',
        'cartagena.store@adidas.com.co',
        'Avenue 43A - 42 -67',
        2
    ),
    (
        'AD-026',
        'Adidas Store Barranquilla',
        'barranquilla.store@adidas.com.co',
        'Street 32 - 53 -17',
        1
    );


SELECT * FROM store;

-- =============================================================================
-- Users, Customers, and Employee
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
VALUES 
(
    '10314567843',
    2,
    1,
    'Michael',
    'Stuart',
    'Jackson',
    '',
    'michael.jackson@adidas.com.co',
    'Avenue 34 # 12 -90',
    'Sales employee'
),
(
    '102334432435',
    1,
    2,
    'Bruce',
    '',
    'Wayne',
    '',
    'bruce.wayne@wayneindustries.com',
    'Baticave',
    'Super customer'
);

SELECT * FROM "user";

-- Customer
INSERT INTO customer (
    user_data,
    loyalty_points
)
VALUES (
    2,
    1000
);

SELECT * FROM customer;

-- Employee
INSERT INTO employee (
    user_data,
    number,
    role,
    store
)
VALUES (
    1,
    'EP-00032',
    1,
    1
);

SELECT * FROM employee;