-- psql -U postgres -d highland_games -f create_tables.sql

-- Connect to the highland_games database
\c highland_games

DROP TABLE IF EXISTS mark_distance CASCADE;
DROP TABLE IF EXISTS mark_caber CASCADE;
DROP TABLE IF EXISTS event CASCADE;
DROP TABLE IF EXISTS score CASCADE;
DROP TABLE IF EXISTS player CASCADE;
DROP TABLE IF EXISTS class CASCADE;


CREATE TABLE class (
  id SERIAL PRIMARY KEY,
  name VARCHAR (255)
);

CREATE TABLE player (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INTEGER,
  class_id INTEGER NOT NUll,
  FOREIGN KEY (class_id) REFERENCES class(id) ON DELETE CASCADE
);

CREATE TABLE score (
  id SERIAL PRIMARY KEY,
  player_id INTEGER NOT NUll,
  score INTEGER,
  event VARCHAR(255),
  FOREIGN KEY (player_id) REFERENCES player(id) ON DELETE CASCADE
);

CREATE TABLE event (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO event (name)
VALUES
  ('Heavy Weight For Distance'),
  ('Light Weight For Distance'),
  ('Heavy Hammer'),
  ('Light Hammer'),
  ('Caber'),
  ('Sheaf Toss'),
  ('Weight Over Bar'),
  ('Braemer Stone'),
  ('Open Stone');

CREATE TABLE mark_distance (
  id SERIAL PRIMARY KEY,
  foot INTEGER,
  inch INTEGER,
  event_id INTEGER NOT NUll,
  player_id INTEGER NOT NUll,
  FOREIGN KEY (event_id) REFERENCES event(id) ON DELETE CASCADE,
  FOREIGN KEY (player_id) REFERENCES player(id) ON DELETE CASCADE
);

CREATE TABLE mark_caber (
  id SERIAL PRIMARY KEY,
  hour INTEGER,
  minute INTEGER,
  player_id INTEGER NOT NUll,
  FOREIGN KEY (player_id) REFERENCES player(id) ON DELETE CASCADE
);
