# postgresql_tutorial1
Basic introduction to PostgreSQL

-   [Introduction](#introduction)
-   [Install PostgreSQL](#Install-PostgreSQL)
-   [Postgres and R](#Postgres-and-R)
-	[Install and load R libraries](#Install-and-load-R-libraries)


## Introduction
This repository provides an intro to PostgreSQL (postgres) database (db).

<br>

## Install Postgres

  - [PostgreSQL](https://www.postgresql.org/)
  - [PostgreSQL Download](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)
  - [PostgreSQL Documentation](https://www.postgresql.org/docs/current/)
  - [PostGIS](https://postgis.net/)

### Database connection parameters

The connection details are as follows:

  - IP: 66.198.240.224
  - Port: 5432
  - Data base: georodco_covid19
  - user name: georodco_pubu
  - password: Covid19Ecuador
  
Using the above parameters you can connect to the db using your prefered choice of statitical program (R, Stata, Excel, etc.)

## Postgres and R
R is an open-source computational and statistical program. You can download it from here: [R-project](https://www.r-project.org/)

* Using R with data from a Postgres db

		# Install libraries (only once)
		install.packages("DBI") # Generic database connector 
		#install.packages("RPostgreSQL") # optional
		#install.packages("rpostgis") # optional
		
		# Load library
		library(DBI)
		library(RPostgreSQL)
		library(RPostgis) # optional


		# create conection to the db
        con <- DBI::dbConnect(drv = "PostgreSQL", user='georodco_pubu', password='Covid19Ecuador', host='66.198.240.224', port=5432, dbname='georodco_covid19')

		# ask db for table ecu_covid19
		res <- dbSendQuery(con, "SELECT * FROM ecu_covid19")
		cv19 <- dbFetch(res)
		
		# check number of rows and columns (25x15)
		dim(cv19)
		
		# check out first (6) rows in the table
		head(cv19)
		
        # Working with spatial data found in Postgres
		#Method 1: use package sf
		library(sf)
		prov <- st_read(con, layer="provinces")
		library(ggplot2)
		ggplot(prov) +  geom_sf() + theme_bw()
		
		# delete connection object
		dbClearResult(res)

		# disconnect from the db
		dbDisconnect(con)

		
## Postgres for data management

Relational dbs are flexible, extensible, and scalable. They are very useful for managing data in colloborative projects.
