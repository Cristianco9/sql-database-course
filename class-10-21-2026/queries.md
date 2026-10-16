# SQL Practice: Retail Sales and Inventory Database

This activity is based on a Retail Sales and Inventory Management System for 
Adidas, a retail chain with stores across Colombia. The database stores the 
geography (departments and cities), suppliers, stores, employees and customers, 
a catalog of products, the inventory of each store and the transfers between 
them, and every sale with its payments. All money values are in USD. 
Read each question carefully and write the SQL query that answers it, starting 
with simple queries on one table and moving up to reports that combine several tables.

## Level 1: Beginner

**1.1** Which departments (states) of Colombia exist in our database?

**1.2** What are the 5 most expensive products?

**1.3** Which products cost less than 25 USD?

**1.4** Which Nike products (supplier 2) cost between 100 and 130 USD?

**1.5** Which products are slides (sandals)?

**1.6** Show the cities Bogotá, Medellín, Cali and Barranquilla.

**1.7** Which users do not have a second lastname?

**1.8** Which document types are actually used by our users?

**1.9** How many sales have we made, and how many different customers bought?

**1.10** What is the smallest, the largest, the average and the total value of the paid payments?

## Level 2: Intermediate

**2.1** Show every city together with the name of its department.

**2.2** List every store with its city and department.

**2.3** How many products does each supplier sell, and at what average price?

**2.4** How many payments do we have in each status, and how much money does each status represent?

**2.5** Which categories contain more than 10 products?

**2.6** Which customers have never bought anything?

**2.7** How many sales did we make in each month?

**2.8** In which countries are our products manufactured?

**2.9** How many products are Budget (< 30 USD), Standard (30 to 99.99 USD) and Premium (100 USD or more)?

**2.10** Which are the 10 most expensive products that cost more than the average product?

## Level 3: Advanced

**3.1** Which 10 stores generate the most revenue? (count only payments with status Paid)

**3.2** Who are the 10 customers who spent the most money?

**3.3** Which 10 products sold the most units in paid sales, and how much money did they bring?

**3.4** How much revenue did we make each month, and how much did it grow compared with the previous month?

**3.5** Which are the 3 products that sold the most units inside each main category?

**3.6** What is the accumulated revenue month after month, and what is the average of the last 3 months?

**3.7** Which products are at or below their minimum stock in each store, and how many units are missing?

**3.8** Which sales had a declined payment followed by a successful one? With which methods?

**3.9** For each store, how many payments are Paid, Declined, Cancelled, Refunded and Pending, and what percentage is paid?

**3.10** For each store, how many units did it receive and send in transfers, and what is the net balance?