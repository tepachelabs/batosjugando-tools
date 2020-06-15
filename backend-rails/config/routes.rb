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
end
