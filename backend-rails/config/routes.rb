Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  require 'sidekiq/web'

  authenticate :admin_user, ->(u) { u.present? } do
    mount Sidekiq::Web => '/admin/sidekiq'
  end

  namespace :reddit do
    get '/login', to: 'login#login'
    get '/redirect', to: 'login#redirect'
  end

  namespace :oauth do
    get '/twitter/login', to: 'login#twitter_login'
    get '/twitter', to: 'login#twitter_redirect'

    get '/reddit/login', to: 'login#reddit_login'
    get '/reddit', to: 'login#reddit_redirect'
  end
end
