# Using R with a relational database (PostgreSQL)
# 2021-02-26

# Libraries only need to be installed once
install.packages("DBI") # Generic database connector
install.packages("RPostgreSQL") # optional
install.packages("rpostgis") # optional

# Load library
library(DBI)
library(RPostgreSQL)
library(RPostgis) # optional

# create conection to the db
# The user has been granted read-only privileges to a public data source
# Note: it is not a good idea to expose your db credentials in a file. It is better to save your login in a protected file.
con <- DBI::dbConnect(drv = "PostgreSQL", user='user', password='password', host='IP', port=5432,dbname='georodco_covid19')

# ask db for table ecu_covid19
res <- dbSendQuery(con, "SELECT * FROM ecu_covid19")
cv19 <- dbFetch(res)

# check number of rows and columns (25x15)
dim(cv19)

# check out first (6) rows in the table
head(cv19)


# Working with spatial data found in Postgres (spatial table: provinces)

# Method 1: use package sf
library(sf)
prov <- st_read(con, layer="provinces")

library(ggplot2)
ggplot(prov) +  geom_sf() + theme_bw()

# Subset data, only map Galapagos Islands
galapagos <- st_read(con, query="SELECT gid, dpa_provin, dpa_despro, geom FROM provinces WHERE dpa_provin='20'")
ggplot(galapagos) +  geom_sf() + theme_bw()

# delete connection object
dbClearResult(res)

# disconnect from the db
dbDisconnect(con)
