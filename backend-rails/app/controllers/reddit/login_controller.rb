class Reddit::LoginController < ApplicationController
  def login
    redirect_to oauth_service.login_url
  end

  def redirect
    oauth_service.get_authorization_token(current_admin_user, params[:code]) if current_admin_user.present?

    redirect_to admin_dashboard_path
  end

  private

  def oauth_service
    @oauth_service = Reddit::OAuthService.new
  end
end
