class ApplicationController < ActionController::Base
  before_action :set_raven_context

  private

  def require_admin_login
    redirect_to admin_dashboard_path if current_admin_user.nil?
  end

  def set_raven_context
    Sentry.user_context(id: session[:current_user_id]) # or anything else in session
    Sentry.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
