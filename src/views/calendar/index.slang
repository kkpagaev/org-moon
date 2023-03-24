.calendar
  .calendar__header
    .calendar__header__month
      .calendar__header__month__name
        | January
      .calendar__header__month__year
        | 2016
  .calendar__month
    - 5.times do |i|
      .calendar__week
        - 7.times do |j|
          .calendar__day
            .calendar__day__number
              = i * 7 + j + 1
            .calendar__day__events
              .calendar__day__event
                .calendar__day__event__time
                .calendar__day__event__title
                .calendar__day__event__description

