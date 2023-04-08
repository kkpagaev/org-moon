.calendar-wrapper
  h1
    | #{@month.month_name} #{@month.year}
  a href="/calendar/#{@month.prev_month.to_s("%m.%Y")}"
    | < Prev
  a href="/calendar/#{@month.next_month.to_s("%m.%Y")}"
    | Next >
  ol.calendar
    - today = Time.utc
    - @month.calendar_offset.times  do
      li
    - @month.days_in_month.times do |i|
      - active = (i+1) == today.day && @month.month == today.month && @month.year == today.year ? "active" : ""
      li
        a href="/day/#{Time.utc(@month.year, @month.month, i + 1).to_s("%d.%m.%Y")}"
          .calendar--day class=active
            .calendar--number
              | #{i + 1}
            .calendar--content
                - day = days.find {|d| d.date[0..1].to_i == i + 1}
                - if day
                  .calendar--content__tags
                    - day.note.tags.each do |tag|
                      span.tag style="background-color: #{tag.color}; color: #{tag.text_color}"
                        == tag.name.to_s
                  .calendar--content__events
                      - day.events.each do |event|
                          | #{event.to_s}
                        br
