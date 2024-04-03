DROP TABLE new_housing;

-- The names in the comments refer to columns in the original CSV
CREATE TABLE IF NOT EXISTS new_housing (
  -- Unique to this database
	id SERIAL PRIMARY KEY,
  -- Job_Number
	job_number TEXT NOT NULL,
  -- BIN
	bin TEXT NOT NULL,
  -- CompltYear
	completion_year INTEGER,
  -- ClassANet
	class_a_net DECIMAL NOT NULL,
  -- Units_CO
	units_count DECIMAL,
  -- Boro
	borough_code INTEGER NOT NULL,
  -- Latitude
	latitude DECIMAL NOT NULL,
  -- Longitude
	longitude DECIMAL NOT NULL,
  -- AddressNum
	address_number TEXT NOT NULL,
  -- AddressSt
	address_street TEXT NOT NULL
);

COPY new_housing (
	job_number, completion_year, class_a_net, units_count, borough_code, bin, address_number, address_street, latitude, longitude
)
FROM '/app/FormattedHousingDB_post2010.csv'
WITH 
DELIMITER ','
CSV HEADER;