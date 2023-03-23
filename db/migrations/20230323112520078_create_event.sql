-- +micrate Up
CREATE TABLE events (
  id BIGSERIAL PRIMARY KEY,
  title VARCHAR,
  description VARCHAR,
  note_id BIGINT,
  start_at TIMESTAMP,
  end_at TIMESTAMP,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX event_note_id_idx ON events (note_id);

-- +micrate Down
DROP TABLE IF EXISTS events;
