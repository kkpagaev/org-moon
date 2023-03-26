-- +micrate Up
CREATE TABLE days (
  id BIGSERIAL PRIMARY KEY,
  date VARCHAR NOT NULL,
  note_id BIGINT,
  user_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX day_note_id_idx ON days (note_id);
CREATE INDEX day_user_id_idx ON days (user_id);

-- +micrate Down
DROP TABLE IF EXISTS days;
