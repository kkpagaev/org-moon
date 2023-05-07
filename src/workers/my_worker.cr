require "sidekiq"

module Sample
  class MyWorker
    include Sidekiq::Worker

    def perform(name : String, count : Int64)
      count.times do
        logger.info do
          "Hello, #{name}!"
        end
      end
    end
  end
end
