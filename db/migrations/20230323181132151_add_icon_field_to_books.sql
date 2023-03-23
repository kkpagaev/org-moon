-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
ALTER TABLE books
ADD COLUMN icon VARCHAR(255) NOT NULL DEFAULT 'gg-file';
-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
ALTER TABLE books
DROP COLUMN icon;
