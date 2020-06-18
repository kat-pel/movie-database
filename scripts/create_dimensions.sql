-- dimension table for genres
drop table if exists genres;
SELECT DISTINCT TRIM(
        BOTH
        FROM genre
    ) AS genre INTO genres
FROM (
        SELECT DISTINCT unnest(string_to_array(genre, ',')) as genre
        FROM moviesraw
    ) as subq;
ALTER TABLE genres
add id SERIAL PRIMARY KEY;
--
--
--
--
--
--
--
--
--
--
-- dimension table for languages
drop table if exists languages;
SELECT DISTINCT TRIM(
        BOTH
        FROM language
    ) AS language INTO languages
FROM (
        SELECT DISTINCT unnest(string_to_array(language, ',')) as language
        FROM moviesraw
    ) as subq;
ALTER TABLE languages
add id SERIAL PRIMARY KEY;
--
--
--
--
--
--
--
--
-- dimension table for country column
drop table if exists countries;
SELECT DISTINCT TRIM(
        BOTH
        FROM country
    ) AS country INTO countries
FROM (
        SELECT DISTINCT unnest(string_to_array(country, ',')) as country
        FROM moviesraw
    ) as subq;
ALTER TABLE countries
add id SERIAL PRIMARY KEY;
--
--
--
--
--
--
--
--
-- movies dimension table
drop table if exists movies;
SELECT NULLIF(regexp_replace(imdb_title_id, '\D', '', 'g'), '')::numeric AS id,
    title,
    year,
    duration,
    director,
    actors,
    avg_vote,
    votes INTO movies
FROM moviesraw;
ALTER TABLE movies
ADD PRIMARY KEY (id);
--
--
--
--
--
--
--
-- create MovieGenreBridge  table
drop table if exists MovieGenreBridge;
CREATE TABLE MovieGenreBridge (
    movie_id int REFERENCES movies (id) ON UPDATE CASCADE ON DELETE CASCADE,
    genre_id int REFERENCES genres (id) ON UPDATE CASCADE,
    CONSTRAINT movie_genre_id PRIMARY KEY (movie_id, genre_id) --CONSTRAINT movie_genre_id PRIMARY KEY (movie_id, genre_id),
    --FOREIGN KEY (movie_id) REFERENCES movies (imdb_title_id),
    --FOREIGN KEY (genre_id) REFERENCES genres (id)
);
--
--
--
--
--
SELECT movie,
    genre
FROM StudentClassroom
    JOIN movies ON movies.id = MovieGenreBridge.movie_id
    JOIN genres ON genres.id = MovieGenreBridge.genre_id create table movie_category_junction (
        movie_id int,
        category_id int,
        CONSTRAINT movie_cat_pk PRIMARY KEY (movie_id, category_id),
        CONSTRAINT FK_movie FOREIGN KEY (movie_id) REFERENCES movie (movie_id),
        CONSTRAINT FK_category FOREIGN KEY (category_id) REFERENCES category (category_id)
    );
--
--
--
SELECT TRIM(
        BOTH
        FROM subq.genre
    ) AS genre,
    NULLIF(
        regexp_replace(subq.imdb_title_id, '\D', '', 'g'),
        ''
    )::numeric AS movies_id,
    genres.id as genres_id
FROM (
        SELECT unnest(string_to_array(genre, ',')) as genre,
            imdb_title_id
        FROM moviesraw
    ) as subq
    LEFT JOIN genres ON subq.genre = genres.genre
ORDER BY movies_id