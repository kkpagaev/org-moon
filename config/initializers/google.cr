require "json"

# "client_id": "647260528726-i4ajbc3sf2sav1va79qadhbrbn71gc5i.apps.googleusercontent.com",
# "project_id": "org-moon",
# "auth_uri": "https://accounts.google.com/o/oauth2/auth",
# "token_uri": "https://oauth2.googleapis.com/token",
# "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
# "client_secret": "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",
# "redirect_uris": ["http://127.0.0.1:3000"]

Google.config do |config|
  file = File.new("secrets/google_client.json")
  data = JSON.parse(file)["web"]
  file.close

  config.client_id = data["client_id"].to_s
  config.project_id = data["project_id"].to_s
  config.auth_uri = data["auth_uri"].to_s
  config.token_uri = data["token_uri"].to_s
  config.auth_provider_x509_cert_url = data["auth_provider_x509_cert_url"].to_s
  config.client_secret = data["client_secret"].to_s
  # move to env
  config.redirect_uri = "http://localhost:3000/oauth2/callback"
end
