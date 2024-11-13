# USGA-Course
Code for Python webscrape of USGA data and creation of SQL Database

## Python webscrape of USGA Course Rating Database
Use course_rating_pull.py to webscrape USGA course rating database.
Some changes may be required to the script as the format of the page changes over the years.
It may be required to only pull a couple thousand course records at a time and then concatenate the files.
This can be done by adjusting the course_id_start and end_id

## MySQL Database of Course Ratings
Create the database named usga_course create the tables and populate it with usga_course_db.sql
Load the updates to fix some issues with the data by running usga_course_db_updates.sql

## Queries for reporting
Use SQL code in usga_course_db_queries.sql to run reports on data

## Data Files
Course and tee files for each course are located in the course_files folder. This is what should be created by webscraping the USGA site.


