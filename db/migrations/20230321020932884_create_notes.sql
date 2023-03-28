-- +micrate Up
CREATE TABLE notes (
  id BIGSERIAL PRIMARY KEY,
  user_id BIGINT,
  book_id BIGINT,
  title TEXT,
  body TEXT,
  is_hidden BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX notes_user_id_idx ON notes (user_id);
CREATE INDEX notes_book_id_idx ON notes (book_id);

-- +micrate Down
DROP TABLE IF EXISTS notes;
