# SQL Database Course

Activities, exercises, projects, and learning resources for the **SQL Database** 
course. Every class has its own folder, and together they follow a single running 
project: designing, building, and querying a **Retail Sales and Inventory Management System** 
in **PostgreSQL**.

The course goes from the theory of relational databases and normalization 
(1NF, 2NF, 3NF), through implementing the schema with Docker and PostgreSQL, 
to loading data, altering tables, and writing SQL queries.

---

## Table of Contents

- [Course Project](#course-project)
- [Course Roadmap](#course-roadmap)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Database Model](#database-model)
- [Practice Queries](#practice-queries)
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
| 2026-10-21 | [`class-10-21-2026`](class-10-21-2026) | Full dataset and SQL practice | `06-INSERT-DATASET.sql`, `queries.md` (`05-INSERT-PHONES.sql` is currently empty) |

> The `.drawio` files can be opened and edited with [draw.io (diagrams.net)](https://app.diagrams.net/).

---

## Prerequisites

- **Docker** with **Docker Compose** (Docker Desktop on Windows/macOS, Docker Engine on Ubuntu). Follow the [Docker installation guide](class-09-30-2026/docker-installation-tutorial.md), which covers Windows 11 (WSL 2), Ubuntu, and macOS.
- A terminal and a code editor such as Visual Studio Code.
- Optional: a SQL client. The Compose file already includes **pgAdmin**.

---

## Getting Started

The commands below use the latest lesson folder, which contains the complete schema. 
All commands are run from the repository root.

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

# from class-09-30-2026/retail-sales-db

[01-CREATE-TABLES.sql](class-10-07-2026/retail-sales-db/01-CREATE-TABLES.sql)

### 3. Add the indexes

[02-INDEXES.sql](class-10-07-2026/retail-sales-db/02-INDEXES.sql)

### 4. Load the data

[06-INSERT-DATASET.sql](class-10-21-2026/06-INSERT-DATASET.sql)

### 5. Practice

Open pgAdmin at <http://localhost:7070>, or connect with `psql`:

```bash
docker exec -it retail-sales-db psql -U "$DB_USER" -d "$DB_NAME"
```

Then work through [`class-10-21-2026/queries.md`](class-10-21-2026/queries.md). 
The `ALTER TABLE` exercises are in [`class-10-14-2026/03-ALTER-TABLE.sql`](class-10-14-2026/03-ALTER-TABLE.sql).

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

[`class-10-21-2026/queries.md`](class-10-21-2026/queries.md) contains 30 exercises 
on the retail database, in three levels:

| Level | Focus | Exercises |
| ----- | ----- | --------- |
| Beginner | Single-table queries, filtering, sorting, basic aggregates | 1.1 - 1.10 |
| Intermediate | Joins, `GROUP BY`, `HAVING`, `CASE`, subqueries | 2.1 - 2.10 |
| Advanced | Revenue reports, window functions, running totals, ranking, stock and transfer analysis | 3.1 - 3.10 |

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