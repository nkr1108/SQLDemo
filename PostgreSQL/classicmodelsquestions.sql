-- 1. List  the names of the cities in alphabetical order where Classic Models has offices. (7)
select city 
 from offices
order by city;

-- 2. List the EmployeeNumber, LastName, FirstName, Extension for all employees working out of the Paris office. (5)  
select employeenumber, lastname, firstname, extension
from employees e, offices o
where e.officecode = o.officecode
  and city = 'Paris'


-- 3. List the ProductCode, ProductName, ProductVendor, QuantityInStock and ProductLine for all products with a QuantityInStock between 200 and 1200. (11) 
select productcode, productname, productvendor, quantityinstock, productline
  from products
 where quantityinstock between 200 and 1200

-- 4. (Use a SUBQUERY) List the ProductCode, ProductName, ProductVendor, BuyPrice and MSRP for the least expensive 
-- (lowest MSRP) product sold by ClassicModels.  (“MSRP” is the Manufacturer’s Suggested Retail Price.)  (1)    
select productcode, productname, productvendor, buyprice, MSRP 
  from products
where MSRP = (select min(MSRP) 
				from products)

-- 5. What is the ProductName and Profit of the product that has the highest profit (profit = MSRP minus BuyPrice). (1)   
select productname, (MSRP - buyprice) as "Profit"
  from products
order by 2 desc limit 1;

-- 6. List the country and the number of customers from that country for all countries having just two  customers.  
-- List the countries sorted in ascending alphabetical order. Title the column heading for the count of customers as “Customers”.(7)   
select country, count(customernumber) as "Customers"
  from customers
group by country
having count(*) = 2
order by country;

-- 7. List the ProductCode, ProductName, and number of orders for the products with exactly 25 orders.
-- Title the column heading for the count of orders as “OrderCount”. (12)  
select o.productcode, productname, count(ordernumber) as "Quantity"
  from orderdetails o, products p
 where o.productcode = p.productcode
group by o.productcode, productname
having count(ordernumber) = 25

-- 8. List the EmployeeNumber, Firstname + Lastname  (concatenated into one column in the answer set, separated by
-- a blank and referred to as ‘name’) for all the employees reporting to Diane Murphy or Gerard Bondur. (8)  
select employeenumber, (firstname || ' ' || lastname) as "Name", reportsto
  from employees
where reportsto in (select employeenumber
                      from employees
					 where (firstname || ' ' || lastname) in ('Diane Murphy','Gerard Bondur'));

-- 9. List the EmployeeNumber, LastName, FirstName of the president of the company (the one employee with no boss.)  (1)  
select employeenumber, lastname, firstname, jobtitle
  from employees
 where reportsto is null

-- 10. List the ProductName for all products in the “Classic Cars” product line from the 1950’s.  (6)
select productname, productline
  from products
 where productline = 'Classic Cars'
   and productname like '%195%'
order by productname;

-- 11. List the month name and the total number of orders for the month in 2004 in which ClassicModels customers placed the most orders. (1)  
select TO_CHAR(orderDate, 'Month') as month_name, count(*) as total_orders
from orders
where extract(year from orderDate) = 2004
group by month_name
order by total_orders desc limit 1;

-- 12. List the firstname, lastname of employees who are Sales Reps who have no assigned customers.  (2) 
SELECT e.firstName, e.lastName
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE e.jobTitle = 'Sales Rep' AND c.customerNumber IS NULL;


-- 13. List the customername of customers from Switzerland with no orders. (2)  
SELECT c.customerName, country
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
WHERE c.country = 'Switzerland' AND o.orderNumber IS NULL;


-- 14. List the customername and total quantity of products ordered for customers who have ordered more than 1650 products across all their orders.  (8) 
SELECT c.customerName, SUM(od.quantityOrdered) AS total_quantity
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName
HAVING SUM(od.quantityOrdered) > 1650
ORDER BY total_quantity DESC;

-- DML/DDL
-- 1. Create a NEW table named “TopCustomers” with three columns: CustomerNumber (integer), 
-- ContactDate (DATE) and  OrderTotal (a real number.)  None of these columns can be NULL.  
CREATE TABLE TopCustomers (
  CustomerNumber INT NOT NULL,
  ContactDate DATE NOT NULL,
  OrderTotal REAL NOT NULL
);

-- 2. Populate the new table “TopCustomers” with the CustomerNumber, today’s date, and the total value of all
-- their orders (PriceEach * quantityOrdered) for those customers whose order total value is greater than $140,000. (should insert 10 rows )

insert into TopCustomers (CustomerNumber, ContactDate, OrderTotal)
select c.customerNumber, current_date as ContactDate, sum(od.quantityOrdered * od.priceEach) as OrderTotal
from  customers c
join orders o on c.customerNumber = o.customerNumber
join orderdetails od ON o.orderNumber = od.orderNumber
group by c.customerNumber
having sum(od.quantityOrdered * od.priceEach) > 140000
order by OrderTotal desc limit 10;

-- 3. List the contents of the TopCustomers table in descending OrderTotal sequence. (10) 
select * 
  from TopCustomers
order by OrderTotal desc;

-- 4. Add a new column to the TopCustomers table called OrderCount (integer).
alter table TopCustomers
add column OrderCount int;

-- 5. Update the Top Customers table, setting the OrderCount to a random number between 1 and 10.
update TopCustomers
set OrderCount = floor(RANDOM() * 10 + 1);

-- 6. List the contents of the TopCustomers table in descending OrderCount sequence. (10 rows)
select *
from topcustomers
order by ordercount desc;


