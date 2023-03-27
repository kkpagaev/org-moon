.calendar-wrapper
  h1
    | December 2022
  ol.calendar
    li.first-day
      | 1
    - 30.times do |i|
      li
        .calendar--number
          | #{i + 2}
        a href="/day/#{i + 2}.12.2022"
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
