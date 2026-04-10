# Backup and Restore Database

`mysqldupm` can be a very handy tool, and you will see it while working on this task. You will deal with 3 databases, all hosted on the same server: 

- `ShopDB` is a production database for online shopping. This is the database with real user data. 
- `ShopDBReserve` is a copy of the production database used for fast disaster recovery. 
- `ShopDBDevelopment` is a database used by the development team. 

In this task, develop an automated procedure that runs every night. The procedure consists of 2 activities: 

1. Creating a full database backup from the `ShopDB` database and restoring it to the `ShopDBReserve` for fast disaster recovery.
2. Moving data from the production database `ShopDB` to the `ShopDBDevelopment` (database schema should not be copied from production to development environment). 

The activities will be executed on a schedule as a [cron job](https://www.hostinger.com/tutorials/cron-job), and you need to write a bash script, which a job will use.

## Prerequisites

1. Install and configure a MySQL database server on a Virtual Machine.
2. Fork this repository.

## Requirements

Write a bash script in the `task.sh` file. The script should implement a procedure for a backup and restoration of a database, described below: 

1. Read database username and password from environment variables `DB_USER and DB_PASSWORD`. 

2. Create a full backup of the database `ShopDB` using `mysqldump`, and restore it to the database `ShopDBReserve`. 

3. Create a data backup from the database `ShopDB`, and restore it to the database `ShopDBDevelopment`. 

To test this script, you will need to do some preparations: 

1. Connect to your database server and drop the database `ShopDB` if you have it already. 

2. Create databases, described in the task, using the `create-database.sql` script.

3. Create a database user which has just enough permissions to complete the required actions:
```
CREATE USER 'backup'@'%' IDENTIFIED BY '<password>';

-- configure minimum requored permissions for performing a db backup using mysqldump: 
GRANT SELECT, LOCK TABLES, SHOW VIEW, PROCESS ON *.* TO 'backup'@'%';

-- configure required permissions to restore a database 
GRANT ALL ON ShopDBReserve.* TO 'backup'@'%';

-- configure required permissions to restore only data
GRANT INSERT, LOCK TABLES, ALTER ON ShopDBDevelopment.* TO 'backup'@'%';
```

4. Connect to your database server using SSH and export environment variables with database credentials: 
```
export DB_USER="backup"
export DB_PASSWORD="<db-password>"
```

5. Run your script without arguments. 

6. Query the data in the databases: the `Products` table should be present in both the `ShopDBReserve` and `ShopDBDevelopment` databases, and it should have the same amount of records as in the  `ShopDB` database.
