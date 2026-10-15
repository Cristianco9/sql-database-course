-- =============================================================================
-- Retail Sales and Inventory Management System
-- Indexes module
-- =============================================================================
-- PostgreSQL automatically creates an index for every PRIMARY KEY and UNIQUE
-- constraint, so those columns are NOT indexed again here. Foreign keys are not
-- indexed automatically, so every foreign key that is not already covered by a
-- UNIQUE constraint gets its own index below.

-- =============================================================================
-- Foreign keys indexes
-- =============================================================================

-- Geography
CREATE INDEX IF NOT EXISTS idx_department_country   ON department (country);
CREATE INDEX IF NOT EXISTS idx_city_department      ON city (department);

-- Suppliers and Stores
CREATE INDEX IF NOT EXISTS idx_supplier_city        ON supplier (city);
CREATE INDEX IF NOT EXISTS idx_store_city           ON store (city);

-- Users, Customers, and Employees
-- customer.user_data and employee.user_data are UNIQUE, so they are already indexed
CREATE INDEX IF NOT EXISTS idx_user_document_type   ON "user" (document_type);
CREATE INDEX IF NOT EXISTS idx_user_user_type       ON "user" (user_type);
CREATE INDEX IF NOT EXISTS idx_employee_role        ON employee (role);
CREATE INDEX IF NOT EXISTS idx_employee_store       ON employee (store);

-- Phones
-- phone_id is UNIQUE in the three association tables, so only the owner needs an index
CREATE INDEX IF NOT EXISTS idx_user_phone_user          ON user_phone (user_id);
CREATE INDEX IF NOT EXISTS idx_supplier_phone_supplier  ON supplier_phone (supplier_id);
CREATE INDEX IF NOT EXISTS idx_store_phone_store        ON store_phone (store_id);

-- Product
-- product_category UNIQUE (product_id, category_id) already covers searches by product
CREATE INDEX IF NOT EXISTS idx_product_supplier          ON product (supplier_id);
CREATE INDEX IF NOT EXISTS idx_product_category_category ON product_category (category_id);

-- Inventory
-- inventory.store is UNIQUE
-- inventory_stock UNIQUE (inventory, product) already covers searches by inventory
-- inventory_transfer_detail UNIQUE (inventory_transfer_id, product) already covers searches by transfer
CREATE INDEX IF NOT EXISTS idx_inventory_stock_product
    ON inventory_stock (product);
CREATE INDEX IF NOT EXISTS idx_inventory_transfer_type
    ON inventory_transfer (type);
CREATE INDEX IF NOT EXISTS idx_inventory_transfer_origin
    ON inventory_transfer (origin_inventory);
CREATE INDEX IF NOT EXISTS idx_inventory_transfer_destination
    ON inventory_transfer (destination_inventory);
CREATE INDEX IF NOT EXISTS idx_inventory_transfer_employee
    ON inventory_transfer (employee_id);
CREATE INDEX IF NOT EXISTS idx_inventory_transfer_detail_product
    ON inventory_transfer_detail (product);

-- Sales and Payments
-- sale_detail UNIQUE (sale_detail, product_id) already covers searches by sale
CREATE INDEX IF NOT EXISTS idx_sale_customer        ON sale (customer);
CREATE INDEX IF NOT EXISTS idx_sale_employee        ON sale (employee);
CREATE INDEX IF NOT EXISTS idx_sale_store           ON sale (store);
CREATE INDEX IF NOT EXISTS idx_sale_detail_product  ON sale_detail (product_id);
CREATE INDEX IF NOT EXISTS idx_payment_sale         ON payment (sale_id);
CREATE INDEX IF NOT EXISTS idx_payment_status       ON payment (status);
CREATE INDEX IF NOT EXISTS idx_payment_method       ON payment (method);

-- =============================================================================
-- Query-driven indexes
-- =============================================================================

-- Sale reports by date range, and by store within date range
CREATE INDEX IF NOT EXISTS idx_sale_date            ON sale (date);
CREATE INDEX IF NOT EXISTS idx_sale_store_date      ON sale (store, date);

-- "Which products are running low on inventory?"
CREATE INDEX IF NOT EXISTS idx_inventory_stock_low
    ON inventory_stock (inventory, product)
    WHERE quantity_available <= minimum_stock;

-- Searching people by name
CREATE INDEX IF NOT EXISTS idx_user_lastname_name
    ON "user" (first_lastname, first_name);

-- Searching products by name
CREATE INDEX IF NOT EXISTS idx_product_name         ON product (name);