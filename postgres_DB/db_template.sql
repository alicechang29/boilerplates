-- Run: psql -f db_template.sql <dbName>

DROP TABLE users CASCADE;
DROP TABLE locations;
DROP TABLE temporary;

CREATE TABLE users(
    id INT NOT NULL,
    user_name VARCHAR(25) NOT NULL,
    user_age SMALLINT NOT NULL,
    user_fav_color VARCHAR(20) NOT NULL,
    PRIMARY KEY(user_id)
);

CREATE TABLE locations(
    id INT GENERATED ALWAYS AS IDENTITY,
    user_id INT NOT NULL,
    last_location VARCHAR(50) NOT NULL,
    lat DECIMAL(9,6) NOT NULL,
    long DECIMAL(9,6) NOT NULL,
    PRIMARY KEY(id),
    CONSTRAINT fk_user
        FOREIGN KEY(user_id)
            REFERENCES users(user_id)
);

CREATE TABLE temporary(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id INT NOT NULL,
    user_name VARCHAR(25) NOT NULL,
    user_age SMALLINT NOT NULL,
    user_fav_color VARCHAR(20) NOT NULL,
    last_location VARCHAR(50) NOT NULL,
    lat DECIMAL(9,6) NOT NULL,
    long DECIMAL(9,6) NOT NULL
);

COPY temporary(user_id, user_name, user_age, user_fav_color, last_location, lat, long)
FROM '/Users/alicechang/Documents/repos/boilerplates/postgres_DB/users.csv'
DELIMITER ','
CSV HEADER;

INSERT INTO users(user_id, user_name, user_age, user_fav_color)
SELECT t.user_id, t.user_name, t.user_age, t.user_fav_color
FROM temporary t
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO locations(user_id, last_location, lat, long)
SELECT t.user_id, t.last_location, t.lat, t.long
FROM temporary t
