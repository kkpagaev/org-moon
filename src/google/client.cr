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
      s << "https://accounts.google.com/o/oauth2/v2/auth?"
      s << "client_id=#{config.client_id}"
      s << "&redirect_uri=#{config.redirect_uri}"
      s << "&response_type=code"
      s << "&scope=https://www.googleapis.com/auth/userinfo.email "
      s << "https://www.googleapis.com/auth/admin.directory.resource.calendar"
    end
  end
end
