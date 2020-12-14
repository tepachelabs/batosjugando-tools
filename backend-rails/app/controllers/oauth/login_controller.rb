class Oauth::LoginController < ApplicationController
  before_action :require_admin_login

  def twitter_login
    request_token = twitter_oauth_service.access_token
    request.session[:twitter_oauth_token] = request_token.token
    request.session[:twitter_oauth_token_secret] = request_token.secret

    redirect_to twitter_oauth_service.access_token_url(request_token.token)
  end

  def twitter_redirect
    same_token = request.session[:twitter_oauth_token] == params[:oauth_token]

    raise 'Different Twitter token!' unless same_token

    twitter_oauth_service.update_access_token(current_admin_user, params[:oauth_token], params[:oauth_verifier])

    redirect_to admin_dashboard_path
  end

  def reddit_login
    redirect_to reddit_oauth_service.login_url
  end

  def reddit_redirect
    reddit_oauth_service.get_authorization_token(current_admin_user, params[:code]) if current_admin_user.present?

    redirect_to admin_dashboard_path
  end

  private

  def twitter_oauth_service
    @twitter_oauth_service ||= Twitter::OAuth.new
  end

  def reddit_oauth_service
    @reddit_oauth_service ||= Reddit::OAuth.new
  end
end
