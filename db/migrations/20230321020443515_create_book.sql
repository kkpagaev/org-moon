-- +micrate Up
CREATE TABLE books (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT,
  title TEXT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX book_user_id_idx ON books (user_id);

-- +micrate Down
DROP TABLE IF EXISTS books;
