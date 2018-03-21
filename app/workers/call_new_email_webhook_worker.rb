class CallNewMailWebhookWorker
  include Sidekiq::Worker

  def perform(mail_log_id, in_reply_to, raw_eml)
    begin
      mail_log = MailLog.find(mail_log_id)
    rescue ActiveRecord::RecordNotFound
      Log.info("Record not found in CallNewMailWebhookWorker while tracking a new mail log with id: #{mail_log_id}")
      return
    end

    CallNewMailWebhook.new(mail_log, in_reply_to, raw_eml).run
  end
end