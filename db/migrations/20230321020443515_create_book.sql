-- +micrate Up
CREATE TABLE books (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT,
  is_system BOOLEAN DEFAULT FALSE,
  is_hidden BOOLEAN DEFAULT FALSE,
  title TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX book_user_id_idx ON books (user_id);

-- +micrate Down
DROP TABLE IF EXISTS books;
