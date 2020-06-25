class Oauth::LoginController < ApplicationController

  def reddit_login
    redirect_to reddit_oauth_service.login_url
  end

  def reddit_redirect
    reddit_oauth_service.get_authorization_token(current_admin_user, params[:code]) if current_admin_user.present?

    redirect_to admin_dashboard_path
  end

  private

  def reddit_oauth_service
    @reddit_oauth_service ||= Reddit::OAuthService.new
  end

end
