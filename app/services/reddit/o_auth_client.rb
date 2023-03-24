class Reddit::OAuthClient < Reddit::BaseClient
  base_uri 'https://www.reddit.com'

  def get_token(code)
    self.class.post('/api/v1/access_token',
                    basic_auth: auth,
                    body: auth_body(code),
                    headers: @headers)
  end

  def refresh_token(token)
    self.class.post('/api/v1/access_token',
                    basic_auth: auth,
                    body: refresh_body(token),
                    headers: @headers)
  end

  private

  def auth
    { username: reddit_client_id, password: reddit_client_secret }
  end

  def auth_body(code)
    %W[
      grant_type=authorization_code
      code=#{code}
      redirect_uri=#{reddit_redirect_url}
    ].join('&')
  end

  def refresh_body(refresh_token)
    %W[
      grant_type=refresh_token
      refresh_token=#{refresh_token}
    ].join('&')
  end
end
