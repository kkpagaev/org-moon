.calendar-wrapper
  h1
    | #{@month.month_name} #{@month.year}
  a href="/calendar/#{@month.prev_month.month}.#{@month.prev_month.year}"
    | < Prev
  a href="/calendar/#{@month.next_month.month}.#{@month.next_month.year}"
    | Next >
  ol.calendar
    - today = Time.utc
    - @month.calendar_offset.times  do
      li
    - @month.days_in_month.times do |i|
      - active = (i+1) == today.day && @month.month == today.month && @month.year == today.year ? "active" : ""
      li
        a href="/day/#{i + 1}.#{@month.month}.#{@month.year}"
          .calendar--day class=active
            .calendar--number
              | #{i + 1}
            .calendar--content
