-- =============================================================================
-- Retails Sales and Inventory Management System
-- =============================================================================

DROP TABLE IF EXISTS
    payment, 
    sale_detail, sale,
    inventory_transfer_detail, inventory_transfer, inventory_stock, inventory,
    product_category, product,
    store_phone, supplier_phone, user_phone,
    employee, customer, user,
    store, supplier,
    phone, category, type_inventory_transfer, payment_status, payment_method,
    document_type, role, user_type,
    city, department, country
CASCADE;



-- =============================================================================
-- Geography
-- =============================================================================

-- Table country
CREATE TABLE country (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    iso2_code                   VARCHAR(2) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table Department
CREATE TABLE department (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    country                     INT NOT NULL REFERENCES country (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table City
CREATE TABLE city (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    department                  INT NOT NULL REFERENCES department (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Catalog
-- =============================================================================

-- Table user type
CREATE TABLE user_type (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type                        VARCHAR(30)  NOT NULL UNIQUE,
    description                 VARCHAR(200) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table role
CREATE TABLE role (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(30)  NOT NULL UNIQUE,
    description                 VARCHAR(200) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table document type
CREATE TABLE document_type (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table payment method
CREATE TABLE payment_method (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table payment status
CREATE TABLE payment_status (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table type inventory transfer
CREATE TABLE type_inventory_transfer (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table category
CREATE TABLE category (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table phone
CREATE TABLE phone (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    number                      VARCHAR(20) NOT NULL UNIQUE,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================================================
-- Suppliers and Stores
-- =============================================================================

-- Table supplier
CREATE TABLE supplier (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name                        VARCHAR(50) NO NULL,
    nit                         VARCHAR(30) NO NULL UNIQUE,
    email                       VARCHAR(100) NO NULL UNIQUE,
    address                     VARCHAR(100) NOT NULL,
    city                        INT NOT NULL REFERENCES city (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP     
)

-- Table store
CREATE TABLE store (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;
    store_number                VARCHAR(20) NOT NULL UNIQUE,
    name                        VARCHAR(100) NOT NULL,
    email                       VARCHAR(100) NOT NULL UNIQUE,      
    address                     VARCHAR(100) NOT NULL,
    city                        INT NOT NULL REFERENCES city (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP           
)

-- =============================================================================
-- Users, Customers, and Employee
-- =============================================================================

-- Table user
CREATE TABLE user (
    id                           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    document_number              VARCHAR(20) NOT NULL UNIQUE,
    document_type                INT NOT NULL REFERENCES document_type (id),
    user_type                    INT NOT NULL REFERENCES user_type (id),
    first_name                   VARCHAR(50) NOT NULL,
    middle_name                  VARCHAR(50),
    first_lastname               VARCHAR(50) NOT NULL,
    second_lastname              VARCHAR(50),
    email                        VARCHAR(100) NOT NULL UNIQUE,
    address                      VARCHAR(100) NOT NULL,
    description                  VARCHAR(200) NOT NULL UNIQUE,
    created_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP     
)

-- Table customer
CREATE TABLE customer (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_data                   INT NOT NULL REFERENCES user (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP   
) 

-- Table employee
CREATE TABLE employee (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_data                   INT NOT NULL REFERENCES user (id),
    number                      VARCHAR(10) NOT NULL UNIQUE,    
    role                        INT NOT NULL REFERENCES role (id),
    store                       INT NOT NULL REFERENCES store (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP       
)

-- ============================================================================
-- Phones (association)
-- =============================================================================

-- Table user_phone
CREATE TABLE user_phone(
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id                     INT NOT NULL UNIQUE REFERENCES user (id),
    phone_id                    INT NOT NULL UNIQUE REFERENCES phone(id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

-- Table supplier_phone
CREATE TABLE supplier_phone(
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    supplier_id                  INT NOT NULL UNIQUE REFERENCES supplier (id),
    phone_id                    INT NOT NULL UNIQUE REFERENCES phone (id),  
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

-- Table store_phone
CREATE TABLE store_phone(
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    store_id                    INT NOT NULL UNIQUE REFERENCES store (id),
    phone_id                    INT NOT NULL UNIQUE REFERENCES phone (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP    
)

-- =============================================================================
-- Product
-- =============================================================================

-- Table product
CREATE TABLE product (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sku                         VARCHAR(20) NOT NULL UNIQUE,
    name                        VARCHAR(50) NO NULL,
    description                 TEXT NOT NULL,
    details                     JSON NOT NULL,
    supplier_id                  INT NOT NULL REFERENCES supplier (id),
    unit_price                  NUMERIC(10,2) CHECK (unit_price > 0),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

-- Table Product_category
CREATE TABLE product_category (
    id                          INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id                  INT NOT NULL UNIQUE REFERENCES product (id),
    category_id                 INT NOT NULL UNIQUE REFERENCES category (id),
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

-- ============================================================================
-- Inventory
-- =============================================================================

-- Table inventory
CREATE TABLE inventory (
    id                           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    store                        INT NOT NULL UNIQUE REFERENCES store (id),
    created_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

-- Table inventory_stock
CREATE TABLE inventory_stock(
    id                             INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    inventory                      INT NOT NULL UNIQUE REFERENCES inventory (id),
    product                        INT NOT NULL REFERENCES product (id),
    quantity_available             INT NOT NULL,
    minimum_stock                  INT NOT NULL,
    created_at                     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                     TIMESTAMP DEFAULT CURRENT_TIMESTAMP             
)

-- Table inventory_transfer
CREATE TABLE inventory_transfer(
    id                            INT GENERATED ALWAYSAS IDENTITY PRIMARY KEY,
    type                          INT NOT NULL REFERENCES type_inventory_transfer (id),
    origin_inventory              INT NOT NULL REFERENCES inventory (id),
    destination_inventory         INT NOT NULL REFERENCES inventory (id),
    employee_id                   INT NOT NULL REFERENCES employee (id),
    created_at                    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                    TIMESTAMP DEFAULT CURRENT_TIMESTAMP   
)

-- Table inventory_transfer_detail
CREATE TABLE inventory_transfer_detail(
    id                             INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    inventory_transfer_id          INT NOT NULL REFERENCES inventory_transfer (id),
    product                        INT NOT NULL REFERENCES product (id),
    movement_quantity              INT NOT NULL,              
    created_at                     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                     TIMESTAMP DEFAULT CURRENT_TIMESTAMP  
)

-- =============================================================================
-- Sale
-- =============================================================================

-- Table sale
CREATE TABLE sale (
    id                           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date                         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    customer                     INT NOT NULL REFERENCES customer (id),
    employee                     INT NOT NULL REFERENCES employee (id),
    store                        INT NOT NULL REFERENCES store (id),
    created_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP   
)

-- Table sale_detail
CREATE TABLE sale_detail(
    id                           INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sale_detail                  INT NOT NULL REFERENCES sale (id),
    product_id                   INT NOT NULL REFERENCES product (id),
    quantity                     INT NOT NULL,
    discount                     NUMERIC(10,2) NOT NULL,
    created_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

-- ============================================================================
-- Payment
-- =============================================================================

-- Table payment
CREATE TABLE payment(
    id                              INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sale_id                         INT NOT NULL REFERENCES sale (id),
    status                          INT NOT NULL REFERENCES payment_status (id),
    method                          INT NOT NULL REFERENCES payment_method (id),
    discount                        NUMERIC(10,2) NOT NULL CHECK (discount >= 0),
    tax                             NUMERIC(10,2) NOT NULL CHECK (tax >= 0),
    subtotal                        NUMERIC(10,2) NOT NULL CHECK (subtotal >= 0),
    total                           NUMERIC(10,2) NOT NULL CHECK (total >= 0),
    created_at                     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at                     TIMESTAMP DEFAULT CURRENT_TIMESTAMP         
)