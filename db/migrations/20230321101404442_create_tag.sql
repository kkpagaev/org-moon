-- +micrate Up
CREATE TABLE tags (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT,
  name VARCHAR,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE INDEX tags_user_id_idx ON tags (user_id);

CREATE TABLE tagging (
  id BIGSERIAL PRIMARY KEY,
  tag_id BIGINT,
  note_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

CREATE INDEX tagging_tag_id_idx ON tagging (tag_id);
CREATE INDEX tagging_note_id_idx ON tagging (note_id);

-- +micrate Down
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS tagging;
