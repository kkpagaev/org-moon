require "sidekiq"

module Sample
  class MyWorker
    include Sidekiq::Worker

    def perform(name : String, count : Int64)
      count.times do
        puts "Hello #{name}"
      end
    end
  end
end
