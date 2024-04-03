\echo 'Some introductory notes:'
\echo 'All data points are since 2010.'
\echo 'This data includes buildings that are still being constructed. Unless otherwise noted, I\''m considering them as though they were already complete.'

\echo 'Let''s start with a simple query to get familiar with our data.'
SELECT * FROM new_housing LIMIT 20;

\echo 'For the sake of this analysis, we''ll be focusing on borough_code, completion_year, and units_count.'

\echo 'Let''s see the total new construction.'
SELECT COUNT(*) FROM new_housing;

\echo 'What does that look like broken out by borough?'
SELECT
  CASE
    WHEN borough_code = 1 THEN 'Manhattan'
    WHEN borough_code = 2 THEN 'Bronx'
    WHEN borough_code = 3 THEN 'Brooklyn'
    WHEN borough_code = 4 THEN 'Queens'
    WHEN borough_code = 5 THEN 'Staten Island'
    ELSE 'All Boroughs'
    END AS borough,
  COUNT(*) AS total_new_housing
  FROM new_housing
  GROUP BY ROLLUP(borough_code)
  ORDER BY total_new_housing DESC;

\echo 'Unsurprisingly, we find that the least new construction is in densely-packed Manhattan.'
\echo 'Brooklyn and Queens meanwhile are nearly tied for the top spot.'

\echo 'This data set isn''t perfect. Let''s see how many records are lacking a units_count.'
SELECT COUNT(*)
FROM new_housing
WHERE units_count IS NULL;

\echo 'And of the records that do have units_count, what is the average number of units?'
SELECT AVG(units_count) FROM new_housing;

\echo 'How many new units have been constructed?'
SELECT SUM(units_count) FROM new_housing;

\echo 'If we were to apply the average to the total number of new housing, how many total liveable units do we have?'
SELECT COUNT(*) * (
  SELECT AVG(units_count) FROM new_housing
) FROM new_housing;

\echo 'How many buildings have been finished each year?'
SELECT 
  CASE
    WHEN completion_year IS NOT NULL THEN completion_year::text
    ELSE 'Incomplete'
    END AS completion_year,
    COUNT(*)
  FROM new_housing
  GROUP BY completion_year
  ORDER BY completion_year DESC;

\echo 'Completed construction was less than half of what it typically is in 2023.'
\echo 'Although this analysis only takes into account new construction, these numbers are in line with what''s been reported on more broadly.'
\echo 'See: https://www.thecity.nyc/2023/10/18/housing-development-construction-affordable/'

\echo 'What''s the distribution of liveable units per newly constructed building?'
SELECT 
  CASE
    WHEN units_count > 0 AND units_count <= 8 THEN 'small'
    WHEN units_count > 8 AND units_count <= 100 THEN 'medium'
    WHEN units_count > 100 THEN 'large'
  END AS size, COUNT(*) AS count
  FROM new_housing
  WHERE units_count IS NOT NULL
  GROUP BY size  
  ORDER BY count DESC;

\echo 'Let''s zoom in on the small housing.'
SELECT units_count, COUNT(*)
  FROM new_housing
  WHERE units_count <= 8
  GROUP BY units_count
  ORDER BY units_count ASC;

\echo 'The bulk of small housing consists of construction with 1-3 liveable units.'

\echo 'Let''s zoom back out and break these numbers down by borough.'
SELECT 
  CASE
    WHEN units_count > 0 AND units_count <= 8 THEN 'small'
    WHEN units_count > 8 AND units_count <= 100 THEN 'medium'
    WHEN units_count > 100 THEN 'large'
  END AS size,
  CASE
    WHEN borough_code = 1 THEN 'Manhattan'
    WHEN borough_code = 2 THEN 'Bronx'
    WHEN borough_code = 3 THEN 'Brooklyn'
    WHEN borough_code = 4 THEN 'Queens'
    WHEN borough_code = 5 THEN 'Staten Island'
    END AS borough,
  COUNT(*) AS count
  FROM new_housing
  WHERE units_count IS NOT NULL
  GROUP BY size, borough_code
  ORDER BY size DESC, count DESC;

\echo 'Brooklyn and Manhattan are competing as the boroughs with the highest number of large housing developments.'
\echo 'Brooklyn easily leads in medium sized housing.'
\echo 'Small housing is spread relatively evenly between Queens, Staten Island, and Brooklyn.'
\echo 'There are very few medium and large developments in Staten Island.'