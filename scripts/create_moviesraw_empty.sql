DROP TABLE IF EXISTS moviesraw;
CREATE TABLE moviesraw (
    imdb_title_id VARCHAR,
    title VARCHAR,
    original_title VARCHAR,
    year VARCHAR,
    date_published VARCHAR,
    genre VARCHAR,
    duration VARCHAR,
    country VARCHAR,
    language VARCHAR,
    director VARCHAR,
    writer VARCHAR,
    production_company VARCHAR,
    actors VARCHAR,
    description VARCHAR,
    avg_vote VARCHAR,
    votes VARCHAR,
    budget VARCHAR,
    usa_gross_income VARCHAR,
    worlwide_gross_income VARCHAR,
    metascore VARCHAR,
    reviews_from_users VARCHAR,
    reviews_from_critics VARCHAR
);
--https: / / stackoverflow.com / questions / 38481829 / postgresql - character - with - byte - sequence - 0xc2 - 0x81 - in - encoding - utf8 - has - no - equ
--https: / / stackoverflow.com / questions / 48872965 / postgres - copy - syntax
--   psql -c \copy moviesraw FROM 'C:/Users/Bruker/_projects/git/movie-database/data/IMDb movies_utf8.csv' WITH DELIMITER ',' CSV HEADER