class ScheduleTracerEmailsWorker
  include Sidekiq::Worker

  def perform(user_id, num_tracers)
    begin
      user = User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      Log.info("Record not found in ScheduleTracerEmailsWorker while scheduling a tracer email user with id: #{user_id}")
      return
    end

    ScheduleTracerEmails.new(user, num_tracers).run
  end
end