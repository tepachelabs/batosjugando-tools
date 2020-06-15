class Reddit::AuthorizationTokenService
  include Reddit::Credentials

  def call(admin_user, code)
    # maybe here... check for the refresh token?
    reddit_token = if admin_user.reddit_token.present?
                     admin_user.reddit_token
                   else
                     RedditToken.find_or_create(admin_user_id: admin_user.id)
                   end

    response = connection(code)

    reddit_token.update(auth_token: response['access_token'], refresh_token: response['refresh_token'])
  end

  private

  def connection(code)
    HTTParty.post(reddit_authorization_token_url,
                  basic_auth: auth,
                  body: body(code),
                  headers: { 'Content-Type' => 'application/x-www-form-urlencoded' })
  end

  def auth
    { username: reddit_client_id, password: reddit_client_secret }
  end

  def body(code)
    %W[
      grant_type=authorization_code
      code=#{code}
      redirect_uri=#{reddit_redirect_url}
    ].join('&')
  end

  def reddit_authorization_token_url
    'https://www.reddit.com/api/v1/access_token'
  end
end
