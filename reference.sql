/* reference.sql
** A reference file for any and all PostgreSQL query patterns and more
*/

/* Basics */

-- Create Table
CREATE TABLE table_name (
  pkey DATA_TYPE [PRIMARY KEY GENERATED ALWAYS AS IDENTITY],
  column2 DATA_TYPE [CONSTRAINT],
  ...
);

-- Display table
SELECT *
FROM table_name;

-- Display a table that is ordered from highest to lowest on column_name
-- Limited to 10 rows
SELECT *
FROM table_name
ORDER BY column_name DESC
LIMIT 10;

-- Table description
psql \d table_name;

-- Add column(s)
ALTER TABLE table_name
ADD COLUMN (
  column1 data_type1 [constraint1]
  column2 data_type2 [constraint2],
  ...
);

-- Drop column(s)
-- Note the lack of parentheses
ALTER TABLE table_name
DROP COLUMN 
  column1, 
  column2,
  ...;

-- Change data type of column
ALTER TABLE table_name
ALTER COLUMN column_name TYPE new_type [USING CASE WHEN condition THEN type_cast_1 ELSE type_cast_2]

-- Add a UNIQUE constraint of a column
ALTER TABLE words
ADD CONSTRAINT column1_constraint_name UNIQUE (column1)
[WHERE condition1];

-- Dropping a constraint
-- (Modifications of constraints are not allowed.)
ALTER TABLE words
DROP CONSTRAINT column1_constraint_name;

-- Insert values into columns
INSERT INTO table_name (column1, column2, ...)
VALUES 
  (
  value_for_column1_row1,
  value_for_column1_row2,
  ...
  ),
  (
  value_for_column2_row1,
  value_for_column2_row2,
  ...
  );

/* Insert values by selecting pre-existing ones
** This query inserts a row containing two fields, column1's field and the value 'Disney'
** If the position attribute of that row matches the case-insensitive pattern of characters 'Analyst'
*/
INSERT INTO table2 (column1, column2) 
SELECT column1, 'Disney'
FROM users
WHERE position ILIKE 'Analyst';

-- Edit values in column(s)
UPDATE table_name
SET 
  column1 = 'value1',
  column2 = 'value2',
  ...
[WHERE condition1] -- conditionals identify rows in the aforementioned columns that should have their values changed
[AND condition2]
[OR condition3];

/* When constructing WHERE queries, you can use LIKE/ILIKE operators and wildcards for pattern matching.
** Use 'LIKE' instead of '=' 
**
** Use the '%' symbol to represent an indeterminate amount of characters as in WHERE name LIKE '%John'
** This can return results such as "arbitrarytextbeforeJohn John".
**
** Use '_' for an unknown character, as in WHERE name LIKE '__ent'
** This can return results such as "Agent", "Spent", "Trent", etc.
*/

-- Triggers respond to INSERT, UPDATE and DELETE operations.
-- This trigger adds the user

-- Create an arbitrary table of ten rows containing the value 1
SELECT 1
FROM generate_series(1, 10);

-- Test for existence of rows
-- This will return column1's fields if condition1 is satisfied in the sub-query
SELECT column1
FROM table1
WHERE EXISTS (
    SELECT 1
    FROM table2
    WHERE [condition1]
);

-- Quit PostgreSQL
psql \q

/* 
** Postgrest configuration 
*/

-- Install Postgrest on AL 2023 from binary
$ wget https://github.com/PostgREST/postgrest/releases/download/v12.2.6/postgrest-v12.2.6-linux-s
tatic-x86-64.tar.xz
$ tar xJf postgrest-v12.2.6-linux-static-x86-64.tar.xz
$ rm postgrest-*
$ mv postgrest /usr/local/bin

-- Grant anonymous web user read-only access to database mydb via API
CREATE ROLE web_anon nologin;
GRANT usage ON SCHEMA public TO web_anon;
GRANT select ON public.mydb TO web_anon;

-- Connect to DB following the principle of least privilege
CREATE ROLE authenticator noinherit login password 'securepassword';
grant web_anon TO authenticator;

-- dbinfo.conf file for serving the API
db-uri = "postgres://authenticator:mysecretpassword@my_host_address:5432/my_db_name"
db-schemas = "my_schema_name"
db-anon-role = "web_anon"

-- Example Postgrest API read-call
-- Retrieve all rows containing the case-insensitive pattern "zar" within column_name
> http://myhostname:3000/table_name?column_name=ilike(all).{*zar*}
