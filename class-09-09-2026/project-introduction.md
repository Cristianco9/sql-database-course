# Project: Retail Sales and Inventory Management System

## Project Introduction

In this project, you will work as a database designer for a retail
company that wants to replace its spreadsheet-based sales and inventory
management system with a relational database management system.

The company currently uses spreadsheets to manage customers, products,
suppliers, employees, sales, and inventory. Each store maintains its own
records, which has resulted in duplicated information, inconsistent
product data, and difficulties when generating sales and inventory
reports.

The company has hired your software development team to analyze the
current business process and design a relational database capable of
supporting its sales and inventory operations.

Before implementing the database, you must analyze the information,
identify entities and relationships, and progressively improve the
design through database normalization.

Throughout this project, we will move from **First Normal Form (1NF)**,
to **Second Normal Form (2NF)**, and finally to **Third Normal Form
(3NF)** before implementing the final database in PostgreSQL.

---

# Business Scenario

The company operates several retail stores.

Each store sells different products to customers. Products belong to
categories and are supplied by one or more suppliers.

Customers can make multiple purchases, and each sale can contain
multiple products.

Employees are responsible for processing sales at each store.

The company also needs to know how many units of each product are
available at each store.

Currently, sales are recorded using spreadsheets where information
about the customer, employee, store, products, and prices is repeatedly
stored in the same records.

For example, a single sale containing five products may repeat the
customer information, employee information, store information, and
product category information five times.

This has created several problems:

* Duplicate customer information.
* Duplicate product information.
* Inconsistent product prices.
* Repeated store information.
* Difficulty updating product categories.
* Difficulty tracking inventory.
* Problems generating accurate reports.

The company wants a centralized relational database that eliminates
unnecessary duplication and maintains data integrity.

---

# Business Requirements

The system should manage information about:

* Customers
* Employees
* Stores
* Products
* Product categories
* Suppliers
* Sales
* Sale details
* Inventory
* Payments

The company would like to answer questions such as:

* Which products were included in a sale?
* Which customer made a particular purchase?
* Which employee processed a sale?
* Which store processed the sale?
* What products belong to each category?
* Which suppliers provide each product?
* How many units of a product are available at each store?
* What is the total value of a sale?
* What payment method was used?
* Which products are running low on inventory?

---

# Customer Information

For every customer, the company records:

* Customer identification number
* First name
* Last name
* Email address
* Phone number
* Address

A customer can make multiple purchases.

---

# Employee Information

For every employee, the company records:

* Employee identification number
* First name
* Last name
* Email address
* Phone number
* Job position
* Store where the employee works

Possible job positions include:

* Sales Assistant
* Cashier
* Supervisor
* Store Manager

An employee belongs to one store.

A store can have multiple employees.

---

# Store Information

For every store, the company records:

* Store identification number
* Store name
* Address
* City
* Phone number

A store can process many sales.

A store can employ multiple employees.

A store can maintain inventory for many products.

---

# Product Information

For every product, the company records:

* Product identification number
* Product name
* Description
* Unit price
* Category
* Supplier
* SKU
* Minimum stock level

Each product belongs to a product category.

A category can contain multiple products.

---

# Category Information

Products are organized into categories.

Examples include:

* Electronics
* Computers
* Accessories
* Home Appliances
* Office Supplies
* Clothing

For every category, the company records:

* Category identification number
* Category name
* Description

---

# Supplier Information

The company purchases products from different suppliers.

For every supplier, the company records:

* Supplier identification number
* Company name
* Contact name
* Email address
* Phone number
* Address

A supplier can provide multiple products.

A product may also be provided by multiple suppliers.

This relationship must be analyzed carefully during the database design
process.

---

# Sale Information

Whenever a customer makes a purchase, the company creates a sale.

For every sale, the company records:

* Sale identification number
* Sale date
* Customer
* Employee
* Store
* Products purchased
* Quantity of each product
* Unit price at the time of sale
* Payment method
* Payment status

A customer can make many sales.

An employee can process many sales.

A store can process many sales.

A sale can contain multiple products.

A product can appear in many different sales.

---

# Sale Detail Information

Each sale can contain multiple products.

For each product included in a sale, the company needs to know:

* Product
* Quantity
* Unit price
* Discount

The system must be able to calculate the subtotal for each product in
the sale.

For example:

A customer purchases:

* 2 keyboards
* 1 monitor
* 3 USB cables

The sale must store each product as a separate sale detail.

The database design should avoid storing multiple products in a single
field.

---

# Payment Information

Each sale must contain payment information.

The company records:

* Payment method
* Payment status
* Payment date
* Amount paid

Possible payment methods include:

* Cash
* Credit Card
* Debit Card
* Bank Transfer

Possible payment statuses include:

* Pending
* Paid
* Refunded

---

# Inventory Information

Each store maintains its own inventory.

For every product available at a store, the company needs to know:

* Store
* Product
* Quantity available
* Minimum stock level
* Last inventory update

The same product can exist in multiple stores.

For example:

A laptop may have:

* 15 units in Store A
* 8 units in Store B
* 20 units in Store C

The database must represent this relationship correctly.

---

# Important Business Rules

The following business rules must be considered during the database
design:

1. A customer can make multiple sales.

2. Each sale belongs to one customer.

3. An employee can process multiple sales.

4. Each sale is processed by one employee.

5. Each employee works at one store.

6. A store can employ multiple employees.

7. A sale is processed at one store.

8. A sale can contain multiple products.

9. A product can appear in multiple sales.

10. The relationship between sales and products must therefore be
    analyzed carefully.

11. The quantity of a product belongs to a specific sale detail.

12. The price recorded in a sale detail represents the price at the
    moment of purchase.

13. A product belongs to one category.

14. A category can contain multiple products.

15. A product can be supplied by multiple suppliers.

16. A supplier can provide multiple products.

17. A store can have many products in inventory.

18. A product can exist in the inventory of multiple stores.

---

# Initial Data Example

Before normalization, imagine that the company stores sales in a
spreadsheet similar to the following:

| Sale ID | Customer   | Store   | Employee    | Products               |
| ------- | ---------- | ------- | ----------- | ---------------------- |
| 1001    | John Smith | Store A | Maria Lopez | Keyboard x2, Mouse x1  |
| 1002    | Ana Brown  | Store B | Carlos Diaz | Monitor x1             |
| 1003    | John Smith | Store A | Maria Lopez | USB Cable x3, Mouse x2 |

The spreadsheet also contains product information such as category,
supplier, price, and inventory information.

The problem is that the same information appears repeatedly.

For example, if John Smith makes ten purchases, his information may be
stored ten times.

Similarly, Store A and Maria Lopez may be repeated in every sale
processed by that employee.

Your task is to determine how this information should be organized.

---

# Your Task

Before writing SQL code, analyze the business requirements and design
the database progressively.

The objective is not to immediately create the final database.

Instead, you must demonstrate how an unorganized dataset can be
transformed into a properly normalized relational database.

You will progressively apply:

* First Normal Form (1NF)
* Second Normal Form (2NF)
* Third Normal Form (3NF)

At every stage, explain what problem is being solved and why the new
design is better.

---

# Phase 1: Identify the Data

Begin by identifying all the information that the company needs to
store.

Answer the following questions:

1. What information does the company need?

2. Which information describes customers?

3. Which information describes employees?

4. Which information describes stores?

5. Which information describes products?

6. Which information describes categories?

7. Which information describes suppliers?

8. Which information describes sales?

9. Which information describes inventory?

10. Which information describes payments?

---

# Phase 2: Identify Entities

Identify the main entities in the system.

For each entity, determine:

* Entity name
* Purpose
* Attributes
* Candidate keys
* Primary key

Consider whether the following should become entities:

* Customer
* Employee
* Store
* Product
* Category
* Supplier
* Sale
* Sale Detail
* Inventory
* Payment

Do not assume that every item must immediately become a table.

Analyze the requirements first.

---

# Phase 3: Identify Relationships

Analyze how the entities are connected.

Determine relationships such as:

* Customer to Sale
* Employee to Sale
* Store to Employee
* Store to Sale
* Sale to Product
* Product to Category
* Product to Supplier
* Store to Product

For every relationship, determine its cardinality.

For example:

* One customer can have many sales.
* One sale belongs to one customer.

Represent the relationships using appropriate cardinalities:

* 1:1
* 1:N
* N:M

---

# Phase 4: First Normal Form (1NF)

Start with the original unnormalized information.

Identify problems such as:

* Multiple products stored in one field.
* Multiple quantities stored in one field.
* Repeated groups of attributes.
* Non-atomic values.
* Repeated customer information.
* Repeated store information.

Transform the data so that:

* Every attribute contains atomic values.
* There are no repeating groups.
* Each row represents a single record.
* Each column represents one type of information.

Document your proposed 1NF structure.

---

# Phase 5: Second Normal Form (2NF)

After achieving 1NF, analyze the dependencies between attributes and
keys.

Identify tables where a composite primary key may exist.

For example, a sale detail may be identified by:

* Sale ID
* Product ID

Together, these attributes identify one product within one sale.

Analyze whether other attributes depend on:

* The complete composite key.
* Only part of the composite key.

Identify partial dependencies.

Then decompose the database to eliminate those dependencies.

Document:

* The original relation.
* The composite key.
* The partial dependencies.
* The decomposed relations.
* The new primary keys.
* The new foreign keys.

---

# Phase 6: Third Normal Form (3NF)

After achieving 2NF, analyze the remaining dependencies.

Look for attributes that depend on other non-key attributes.

For example, consider whether information about:

* Customer
* Store
* Employee
* Category
* Supplier

is being stored unnecessarily inside another relation.

Identify transitive dependencies.

Then decompose the relations to ensure that:

* Every non-key attribute depends on the key.
* No non-key attribute depends on another non-key attribute.

Document the changes made to reach 3NF.

---

# Normalization Analysis

For every normalization stage, answer:

## 1NF

* What repeating groups existed?
* Which attributes were not atomic?
* How were the repeating groups removed?
* What is the primary key?

## 2NF

* Which relations have composite keys?
* What partial dependencies exist?
* Which attributes depend only on part of a composite key?
* How were those dependencies removed?

## 3NF

* Which transitive dependencies exist?
* Which attributes depend on non-key attributes?
* Which relations must be separated?
* How does the final design eliminate those dependencies?

---

# Functional Dependency Analysis

For the final design, identify important functional dependencies.

Examples of the type of analysis expected include:

```text
customer_id -> first_name, last_name, email, phone
```

```text
product_id -> product_name, unit_price, category_id
```

```text
category_id -> category_name, description
```

```text
store_id -> store_name, address, city, phone
```

```text
employee_id -> first_name, last_name, email, store_id
```

Students must determine the complete set of functional dependencies
based on the business requirements.

---

# Primary Keys and Foreign Keys

For every final relation, identify:

* Primary key
* Foreign keys
* Candidate keys where appropriate
* Attributes that must be unique

Explain why each primary key uniquely identifies a record.

Explain what each foreign key represents.

---

# Composite Keys

The project must include at least one relationship where a composite
key is appropriate.

A strong candidate is the relationship between:

* Sale
* Product

Students should analyze the relationship and determine whether a sale
detail can be uniquely identified using:

```text
sale_id + product_id
```

The purpose is to give students a practical situation where partial
dependencies can be identified during 2NF.

---

# Many-to-Many Relationships

The project contains important many-to-many relationships.

Students must identify and resolve them.

For example:

```text
Sale N:M Product
```

and:

```text
Product N:M Supplier
```

Students must determine what associative entities are required to
represent these relationships in a relational database.

---

# Inventory Modeling

Inventory requires special attention.

A product does not have a single inventory quantity because the same
product can exist in multiple stores.

Analyze the relationship:

```text
Store N:M Product
```

Determine which attributes belong to the relationship itself.

For example:

* Quantity available
* Last inventory update

These attributes describe the relationship between a store and a
product rather than the product itself.

---

# Entity-Relationship Diagram

After completing the normalization analysis, create an Entity-
Relationship Diagram.

The ERD should show:

* Entities
* Attributes
* Primary keys
* Relationships
* Cardinalities

The diagram should clearly represent the business rules.

---

# Relational Diagram

Transform the final ERD into a relational database model.

The relational diagram must show:

* Tables
* Primary keys
* Foreign keys
* Relationships
* Cardinalities

The final design must be ready to be implemented using PostgreSQL.

---

# Questions for Analysis

Work with your classmates to answer the following questions.

1. What information is duplicated in the original system?

2. What problems can duplicated information cause?

3. Which attributes contain non-atomic values?

4. What repeating groups exist?

5. How can the original data be transformed into 1NF?

6. Which relations contain composite keys?

7. What partial dependencies exist?

8. How can the database be transformed into 2NF?

9. What transitive dependencies exist?

10. How can the database be transformed into 3NF?

11. Which relationships are one-to-many?

12. Which relationships are many-to-many?

13. Which relationships require associative entities?

14. Which attributes belong to relationships rather than entities?

15. Which attributes should be foreign keys?

16. Which attributes should have unique constraints?

17. Why should the product category be separated from the product?

18. Why should suppliers be separated from products?

19. Why should inventory be modeled separately from products?

20. Why is the final 3NF design better than the original spreadsheet?

---

# Class Activity

As a class, we will:

* Analyze the business requirements.
* Identify entities.
* Identify attributes.
* Identify candidate keys.
* Identify primary keys.
* Identify relationships.
* Determine relationship cardinalities.
* Analyze functional dependencies.
* Create the initial unnormalized structure.
* Transform the structure into 1NF.
* Identify partial dependencies.
* Transform the structure into 2NF.
* Identify transitive dependencies.
* Transform the structure into 3NF.
* Create the final ERD.
* Create the final relational diagram.
* Validate the final database design.

---

# Expected Deliverables

By the end of the project, every student should submit:

* Business requirements analysis.
* Entity identification.
* Attribute identification.
* Candidate key analysis.
* Functional dependency analysis.
* Initial unnormalized structure.
* First Normal Form (1NF).
* Second Normal Form (2NF).
* Third Normal Form (3NF).
* Primary key identification.
* Foreign key identification.
* Relationship and cardinality analysis.
* Entity-Relationship Diagram (ERD).
* Relational Diagram.

The final relational model must be ready for implementation in
PostgreSQL.

---

# Learning Objectives

By completing this project, you will learn how to:

* Analyze real-world business requirements.
* Identify entities and attributes.
* Identify candidate and primary keys.
* Identify foreign keys.
* Analyze functional dependencies.
* Identify partial dependencies.
* Identify transitive dependencies.
* Apply First Normal Form.
* Apply Second Normal Form.
* Apply Third Normal Form.
* Resolve many-to-many relationships.
* Model associative entities.
* Understand composite primary keys.
* Design normalized relational databases.
* Create Entity-Relationship Diagrams.
* Create Relational Diagrams.
* Prepare a database model for PostgreSQL implementation.

---

# Final Challenge

After completing the 3NF design, review the original spreadsheet
structure and compare it with the final relational model.

Discuss:

1. Which duplicated information was eliminated?

2. Which update anomalies were eliminated?

3. Which insertion anomalies were eliminated?

4. Which deletion anomalies were eliminated?

5. Which relationships required new tables?

6. Which attributes moved to different tables?

7. How does the 3NF model improve data integrity?

8. Why is the final model easier to maintain?

9. Why is the final model better suited for SQL queries?

10. Would you make any additional changes before implementing the
    database in PostgreSQL?

The objective is not only to produce a final diagram, but to understand
**why each transformation was necessary** and how normalization
improves the quality of a relational database design.
