class BaseJob
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 3
end
