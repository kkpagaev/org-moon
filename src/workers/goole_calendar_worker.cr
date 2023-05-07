require "sidekiq"

class GoogleCaledarWorker
  include Sidekiq::Worker

  # sync events to google calendar
  def perform(day_id : Int64)
    logger.info do
      "GoogleCaledarWorker: #{day_id}"
    end
    day = Day.find!(day_id)
    logger.info do
      "GoogleCaledarWorker: #{day}"
    end
    c = GoogleCalendar.find_or_create(day.user_id)
    logger.info do
      "GoogleCaledarWorker: #{c}"
    end
    c.delete_events(day.date.day_to_date)

    day.events.each do |event|
      c.add_event(event)
    end
  end
end
