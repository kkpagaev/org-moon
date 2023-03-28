require "./config/application"

month = Time.utc
# events = Event.all("JOIN days d ON d.id = events.day_id
# WHERE d.date ~ '^[0-9]{2}.#{month.month}.#{month.year}'
# GROUP BY d.date
# ")
days = Day.all("JOIN events e ON e.day_id = day.id
               WHERE date ~ '^[0-9]{2}.#{month.month}.#{month.year}'")
debugger
