class Twitter::OAuthService
  def initialize(access_token_client = nil)
    @access_token_client = access_token_client || Twitter::AccessTokenClient.new
  end

  def access_token
    oauth.get_request_token(oauth_callback: redirect_url)
  end

  def access_token_url(token)
    token_url(token)
  end

  def update_access_token(user, request_token, validation_token)
    response = @access_token_client.access_token(request_token, validation_token)

    configuration = PublishConfiguration.find_or_create_by(admin_user: user)
    configuration.update(twitter_oauth_token: response.oauth_token,
                         twitter_oauth_token_secret: response.oauth_token_secret)
  end

  private

  def oauth
    OAuth::Consumer.new(Rails.application.credentials.twitter[:consumer_key],
                        Rails.application.credentials.twitter[:consumer_secret],
                        site: twitter_api_url)
  end

  def token_url(token)
    "https://api.twitter.com/oauth/authorize?oauth_token=#{token}"
  end

  def twitter_api_url
    'https://api.twitter.com'
  end

  def redirect_url
    Rails.application.credentials[Rails.env.to_sym][:twitter][:redirect_url]
  end
end
