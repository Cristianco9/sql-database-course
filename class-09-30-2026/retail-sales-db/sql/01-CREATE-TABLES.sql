-- =============================================================================
-- Retails Sales and Inventory Management System
-- =============================================================================

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