Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  ActiveAdmin.routes(self)

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  require 'sidekiq/web'

  authenticate :admin_user, ->(u) { u.present? } do
    mount Sidekiq::Web => '/admin/sidekiq'
  end

  namespace :oauth do
    get '/twitter/login', to: 'login#twitter_login'
    get '/twitter', to: 'login#twitter_redirect'

    get '/reddit/login', to: 'login#reddit_login'
    get '/reddit', to: 'login#reddit_redirect'
  end

  namespace :api do
    get 'juegathon/participants', to: 'juegathon#participants'
  end
end
