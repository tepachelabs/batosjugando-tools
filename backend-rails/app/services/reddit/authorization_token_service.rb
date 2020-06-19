class Reddit::AuthorizationTokenService
  def initialize(oauth_client = nil)
    @oauth_client = oauth_client || Reddit::OAuthClient.new
  end

  def get_token(admin_user, code)
    reddit_token = if admin_user.reddit_token.present?
                     admin_user.reddit_token
                   else
                     RedditToken.find_or_create_by(admin_user_id: admin_user.id)
                   end

    response = @oauth_client.get_token(code)

    reddit_token.update(auth_token: response['access_token'], refresh_token: response['refresh_token'])
  end

  def refresh_token(reddit_token)
    response = @oauth_client.refresh_token(reddit_token.refresh_token)
    reddit_token.update(auth_token: response['access_token'])
  end
end
