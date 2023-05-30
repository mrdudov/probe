CREATE TABLE IF NOT EXISTS height_of_male_and_female_by_country_2022
(
    rank int,
    country_name varchar(128),
    male_height_in_cm real,
    female_height_in_cm real,
    male_height_in_ft real,
    female_height_in_ft real
);

\copy height_of_male_and_female_by_country_2022 
FROM './projects/db-probe/postgresql/Height of Male and Female by Country 2022.csv' 
DELIMITER ',' 
CSV HEADER;

SELECT * FROM height_of_male_and_female_by_country_2022;
 