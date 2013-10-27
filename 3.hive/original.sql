
-- Create database "ece" if it does not yet exist, manually specify a location of your choice with the "LOCATION" directive.

CREATE DATABASE IF NOT EXISTS ece
LOCATION '/user/wdavidw/ece';

-- Use database "ece".

USE ece;

-- Create database "original" with the columns "state", "year", "trim" and "value" correctly typed, the field delimiter is "\073" which stands for ";".

DROP TABLE IF EXISTS original;

CREATE TABLE original (
  state string,
  year int,
  trim int,
  value float
)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '\073'
STORED AS TEXTFILE
;

-- Import the "employment.csv" dataset from a local source (your local filesystem, not HDFS) to the "original" database using the "LOAD" directive.

LOAD DATA LOCAL INPATH 'employment.csv' OVERWRITE INTO TABLE original;

-- Select the first 10 records to validate your mapping and your import.

SELECT * FROM original LIMIT 10;