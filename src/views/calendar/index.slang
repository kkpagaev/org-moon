.calendar-wrapper
  h1
    | December 2022
  ol.calendar
    li.first-day
      | 1
    - 30.times do |i|
      li
        = i + 2
