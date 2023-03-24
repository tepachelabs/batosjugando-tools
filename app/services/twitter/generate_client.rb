class Twitter::GenerateClient
  def self.call(access_token = nil, access_token_secret = nil)
    return unless BatosJugando.twitter?

    Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.twitter[:consumer_key]
      config.consumer_secret     = Rails.application.credentials.twitter[:consumer_secret]
      config.access_token        = access_token.presence
      config.access_token_secret = access_token_secret.presence
    end
  end
end
