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
      "code" => code,
      "client_id" => config.client_id,
      "client_secret" => config.client_secret,
      "redirect_uri" => config.redirect_uri,
      "grant_type" => "authorization_code",
    }, json: true)

    Hash(String, String | Int32).from_json(res.body)
  end

  def self.add_calendar(token)
    res = Crest.post("https://www.googleapis.com/calendar/v3/calendars", {
      "summary" => "Test Calendar",
    },
      headers: {
        "Authorization" => "Bearer #{token}"
      },
      json: true)
    JSON.parse(res.body)
  end


  def self.add_event(token, calendar_id)
    res = Crest.post("https://www.googleapis.com/calendar/v3/calendars/#{calendar_id}/events", {
      "summary" => "Test Event",
      "start" => {
        "dateTime" => "2023-05-09T13:00:00",
        "timeZone" => "America/Los_Angeles",
      },
      "end" => {
        "dateTime" => "2023-05-09T19:00:00",
        "timeZone" => "America/Los_Angeles",
      },
    },
      headers: {
        "Authorization" => "Bearer #{token}"
      },
      json: true)
  end
end
