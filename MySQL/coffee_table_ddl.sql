SHOW DATABASES;

CREATE DATABASE coffee_store;

USE coffee_store;

CREATE TABLE products (
	id INT auto_increment PRIMARY KEY,
	name VARCHAR(30),
	price DECIMAL(3,2)
);

SHOW TABLES;

CREATE TABLE customers
(
	id INT auto_increment PRIMARY KEY,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	gender ENUM('M','F'),
	phone_number VARCHAR(11)
);

CREATE TABLE orders (
	id INT auto_increment PRIMARY KEY,
    product_id INT,
    customer_id INT,
    order_time DATETIME,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- HOW TO ADD AND REMOVE COLUMNS FROM A TABLE
USE coffee_store;

DESCRIBE products; -- examine the columns of the table
DESCRIBE orders;

ALTER TABLE products
ADD COLUMN coffee_origin VARCHAR(30);

ALTER TABLE products
DROP COLUMN coffee_origin;

-- HOW TO DELETE TABLES FROM A DATABASE
 
CREATE DATABASE example;
 
USE example;
 
CREATE TABLE test (
id INT auto_increment PRIMARY KEY,
name VARCHAR(30),
age INT
);
 
DESCRIBE test;
SHOW TABLES;

DROP TABLE test;


-- HOW TO DELETE TABLES FROM A DATABASE
 
CREATE DATABASE example;
 
USE example;
 
CREATE TABLE test (
id INT auto_increment PRIMARY KEY,
name VARCHAR(30),
age INT
);
 
DESCRIBE test;
SHOW TABLES;

DROP TABLE test;

INSERT INTO test (name, age) VALUES('Ben', 19), ('Simon', 28), ('Claire', 23);
SELECT * FROM test;

TRUNCATE TABLE test;
