## About

This project uses NYC Open Data (https://opendata.cityofnewyork.us/) to investigate new housing construction in NYC. It answers questions like "How much new construction has occurred in NYC by borough?" and "How is the size of housing developments distributed across small, medium, and large projects". This project is intended as an exploration of NYC Open Housing Data; for a more exhaustive look at the state of NYC housing stock, check out the NYC Department of Planning's website. 

## Notes

### Housing Data

- Data set source: https://www.nyc.gov/site/planning/data-maps/open-data/dwn-housing-database.page
- 5642 / 26132 (21.5%) of the formatted records do not contain data about how many livable units are in the new building. The average unit count among the 78.5% of records is 16.5 (rounded).
- Boroughs are represented by a 1-5 range. The mappings are:
  - 1: Manhattan
  - 2: Bronx
  - 3: Brooklyn
  - 4: Queens
  - 5: Staten Island
- BIN stands for Building Identification Number and identifies each unique building in the city. It is 7 digit string starting with the borough code and 6 digit unique building number

## Installing and Running

Prerequisites:
- Docker
- NodeJS (If following the next section's instructions)

1. In the root directory, run `docker build -t nyc-housing-analysis .`
2. Once the image has been built, run `docker run --name nyc-housing-analysis -e POSTGRES_PASSWORD=password -d nyc-housing-analysis`
3. Exec into the container: `docker exec -it nyc-housing-analysis /bin/bash`
4. Execute the initial data migration: `psql -U postgres -f index.sql`. If the Postgres server has not yet started, wait a moment and try again.
5. Execute the analysis: `psql -U postgres -f analysis.sql`

### Updating the Format of the Original Data Set

Note that this project already comes loaded with a formatted and paired down data set. That said, if you'd like to transform the original data set yourself:

1. Download the original data set from the link in the Housing Data section. Save it to the root directory of this project.
2. Follow the instuctions in ./js/README.md
3. Repeat step 2 from the main Installing and Running instructions

## Roadmap

- [x] Ingest data into Postgres
- [x] Dockerize the project
- [x] Run and document analysis queries 