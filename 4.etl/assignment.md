
Sqoop, Oozie and Hive
=====================

Description
-----------

You may work on the cluster or your vm. The final code must be uploaded to the cluster. If you dont have an account, goto "http://duzy01.adaltas.com:6500/signin".

Usecase
-------

Synchronizing a static/reference table stored inside an external database with a Hive table.

1. Create a Sqoop command to import data from MySQL into HDFS.

You must import the employment table. The table is installed inside the "ece" database on the cluster or use this [SQL script](https://github.com/wdavidw/ece-data_scientist/blob/master/4.etl/employment.sql).

On the cluster, an "ece" database is available using the user "ece" and the password "ece": `mysql -uece -pece ece -e "show tables"`. On the vm, MySQL can be access as root and you can import the dataset with: `mysql -uroot {database} < {path_sql}`.

2. Create an Oozie workflow

We want to create a workflow of 3 sequential actions:
2.1 Sqoop: Import data from an external database into HDFS as uncompressed CSV using the sqoop command created above
2.2 Hive: Transform this extracted dataset into an optimized Hive stable using the Hive query created last week to insert data from a csv file to an ORC file
2.3 HDFS: Remove the CSV database imported in 2.1

3. Create an Oozie Coordinator

Using the workflow created above, create a coordinator than run the workflow once every 10 minutes to overwrite the final Hive table with any changes made into the MySQL source database.

Notes

Oozie is full of interesting examples, clone oozie with `git clone https://github.com/apache/oozie.git` and look at the example directory inside.
