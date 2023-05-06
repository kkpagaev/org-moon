-- +micrate Up
CREATE TABLE tokens (
  id BIGSERIAL PRIMARY KEY,
  refresh_token VARCHAR,
  access_token VARCHAR,
  expires_in INT,
  user_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX tokens_user_id_idx ON tokens (user_id);

-- +micrate Down
DROP TABLE IF EXISTS tokens;
