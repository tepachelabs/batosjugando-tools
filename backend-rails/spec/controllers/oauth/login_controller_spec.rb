describe Oauth::LoginController do
  fixtures :admin_users

  login_admin

  context '#twitter_login' do
    let(:twitter_oauth_service) { double }
    let(:the_token) { 'some_token' }
    let(:the_secret) { 'some_secretz' }
    let(:redirect_url) { 'http://localhost:3000/redirect' }

    before do
      expect(Twitter::OAuthService).to receive(:new)
        .and_return(twitter_oauth_service)
    end

    subject { get :twitter_login }

    it 'is a succesful redirect' do
      allow(twitter_oauth_service).to receive(:access_token)
        .and_return(double(token: the_token,
                           secret: the_secret))

      allow(twitter_oauth_service).to receive(:access_token_url).with(the_token)
                                                                .and_return(redirect_url)

      expect(subject).to redirect_to(redirect_url)
      expect(@request.session[:twitter_oauth_token]).to be(the_token)
      expect(@request.session[:twitter_oauth_token_secret]).to be(the_secret)
    end
  end

  context '#reddit_login' do
    let(:reddit_oauth_service) { double }
    let(:redirect_url) { 'http://localhost:3000/redirect' }

    before do
      expect(Reddit::OAuthService).to receive(:new)
        .and_return(reddit_oauth_service)
    end

    subject { get :reddit_login }

    it 'is a succesful redirect' do
      allow(reddit_oauth_service).to receive(:login_url)
        .and_return(redirect_url)

      expect(subject).to redirect_to(redirect_url)
    end
  end
end
