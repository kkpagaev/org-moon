# "client_id": "647260528726-i4ajbc3sf2sav1va79qadhbrbn71gc5i.apps.googleusercontent.com",
# "project_id": "org-moon",
# "auth_uri": "https://accounts.google.com/o/oauth2/auth",
# "token_uri": "https://oauth2.googleapis.com/token",
# "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
# "client_secret": "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",
# "redirect_uris": ["http://127.0.0.1:3000"]

module Google
  class Config
    property! client_id : String
    property! project_id : String
    property! auth_uri : String
    property! token_uri : String
    property! auth_provider_x509_cert_url : String
    property! client_secret : String

    def initialize
    end
  end

  def self.config
    @@config ||= Config.new
  end

  def self.config(&block)
    yield config
  end
end
