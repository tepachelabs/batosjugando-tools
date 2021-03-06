module Reddit::Credentials
  def reddit_client_id
    Rails.application.credentials[Rails.env.to_sym][:reddit][:app_id]
  end

  def reddit_client_secret
    Rails.application.credentials[Rails.env.to_sym][:reddit][:app_secret]
  end

  def reddit_redirect_url
    Rails.application.credentials[Rails.env.to_sym][:reddit][:redirect_url]
  end
end
