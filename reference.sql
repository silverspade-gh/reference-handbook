/* reference.sql
** A reference file for any and all PostgreSQL query patterns and more
*/

/* Basics */

-- Display table
SELECT *
FROM table_name;

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

-- Insert values into columns
INSERT INTO table_name (column1, column2, ...)
VALUES 
  (
  value_for_column1_row1,
  value_for_column2_row2,
  ...
  ),
  (
  value_for_column1_row2,
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
