class GoogleCaledarWorker
  include Sidekiq::Worker

  def perform(name : String, count : Int64)
    count.times do
      logger.info "hello, #{name}!"
    end
  end
end

