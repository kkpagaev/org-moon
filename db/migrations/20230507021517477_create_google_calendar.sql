-- +micrate Up
CREATE TABLE google_calendars (
  id BIGSERIAL PRIMARY KEY,
  google_id VARCHAR,
  user_id BIGINT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
CREATE INDEX google_calendar_user_id_idx ON google_calendars (user_id);

-- +micrate Down
DROP TABLE IF EXISTS google_calendars;
