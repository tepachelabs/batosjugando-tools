class ApplicationController < ActionController::Base
  before_action :set_sentry_context

  private

  def require_admin_login
    redirect_to admin_dashboard_path if current_admin_user.nil?
  end

  def set_sentry_context
    Sentry.with_scope do |scope|
      scope.set_user(id: session[:current_user_id])
      scope.set_extras(params: params.to_unsafe_h, url: request.url)
    end
  end
end
