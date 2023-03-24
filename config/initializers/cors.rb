Rails.application.config.middleware.insert_before 0, Rack::Cors do
  # Be sure to restart your server when you modify this file.
  allow do
    origins '*'
    # Avoid CORS issues when API is called from the frontend app.
    resource '*', headers: :any, methods: %i[get post patch put]
    # Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.
  end
end
