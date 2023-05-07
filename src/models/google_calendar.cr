class GoogleCalendar < Granite::Base
  connection pg
  table google_calendars

  belongs_to :user

  column id : Int64, primary: true
  column google_id : String?

  def self.find_or_create(user_id)
    calendar = GoogleCalendar.find_by(user_id: user_id)
    if calendar.nil?
      calendar = GoogleCalendar.new(user_id: user_id)
      token = Tokens.find_by!(user_id: user_id).access_token
      res = Google.add_calendar token
      calendar.google_id = res["id"].to_s
      calendar.save
    end
    calendar
  end

  def list_events(date)
    token = user.tokens!.access_token

    Google.list_events token, google_id, date
  end

  def add_event(event)
    token = user.tokens!.access_token
    Google.add_event token, google_id, event
  end

  def delete_events(date)
    ids = [] of String
    list_events(date)["items"].as_a.each do |event|
      ids << event["id"].to_s
    end
    ids.each do |id|
      delete_event(id)
    end
  end

  private def delete_event(id)
    token = user.tokens!.access_token
    Google.delete_event token, google_id, id
  end

  timestamps
end
