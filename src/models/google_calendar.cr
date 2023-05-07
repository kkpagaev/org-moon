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

  def list_events
    token = user.tokens!.access_token
    Google.list_events token, google_id
  end

  def add_event
    token = user.tokens!.access_token
    Google.add_event token, google_id
  end

  timestamps
end
