require "moon-markdown"
require "crest"
require "sidekiq"
require "sidekiq/cli"

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
if ENV["RUN_SIDEKIQ"]?
  cli = Sidekiq::CLI.new
  server = cli.configure do |config|
    # middleware would be added here
    config.redis = Sidekiq::RedisConfig.new("localhost", 6379)
  end

  cli.run(server)
else
  Amber::Support::ClientReload.new if Amber.settings.auto_reload?
  Amber::Server.start
end
