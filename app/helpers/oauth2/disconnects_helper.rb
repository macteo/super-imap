require 'uri'

module Oauth2::DisconnectsHelper
  def oauth2_new_helper
    # Disconnect the user. Assume that this succeeds.
    token = self.user.oauth2_refresh_token_secure || ""
    url = "https://accounts.google.com/o/oauth2/revoke?token=#{URI.escape(token)}"
    Net::HTTP.get_response(URI(url))

    ActiveRecord::Base.transaction do
      # Throw away our credentials.
      user.update_attributes!(
        :email                => nil,
        :oauth2_refresh_token => nil,
        :connected_at         => nil)

      CallUserDisconnectedWebhook.new(user).run
    end

    redirect_to_success_url
  rescue => e
    Log.exception(e)
    redirect_to_failure_url
  end
end
