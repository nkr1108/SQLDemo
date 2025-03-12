CREATE DATABASE demo_ddl_db;

USE demo_ddl_db;

CREATE TABLE addresses (
	id INT,
    house_number INT,
    city VARCHAR(20),
    postcode VARCHAR(7)
);

CREATE TABLE people (
	id INT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    address_id INT
);

CREATE TABLE pets (
	id INT,
    name VARCHAR(20),
    species VARCHAR(20),
    owner_id INT
);

SHOW TABLES;

DESCRIBE addresses;
DESCRIBE people;

-- sql to add a primary key to a table
ALTER TABLE addresses
ADD PRIMARY KEY (id);
-- DROP PRIMARY KEY;
-- MODIFY id int;

DESCRIBE people;

ALTER TABLE people
ADD PRIMARY KEY (id);

ALTER TABLE pets
ADD PRIMARY KEY (id);

-- add foreign key
ALTER TABLE people
ADD CONSTRAINT FK_PeopleAddress
-- DROP FOREIGN KEY FK_PeopleAddress,
-- DROP INDEX FK_PeopleAddress
FOREIGN KEY (address_id) REFERENCES addresses(id);

-- how to add a unique constraint to a column 
DESCRIBE PETS;
ALTER TABLE pets
-- ADD CONSTRAINT u_species UNIQUE (species);
DROP INDEX u_species;

-- how to change/rename column's name
-- ALTER TABLE <table name>
-- CHANGE <current column name> <new column name> <data type>;
-- OR
-- ALTER TABLE <table name>
-- RENAME COLUMN <current column name> TO <new column name>;

DESCRIBE pets;

ALTER TABLE pets
-- CHANGE species animal_type VARCHAR(20);
RENAME COLUMN animal_type TO species;

-- change the data type of the column 
-- ALTER TABLE <table name>
-- CHANGE <current column name> <current column name> <new data type>;
-- OR
-- ALTER TABLE <table name>
-- MODIFY COLUMN <column name> <data type>;

-- Exercise
-- 1) add a primary key to the id field in the 'pets' table

DESCRIBE pets;

-- 2) check the 'people' table and add a primary key to the 'id' field if it doesn't already have one

DESCRIBE people;

-- 3) Add a foreign key to the 'owner_id' field of the 'pets' table, referencing the 'id' field in the 'people' table
-- add foreign key
ALTER TABLE pets
ADD CONSTRAINT FK_owner_id
-- DROP FOREIGN KEY FK_PeopleAddress,
-- DROP INDEX FK_PeopleAddress
FOREIGN KEY (owner_id) REFERENCES people(id);

-- 4) Add a column named 'email' to the 'people' table
ALTER TABLE people
ADD COLUMN email VARCHAR(30);

DESCRIBE people;

-- 5) Rename the 'name' column in the 'pets' table to 'first_name'
DESCRIBE pets;
ALTER TABLE pets
RENAME COLUMN name TO first_name;

-- 6) Change the 'postcode' data type to CHAR(7) in the 'addresses' table
ALTER TABLE addresses
MODIFY COLUMN postcode CHAR(7);

-- 7) Add a 'unique constraint' to the 'email' column in the 'people' table
DESCRIBE people;
ALTER TABLE people
ADD CONSTRAINT u_email UNIQUE (email);
