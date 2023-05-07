require "moon-markdown"
require "crest"
require "sidekiq"

# Monkey patch to use connection pool
class Redis::PooledClient
  def initialize(*args, pool_size = 5, pool_timeout = 5.seconds, **args2)
    @pool = ConnectionPool(Redis).new(capacity: pool_size, timeout: 5.seconds) do
      Redis.new(host: "redis")
    end
  end
end
require "./google/*"

require "./workers/*"

require "../config/application"
require "./markdown"

Sidekiq::Client.default_context = Sidekiq::Client::Context.new

Amber::Support::ClientReload.new if Amber.settings.auto_reload?
Amber::Server.start
