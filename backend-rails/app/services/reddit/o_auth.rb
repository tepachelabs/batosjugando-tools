class Reddit::OAuth
  include Reddit::Credentials

  def initialize(authorization_token = nil)
    @authorization_token = authorization_token || Reddit::AuthorizationToken.new
  end

  def login_url
    reddit_login_url
  end

  def get_authorization_token(admin_user, code)
    @authorization_token.get_token(admin_user, code)
  end

  def refresh_authorization_token(publish_configuration)
    @authorization_token.refresh_token(publish_configuration)
  end

  private

  def reddit_login_url
    %W[https://www.reddit.com/api/v1/authorize?
       client_id=#{reddit_client_id}&
       response_type=code&
       state=batosjugando&
       redirect_uri=#{CGI.escape(reddit_redirect_url)}&
       duration=permanent&
       scope=#{CGI.escape(reddit_api_scope)}].join
  end

  def reddit_api_scope
    'identity edit submit save vote flair'
  end
end
