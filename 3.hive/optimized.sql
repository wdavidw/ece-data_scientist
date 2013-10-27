
-- Use database "ece".

USE ece;

-- Create database "optimized" with the same columns as in "partitioned" and with the ORC file format.

DROP TABLE IF EXISTS optimized;

CREATE TABLE optimized (
  state string,
  year int,
  trim int,
  value float
)
STORED AS ORC tblproperties ("orc.compress"="NONE")
;

-- Import the data into the table and its partitions using dynamic partitions and the "INSERT OVERWRITE" directive.

INSERT OVERWRITE TABLE optimized
SELECT *
FROM(
 SELECT
   state, year, trim, value
 FROM
   original
) src
;

-- Select the first 10 records of a single partition to validate your mapping and your import.

SELECT * FROM optimized LIMIT 10;






