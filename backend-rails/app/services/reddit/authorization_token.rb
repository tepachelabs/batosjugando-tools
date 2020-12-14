class Reddit::AuthorizationToken
  def initialize(oauth_client = nil)
    @oauth_client = oauth_client || Reddit::OAuthClient.new
  end

  def get_token(user, code)
    publish_config =
      if user.publish_configuration.present?
        user.publish_configuration
      else
        PublishConfiguration.find_or_create_by(admin_user: user)
      end

    response = @oauth_client.get_token(code)

    publish_config.update(reddit_token: response['access_token'], reddit_refresh_token: response['refresh_token'])
  end

  def refresh_token(publish_config)
    response = @oauth_client.refresh_token(publish_config.reddit_refresh_token)
    publish_config.update(reddit_token: response['access_token'])
  end
end
