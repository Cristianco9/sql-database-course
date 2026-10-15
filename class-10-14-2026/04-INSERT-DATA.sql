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

-- =============================================================================
-- Product
-- =============================================================================

-- Product
INSERT INTO product (
    sku,
    name,
    description,
    details,
    supplier_id,
    unit_price
)
VALUES
    (
        'ADI-FTW-001',
        'Ultraboost Light',
        'Running shoes with Light BOOST midsole for daily training',
        '{"color": "Core Black", "material": "Primeknit", "weight": "234"}',
        1,
        149.99
    ),
    (
        'ADI-LST-002',
        'Essentials Hoodie',
        'Cotton-blend hoodie with kangaroo pocket for everyday wear',
        '{"color": "Grey Heather", "material": "Cotton/Polyester"}',
        1,
        89.99
    ),
    (
        'ADI-FTW-003',
        'Samba OG',
        'Classic low-profile sneakers with leather upper and gum sole',
        '{"color": "White/Black", "material": "Leather"}',
        1,
        119.99
    );

SELECT * FROM product;

-- Product category
INSERT INTO product_category (
    product_id,
    category_id
)
VALUES
    (1, 1),
    (2, 2);  

SELECT * FROM product_category;

-- =============================================================================
-- Inventory
-- =============================================================================

-- Inventory 
INSERT INTO inventory (
    store
)
VALUES
    (1),
    (2);

SELECT * FROM inventory;

-- Inventory stock
INSERT INTO inventory_stock (
    inventory,
    product,
    quantity_available,
    minimum_stock
)
VALUES
    (1, 1, 25, 5),
    (2, 2, 40, 10);

SELECT * FROM inventory_stock;

-- Inventory transfer
INSERT INTO inventory_transfer (
    type,
    origin_inventory,
    destination_inventory,
    employee_id
)
VALUES
    (1, 2, 1, 1),
    (2, 1, 2, 1);

SELECT * FROM inventory_transfer;

-- Inventory transfer detail
INSERT INTO inventory_transfer_detail (
    inventory_transfer_id,
    product,
    movement_quantity
)
VALUES
    (1, 1, 10),
    (1, 3, 5),
    (2, 2, 8);

SELECT * FROM inventory_transfer_detail;

-- =============================================================================
-- Sale
-- =============================================================================

-- Sale
INSERT INTO sale (
    date,
    customer,
    employee,
    store
)
VALUES
    ('2026-10-10 14:30:00', 1, 1, 1),
    ('2026-10-12 11:15:00', 1, 1, 1);

SELECT * FROM sale;

-- Sale detail
INSERT INTO sale_detail (
    sale_detail,
    product_id,
    quantity,
    discount
)
VALUES
    (1, 1, 1, 0.00),
    (1, 3, 2, 10.00),
    (2, 2, 3, 0.00);

SELECT * FROM sale_detail;

-- =============================================================================
-- Payment
-- =============================================================================

-- Payment (total = subtotal - discount + 19% tax on the discounted amount)
INSERT INTO payment (
    sale_id,
    status,
    method,
    discount,
    tax,
    subtotal,
    total
)
VALUES
    (1, 4, 1, 10.00, 72.19, 389.97, 452.16),
    (2, 4, 3,  0.00, 51.29, 269.97, 321.26);

SELECT * FROM payment;