class CallUserDisconnectedWebhookWorker
  include Sidekiq::Worker

  def perform(user_id)
    begin
      user = User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      Log.info("Record not found in CallUserDisconnectedWebhookWorker while disconnecting a user with id: #{user_id}")
      return
    end

    CallUserDisconnectedWebhook.new(user).run
  end
end