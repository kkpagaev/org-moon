require "jwt"
require "../../src/jwt"

JWT.config do |config|
  config.secret = ENV["JWT_SECRET"]? || "secret"
end
