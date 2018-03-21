require 'sidekiq/web'
Rails.application.routes.draw do

  authenticate :admin_user, lambda { |u| ENV['SIDEKIQ_ADMINS'].split(',').include? u.email } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resources :connections, { :param => :imap_provider_code } do
        resources :users, { :param => :tag }
      end
    end
  end

  namespace :users do
    resource :connect, :only => [:new] do
      get :callback
    end

    resource :disconnect, :only => [:new] do
      get :callback
    end
  end

  post 'webhook_test/new_mail'
  post 'webhook_test/user_connected'
  post 'webhook_test/user_disconnected'
end
