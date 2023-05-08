module Google
  class Config
    property! client_id : String
    property! project_id : String
    property! auth_uri : String
    property! token_uri : String
    property! auth_provider_x509_cert_url : String
    property! client_secret : String
    property! redirect_uri : String

    def initialize
    end
  end

  def self.config
    @@config ||= Config.new
  end

  def self.config(&block)
    yield config
  end

  def self.url
    config = self.config
    String.build do |s|
      s << config.auth_uri
      s << "?client_id=#{config.client_id}"
      s << "&redirect_uri=#{config.redirect_uri}"
      s << "&response_type=code"
      s << "&access_type=offline&prompt=consent"
      s << "&scope=https://www.googleapis.com/auth/userinfo.email "
      s << "https://www.googleapis.com/auth/calendar"
    end
  end

  def self.exchange_code(code)
    config = self.config

    res = Crest.post(config.token_uri, {
      "code"          => code,
      "client_id"     => config.client_id,
      "client_secret" => config.client_secret,
      "redirect_uri"  => config.redirect_uri,
      "grant_type"    => "authorization_code",
    }, json: true)

    Hash(String, String | Int32).from_json(res.body)
  end

  def self.add_calendar(token)
    res = Crest.post("https://www.googleapis.com/calendar/v3/calendars", {
      "summary" => "Org-Moon",
    },
      headers: {
        "Authorization" => "Bearer #{token}",
      },
      json: true)
    JSON.parse(res.body)
  end

  def self.add_event(token, calendar_id, event : Event)
    start = (event.start_at - 3.hour).to_rfc3339
    end_at = (e = event.end_at) ? (e - 3.hour).to_rfc3339 : (event.start_at - 3.hour).to_rfc3339
    res = Crest.post("https://www.googleapis.com/calendar/v3/calendars/#{calendar_id}/events", {
      "summary" => event.title,
      "description" => event.description,
      "start"   => {
        "dateTime" => start,
        "timeZone" => "Europe/Kiev",
      },
      "end" => {
        "dateTime" => end_at,
        "timeZone" => "Europe/Kiev",
      },
    },
      headers: {
        "Authorization" => "Bearer #{token}",
      },
      json: true)
  end

  def self.list_events(token, calendar_id, date)
    query = String.build do |s|
      s << "timeMax=#{(date + 1.day).to_rfc3339}"
      s << "&timeMin=#{date.to_rfc3339}"
    end

    res = Crest.get("https://www.googleapis.com/calendar/v3/calendars/#{calendar_id}/events?#{query}",
      headers: {
        "Authorization" => "Bearer #{token}",
      },
      json: true)
    JSON.parse(res.body)
  end

  def self.delete_event(token, calendar_id, event_id)
    res = Crest.delete("https://www.googleapis.com/calendar/v3/calendars/#{calendar_id}/events/#{event_id}",
      headers: {
        "Authorization" => "Bearer #{token}",
      },
    )
  end

  def self.refresh_tokens(refresh_token)
    config = self.config

    puts "refreshing tokens"
    res = Crest.post("https://oauth2.googleapis.com/token", {
      "client_id"     => config.client_id,
      "client_secret" => config.client_secret,
      "grant_type"    => "refresh_token",
      "refresh_token" => refresh_token,
    }, json: true)

    Hash(String, String | Int32).from_json(res.body)
  end
end
