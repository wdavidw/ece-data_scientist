
-- Use database "ece".

USE ece;

-- Create table "partitioned" with field "state", "day" and "value" where "day" is the concatenation of "{year}-{1st month of trimester}-01" and the partitions "year" and "trim".

DROP TABLE IF EXISTS partitioned;

CREATE TABLE partitioned (
  state string,
  day timestamp,
  value float
)
PARTITIONED BY (year int, trim int)
STORED AS ORC
;

-- Import the data into the table and its partitions using dynamic partitions and the "INSERT OVERWRITE" directive, look for the appropriate property ("SET {property}={value};") or hive will complain.

SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.exec.max.dynamic.partitions.pernode=200000;
SET hive.exec.max.dynamic.partitions=20000;

INSERT OVERWRITE TABLE partitioned PARTITION(year, trim)
SELECT * FROM(
 SELECT
   state, from_utc_timestamp(CONCAT(YEAR,'-',(CASE trim WHEN 1 THEN '01' WHEN 2 THEN '04' WHEN 3 THEN '07' WHEN 4 THEN '10' END),'-01'), 'GMT') day, value, year, trim
 FROM
   optimized
 DISTRIBUTE BY year, trim
) src
;

-- Select the first 10 records to validate your mapping and your import.

SELECT * FROM partitioned WHERE year = 2004 AND trim = 1;






