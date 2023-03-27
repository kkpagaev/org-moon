.calendar-wrapper
  h1
    | #{@month.month_name} #{@month.year}
  a href="/calendar/#{@month.prev_month.month}.#{@month.prev_month.year}"
    | < Prev
  a href="/calendar/#{@month.next_month.month}.#{@month.next_month.year}"
    | Next >
  ol.calendar
    - @month.calendar_offset.times  do
      li
    - @month.days_in_month.times do |i|
      li
        .calendar--number
          | #{i + 1}
        a href="/day/#{i + 1}.12.2022"
          .calendar--content
            | - 8:30 drink milk
            br
            | foo bar test ls fui
            br
            | - 9:00 - 10:00 eat breakfast
            br
            | foo bar test ls fui
            br
            | - 10:00 - 11:00 eat breakfast
            br
            | foo bar test ls fui
            br
            | - 11:00 - 12:00 eat breakfast
            br
