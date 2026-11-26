# SQL Database Course

Activities, exercises, projects, and learning resources for the **SQL Database**
course. Every class has its own folder, and together they follow a single running
project: designing, building, and querying a **Retail Sales and Inventory Management System**
in **PostgreSQL**.

The course goes from the theory of relational databases and normalization
(1NF, 2NF, 3NF), through implementing the schema with Docker and PostgreSQL,
to loading data, altering tables, writing SQL queries, and modifying data
with `UPDATE`, `DELETE`, and `TRUNCATE`. It also covers transaction control
with **TCL** and querying data with filtering, sorting, distinct results,
subqueries, and aggregate functions, followed by intermediate queries with joins,
grouping, `HAVING`, `CASE`, date functions, and JSON data.

---

## Table of Contents

- [Course Project](#course-project)
- [Course Roadmap](#course-roadmap)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Database Model](#database-model)
- [Practice Queries](#practice-queries)
- [Data Manipulation Practice](#data-manipulation-practice)
- [Transaction Control Language](#transaction-control-language)
- [Class Resources](#class-resources)
- [Security Note](#security-note)
- [License](#license)

---

## Course Project

A retail company wants to replace its spreadsheet-based sales and inventory
system with a relational database. The spreadsheets duplicate customers, products,
and stores, store inconsistent prices, and make reporting difficult.

The class designs the replacement step by step:

1. Analyze the business requirements and identify entities and relationships.
2. Normalize the design from **1NF** to **2NF** to **3NF**.
3. Draw the ERD / relational diagram.
4. Implement it in PostgreSQL running in Docker.
5. Load data, alter tables, add indexes, and answer business questions with SQL.
6. Modify data safely with `UPDATE`, `DELETE`, and `TRUNCATE`, including transactions and `ROLLBACK`.
7. Use transaction control statements and write queries to retrieve, filter, sort, and summarize business data.
8. Combine related tables with joins and build business reports with grouping, conditional logic, and subqueries.

The full project statement (business rules, phases, deliverables, and analysis questions)
is in [`class-09-09-2026/project-introduction.md`](class-09-09-2026/project-introduction.md).

---

## Course Roadmap

| Date | Folder | Topic | Contents |
| ---- | ------ | ----- | -------- |
| 2026-09-09 | [`class-09-09-2026`](class-09-09-2026) | Project introduction, 1NF and 2NF | `project-introduction.md`, diagrams `RetailDB-1FN.jpg`, `RetailDB-2FN.jpg`, `RetailDB-db.drawio` |
| 2026-09-16 | [`class-09-16-2026`](class-09-16-2026) | 3NF | `RetailDB-3FN.jpg`, `RetailDB.drawio` |
| 2026-09-23 | [`class-09-23-2026`](class-09-23-2026) | Final 3NF model | `RetailDB-3FN.jpg`, `RetailDB.drawio` |
| 2026-09-30 | [`class-09-30-2026`](class-09-30-2026) | Docker and the PostgreSQL environment | `docker-installation-tutorial.md`, `docker-compose.yml`, `.env`, first `01-CREATE-TABLES.sql` (geography and catalog tables) |
| 2026-10-07 | [`class-10-07-2026`](class-10-07-2026/retail-sales-db) | Complete schema and indexes | `01-CREATE-TABLES.sql`, `02-INDEXES.sql` |
| 2026-10-14 | [`class-10-14-2026`](class-10-14-2026) | `ALTER TABLE` and data insertion | `03-ALTER-TABLE.sql`, `04-INSERT-DATA.sql` |
| 2026-10-21 | [`class-10-21-2026`](class-10-21-2026) | Full dataset, SQL queries, and data manipulation (`UPDATE`, `DELETE`, `TRUNCATE`) | `05-INSERT-PHONES.sql`, `06-INSERT-DATASET.sql`, `07-TRUNCADE.sql`, `08-UPDATE.sql`, `09-DELETE.sql`, `queries.md` |
| 2026-11-11 | [`class-11-11-2026`](class-11-11-2026) | **TCL** `BEGIN`, `COMMIT`, `ROLLBACK`, `SAVEPOINT` | `10-TCL.sql` |
| 2026-11-18 | [`class-11-18-2026`](class-11-18-2026) | SQL querying, filtering, sorting, distinct results, subqueries, and aggregate functions | `12-QUERIES.sql` |
| 2026-11-25 | [`class-11-25-2026`](class-11-25-2026) | Intermediate queries: joins, `GROUP BY`, `HAVING`, date functions, JSON data, `CASE`, and subqueries | `13-QUERIES-INTERMEDIATE.sql` |

> The `.drawio` files can be opened and edited with [draw.io (diagrams.net)](https://app.diagrams.net/).

---

## Prerequisites

- **Docker** with **Docker Compose** (Docker Desktop on Windows/macOS, Docker Engine on Ubuntu). Follow the [Docker installation guide](class-09-30-2026/docker-installation-tutorial.md), which covers Windows 11 (WSL 2), Ubuntu, and macOS.
- A terminal and a code editor such as Visual Studio Code.
- Optional: a SQL client. The Compose file already includes **pgAdmin**.

---

## Getting Started

The steps below use the latest version of each script. The Docker commands are
run from `class-09-30-2026/retail-sales-db/`, and the SQL scripts can be run from
pgAdmin or `psql`, in the order shown.

### 1. Start PostgreSQL and pgAdmin

The Docker environment lives in `class-09-30-2026/retail-sales-db/`. It starts two services:

| Service | Image | Container name | Host URL / port |
| ------- | ----- | -------------- | --------------- |
| PostgreSQL | `postgres:16` | `retail-sales-db` | `localhost:5566` |
| pgAdmin | `dpage/pgadmin4` | `retail-sales-rdbms` | <http://localhost:7070> |

```bash
cd class-09-30-2026/retail-sales-db
docker compose up -d
docker compose ps        # wait until the database is "healthy"
```

Database name, user, password, and ports come from the `.env` file in that folder.

### 2. Create the schema

Run the full schema (28 tables). It starts with `DROP TABLE IF EXISTS ... CASCADE`,
so it can be re-run to reset the database.

[01-CREATE-TABLES.sql](class-10-07-2026/retail-sales-db/01-CREATE-TABLES.sql)

### 3. Add the indexes

[02-INDEXES.sql](class-10-07-2026/retail-sales-db/02-INDEXES.sql)

### 4. Load the data

Choose **one** dataset on an empty database (both assume IDs start at 1):

- **Full dataset (recommended for practice):** [06-INSERT-DATASET.sql](class-10-21-2026/06-INSERT-DATASET.sql)
- **Small example dataset:** [04-INSERT-DATA.sql](class-10-14-2026/04-INSERT-DATA.sql), followed by [05-INSERT-PHONES.sql](class-10-21-2026/05-INSERT-PHONES.sql)

> `05-INSERT-PHONES.sql` adds a new customer, supplier, and store with their phones using
> fixed IDs (for example, user 3 and phones 9 to 14). It is written to run right after
> the small dataset, **not** after `06-INSERT-DATASET.sql`.

### 5. Practice

Open pgAdmin at <http://localhost:7070>, or connect with `psql`:

```bash
docker exec -it retail-sales-db psql -U "$DB_USER" -d "$DB_NAME"
```

Use the practice materials in chronological order:

- [`class-10-21-2026/queries.md`](class-10-21-2026/queries.md) contains the original set of 30 practice questions.
- [`class-11-18-2026/12-QUERIES.sql`](class-11-18-2026/12-QUERIES.sql) contains additional query examples focused on filtering, sorting, distinct results, subqueries, and aggregate functions.
- [`class-11-25-2026/13-QUERIES-INTERMEDIATE.sql`](class-11-25-2026/13-QUERIES-INTERMEDIATE.sql) contains 10 intermediate-level queries (2.1 - 2.10) with joins, grouping, conditional logic, and subqueries.
- The `ALTER TABLE` exercises are in [`class-10-14-2026/03-ALTER-TABLE.sql`](class-10-14-2026/03-ALTER-TABLE.sql).
- The `UPDATE`, `DELETE`, and `TRUNCATE` examples are described in [Data Manipulation Practice](#data-manipulation-practice).
- Transaction examples are described in [Transaction Control Language](#transaction-control-language).

### 6. Stop the environment

```bash
cd class-09-30-2026/retail-sales-db
docker compose down        # keeps the data volumes
docker compose down -v     # also deletes all data
```

> **Port already in use?** Change `DB_PORT` or `PGADMIN_PORT` in `.env`.
> See the troubleshooting section of the Docker guide.

---

## Database Model

The final schema has **28 tables**, grouped by domain. Primary keys are
`INT GENERATED ALWAYS AS IDENTITY`, and every table has `created_at` and `updated_at` timestamps.

| Domain | Tables |
| ------ | ------ |
| Geography | `country`, `department`, `city` |
| Catalogs | `user_type`, `role`, `document_type`, `payment_method`, `payment_status`, `type_inventory_transfer`, `category`, `phone` |
| Suppliers and stores | `supplier`, `store` |
| People | `user`, `customer`, `employee` |
| Phones (associative) | `user_phone`, `supplier_phone`, `store_phone` |
| Products | `product`, `product_category` |
| Inventory | `inventory`, `inventory_stock`, `inventory_transfer`, `inventory_transfer_detail` |
| Sales and payments | `sale`, `sale_detail`, `payment` |

Design decisions worth noting:

- **Normalized to 3NF.** Geography, categories, roles, and payment data are separate tables instead of repeated text.
- **Supertype `user`.** Customers and employees both reference `user` (one-to-one, enforced with `UNIQUE`).
- **Many-to-many resolved with associative tables.** Products and categories use `product_category`, and phones use `*_phone` tables.
- **Inventory per store.** `inventory_stock` stores quantity and minimum stock for each product in each store, with `UNIQUE (inventory, product)`.
- **Transfers between stores.** `inventory_transfer` and its detail table record stock moves, with a check that origin and destination differ.
- **Sales and payments.** A sale has many `sale_detail` rows, and a sale can have several `payment` rows (for example, a declined payment followed by a successful retry).
- **Data integrity.** `NOT NULL`, `UNIQUE`, `CHECK`, and foreign key constraints are used throughout, and indexes cover foreign keys, date-range reports, and low-stock lookups.

Diagrams for each normalization stage are in the class folders (`RetailDB-1FN.jpg`, `RetailDB-2FN.jpg`, `RetailDB-3FN.jpg`, plus editable `.drawio` sources).

---

## Practice Queries

The course includes three sets of query practice material.

### Original practice set

[`class-10-21-2026/queries.md`](class-10-21-2026/queries.md) contains 30 exercises
on the retail database, in three levels:

| Level | Focus | Exercises |
| ----- | ----- | --------- |
| Beginner | Single-table queries, filtering, sorting, basic aggregates | 1.1 - 1.10 |
| Intermediate | Joins, `GROUP BY`, `HAVING`, `CASE`, subqueries | 2.1 - 2.10 |
| Advanced | Revenue reports, window functions, running totals, ranking, stock and transfer analysis | 3.1 - 3.10 |

### November 18, 2026 — Query practice

[`class-11-18-2026/12-QUERIES.sql`](class-11-18-2026/12-QUERIES.sql) provides additional SQL examples using the retail database. The script demonstrates the following topics:

| Topic | SQL features | Practice focus |
| ----- | ------------ | -------------- |
| Selecting and sorting records | `SELECT`, `ORDER BY`, `LIMIT` | Retrieve records and sort them by selected columns, including limiting the result set |
| Filtering by comparison | `WHERE`, `<=` | Find products whose unit price is below a specified threshold |
| Filtering by range | `BETWEEN` | Retrieve products within a unit-price range and belonging to a specified supplier |
| Pattern matching | `LIKE` | Find products whose names contain a particular word |
| Filtering by a list | `IN` | Retrieve cities whose names match a list of values |
| Missing values | `IS NULL` | Find users without a second last name |
| Unique values | `DISTINCT`, `DISTINCT ON` | Retrieve used document types and compare product records while selecting one record per description |
| Scalar subqueries | Nested `SELECT` statements | Filter departments by the country named Colombia and payments by the status named Paid |
| Aggregate functions | `COUNT`, `COUNT(DISTINCT ...)`, `MIN`, `MAX`, `AVG`, `SUM` | Count sales and distinct customers, and calculate payment statistics |

The examples in the script include:

1. Listing the departments (states) associated with Colombia.
2. Retrieving the five most expensive product records, both with duplicate records and with unique product descriptions using PostgreSQL's `DISTINCT ON`.
3. Finding products with a unit price less than or equal to 25 USD.
4. Finding products from supplier `2` with prices between 100 and 130 USD.
5. Finding products whose names contain `Slides`.
6. Retrieving Bogotá, Medellín, Cali, and Barranquilla from the `city` table.
7. Finding users whose `second_lastname` is `NULL`.
8. Listing the document types currently used by users.
9. Counting total sales and the number of distinct customers who bought.
10. Calculating the smallest, largest, average, and total value of payments whose status is `Paid`.

> The November 18 script contains the examples listed above. It does not, by itself, define a separate numbered intermediate or advanced exercise set.

Run the statements individually and inspect each result. The examples are intended for query practice and retrieve data; they do not modify table records.

### November 25, 2026 — Intermediate queries

[`class-11-25-2026/13-QUERIES-INTERMEDIATE.sql`](class-11-25-2026/13-QUERIES-INTERMEDIATE.sql) provides 10 intermediate-level queries (2.1 - 2.10) on the retail database. The script demonstrates the following topics:

| Topic | SQL features | Practice focus |
| ----- | ------------ | -------------- |
| Combining tables | `INNER JOIN`, `JOIN`, `ON` | Connect related tables through their keys, joining two or more tables in one query |
| Readable queries and results | Table and column aliases (`AS`) | Shorten table references and give result columns descriptive names |
| Reserved words | Quoted identifiers (`"user"`) | Query a table whose name is a reserved word in PostgreSQL |
| Finding unmatched rows | `LEFT JOIN`, `IS NULL` | Find customers who have no related sales (anti-join) |
| Grouping and summarizing | `GROUP BY`, `COUNT`, `SUM`, `AVG`, `ROUND` | Calculate counts, totals, and rounded averages per group |
| Filtering groups | `HAVING` | Keep only the groups that meet an aggregate condition |
| Grouping by date | `DATE_TRUNC`, `TO_CHAR` | Count sales per month and format the month as `YYYY-MM` |
| JSON data | `->>` | Extract a value as text from the product `details` column and group by it |
| Conditional logic | `CASE` | Classify products into price tiers |
| Ordering by an aggregate | `ORDER BY MIN(...)` | Sort the price tiers from cheapest to most expensive |
| Subqueries | Scalar subquery in `WHERE` | Compare each product price with the average price |
| Top results | `ORDER BY`, `LIMIT` | Return the 10 most expensive products above the average |

The queries in the script answer the following:

| Query | Business question | Main concepts |
| ----- | ----------------- | ------------- |
| 2.1 | Which department does each city belong to? | `INNER JOIN` |
| 2.2 | In which city and department is each store located? | Multiple joins, aliases |
| 2.3 | How many products does each supplier provide, and what is their average price? | `COUNT`, `AVG`, `ROUND`, `GROUP BY` |
| 2.4 | How many payments are in each status, and how much money does each status represent? | `JOIN`, `COUNT`, `SUM`, `GROUP BY` |
| 2.5 | Which categories contain more than 10 products? | Associative table, `HAVING` |
| 2.6 | Which customers have never bought anything? | `LEFT JOIN`, `IS NULL` |
| 2.7 | How many sales were made in each month? | `DATE_TRUNC`, `TO_CHAR`, `GROUP BY` |
| 2.8 | In which countries are the products manufactured, and how many come from each? | JSON operator `->>`, `GROUP BY` |
| 2.9 | How many products are Budget (under 30 USD), Standard (30 to under 100 USD), and Premium (100 USD or more)? | `CASE`, `ORDER BY MIN(...)` |
| 2.10 | Which are the 10 most expensive products that cost more than the average product? | Scalar subquery, `LIMIT` |

Run the statements individually and inspect each result. These queries only retrieve data; they do not modify table records.

---

## Data Manipulation Practice

Three scripts in [`class-10-21-2026`](class-10-21-2026) teach how to change data, each with 10 commented examples:

| Script | Statement | Topics covered |
| ------ | --------- | -------------- |
| [`08-UPDATE.sql`](class-10-21-2026/08-UPDATE.sql) | `UPDATE` | One row and many rows, several columns, arithmetic on the current value, `CASE`, `NULL` and `COALESCE`, `UPDATE ... FROM`, subqueries, `RETURNING`, transactions |
| [`09-DELETE.sql`](class-10-21-2026/09-DELETE.sql) | `DELETE` | Primary key, comparison operators, `IN`, `BETWEEN`, `LIKE`, deleting child rows before parents, subqueries, `DELETE ... USING`, `RETURNING`, transactions |
| [`07-TRUNCADE.sql`](class-10-21-2026/07-TRUNCADE.sql) | `TRUNCATE` | `RESTART IDENTITY`, `CASCADE`, several tables at once, transactions and `SAVEPOINT`, resetting the whole database |

How to run them:

- Load the **full dataset** first ([`06-INSERT-DATASET.sql`](class-10-21-2026/06-INSERT-DATASET.sql)). The examples use specific IDs and row counts from that dataset.
- Run the examples **one at a time**, checking each result with the `SELECT` statements included. Examples marked with `BEGIN` ... `ROLLBACK` can be repeated safely.
- Several examples permanently change data, and later examples can depend on earlier ones. If something looks wrong, run `07-TRUNCADE.sql` (Example 6, which empties the whole database), then reload `06-INSERT-DATASET.sql`.
- These scripts are **destructive**. Use them only on the local course database, never on a real one.

---

## Transaction Control Language

The transaction control examples are in [`class-11-11-2026/10-TCL.sql`](class-11-11-2026/10-TCL.sql).

The class introduces the statements used to control database transactions:

| Statement | Purpose |
| --------- | ------- |
| `BEGIN` | Starts a transaction block |
| `COMMIT` | Makes the changes in the current transaction permanent |
| `ROLLBACK` | Cancels the changes made in the current transaction |
| `SAVEPOINT` | Creates a point within a transaction to which you can roll back |

Run transaction examples against the local course database. Pay attention to whether each example ends with `COMMIT` or `ROLLBACK`, since that determines whether its changes are retained.

---

## Class Resources

Theory and setup documents are in [`class-resources`](class-resources):

| Document | Description |
| -------- | ----------- |
| [FUNDAMENTALS OF RELATIONAL DATABASES.pdf](<class-resources/FUNDAMENTALS OF RELATIONAL DATABASES.pdf>) | Theory of relational databases and normalization |
| [DOCKER INTRODUCTION.pdf](<class-resources/DOCKER INTRODUCTION.pdf>) | Introduction to Docker concepts |
| [SETTING UP A SOFTWARE DEVELOPMENT ENVIRONMENT ON WINDOWS 11.pdf](<class-resources/SETTING UP A SOFTWARE DEVELOPMENT ENVIRONMENT ON WINDOWS 11.pdf>) | Preparing a Windows 11 development environment |

---

## Security Note

The `.env` file in `class-09-30-2026/retail-sales-db/` holds the credentials
used by the Docker setup. It is included only so students can run the class
environment locally. **Never reuse these values, and never commit real credentials, in your own projects.**
Use a `.env.example` with placeholders and add `.env` to `.gitignore`.

---

## License

This project is licensed under the [MIT License](LICENSE).