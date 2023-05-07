require "sidekiq"
require "sidekiq/cli"
require "./workers/*"
require "moon-markdown"
require "crest"

require "./google/*"

require "../config/application"
require "./markdown"

# Monkey patch to use connection pool
class Redis::PooledClient
  def initialize(*args, pool_size = 5, pool_timeout = 5.seconds, **args2)
    @pool = ConnectionPool(Redis).new(capacity: pool_size, timeout: 5.seconds) do
      Redis.new(*args, **args2)
    end
  end
end

cli = Sidekiq::CLI.new
server = cli.configure do |config|
  # middleware would be added here
  config.redis = Sidekiq::RedisConfig.new("localhost", 6379)
end

cli.run(server)
