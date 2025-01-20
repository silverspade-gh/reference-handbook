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

-- Edit values in column(s)
UPDATE table_name
SET 
  column1 = 'value1',
  column2 = 'value2',
  ...
[WHERE condition1] -- conditionals identify rows in the aforementioned columns that should have their values changed
[AND condition2]
[OR condition3];
