class CallUserConnectedWebhookWorker
  include Sidekiq::Worker

  def perform(user_id)
    begin
      user = User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      Log.info("Record not found in CallUserConnectedWebhookWorker while connecting a user with id: #{user_id}")
      return
    end

    CallUserConnectedWebhook.new(user).run
  end
end