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

-- Table role

-- Table document type

-- Table payment method

-- Table payment status

-- Table type inventory transfer

-- Table category

-- Table phone